#include "stdafx.h"
#include "Model.h"

Model::Model(std::string modelName){
	ifstream paramsfile;
	ifstream biasfile;
	ifstream alphasfile;
	ifstream labelsfile;
	ifstream supVectsfile;

	// read parameters from "MODELNAME_params.dat"
	cout << "Reading parameters...\n";
	paramsfile.open(modelName+"_params.dat", ios::binary);

	// get hue lower convert from 0-360 to 0-180
	paramsfile.read((char*)&hLow, sizeof(int));
	hLow = hLow*180/360;
	// get hue upper convert from 0-360 to 0-180
	paramsfile.read((char*)&hHigh, sizeof(int));
	hHigh = hHigh*180/360;
	// get saturation lower convert from 0-100 to 0-255
	paramsfile.read((char*)&sLow, sizeof(int));
	sLow = sLow*255/100;
	// get saturation upper convert from 0-100 to 0-255
	paramsfile.read((char*)&sHigh, sizeof(int));
	sHigh = sHigh*255/100;
	// get value lower convert from 0-100 to 0-255
	paramsfile.read((char*)&vLow, sizeof(int));
	vLow = vLow*255/100;
	// get value upper convert from 0-100 to 0-255
	paramsfile.read((char*)&vHigh, sizeof(int));
	vHigh = vHigh*255/100;
	// get distance Threshold
	paramsfile.read((char*)&distThresh, sizeof(int));
	// get blob Width
	paramsfile.read((char*)&blobWidth, sizeof(int));
	// get blob Height
	paramsfile.read((char*)&blobHeight, sizeof(int));
	// get cellsize
	paramsfile.read((char*)&cellSize, sizeof(int));

	paramsfile.close();

	// read bias value from "MODELNAME_bias.dat"
	cout << "Reading bias values...\n";
	biasfile.open(modelName+"_bias.dat", ios::binary);
	// get bias as double
	biasfile.read((char*)&bias, sizeof(double));
	biasfile.close();

	// read alpha values from "MODELNAME_alphas.dat"
	cout << "Reading alpha values...\n";
	alphasfile.open(modelName+"_alphas.dat", ios::binary);
	// each alpha value is 8 bytes, read it and push into vector
	double a;
	while( !alphasfile.eof() ){
		alphasfile.read((char*)&a, sizeof(double));
		alphas.push_back(a);
	}
	//remove garbage element
	alphas.pop_back();
	alphasfile.close();

	// read labels from "MODELNAME_labels.dat"
	cout << "Reading labels...\n";
	labelsfile.open(modelName+"_labels.dat" , ios::binary);
	//each line contains 1 or -1, read it and convert to int
	int l;
	while( !labelsfile.eof() ){
		labelsfile.read((char*)&l, sizeof(int));
		labels.push_back(l);
	}
	//remove garbage element
	labels.pop_back();
	labelsfile.close();

	// read support vector values from "MODELNAME_supVects.dat"
	cout << "Reading support vector values...\n";
	supVectsfile.open(modelName+"_supVects.dat", ios::binary);
	int numSupVects = alphas.size(); 
	//read each line, split it by commas, convert each split string to double and build the matrix
	double s1;

	supVects.resize(numSupVects);
	while( !supVectsfile.eof() ){
		vector<double> s;
		for(int i = 0; i<numSupVects; i++){
			supVectsfile.read((char*)&s1, sizeof(double));
			supVects[i].push_back(s1);
		}	
	}
	//remove garbage element
	for(int i = 0; i < numSupVects; i ++){
		supVects[i].pop_back();
	}
	supVectsfile.close();


}

void Model::detectModel(Mat Image){
	Mat filteredIMG = Image;
	filteredIMG = filterImage(Image);

	vector<vector<int> > pixLoc (extractPixLoc(filteredIMG));
	vector<int> clas = segmentImage(pixLoc[0], pixLoc[1]);
	vector<int> classes = getUniqueClasses(clas);
	vector<Rect> BlobsBB =  extractBlobsBB(pixLoc[0], pixLoc[1],clas, classes);
	vector<Mat> Blobs = extractBlobs(Image, BlobsBB);

	for(int i = 0; i < Blobs.size(); i++){
		
		/*
		//convert blobs[i] to grayscale
		Mat Blob;
		cvtColor(Blobs[i], Blob , CV_BGR2GRAY);

		//Mat Blobf = Mat(Blob.rows, Blob.cols, CV_32F, 0.0);
		float* Blobf = new float[Blob.rows*Blob.cols];
		//Blob.convertTo(Blobf, CV_32F);
		
		int j = 0;
		for(int row = 0; row < Blob.rows; ++row) {
			uchar* c = Blob.ptr(row);
			for(int col = 0; col < Blob.cols; ++col) {
				*(Blobf+j) = *c/1.0;
				c++;
				j++;
			}
		}
		//namedWindow( "Blob", CV_WINDOW_AUTOSIZE );
		//imshow("Blob", Blobf);
		//cvWaitKey(0);
		*/

		//Extract HOG features from Blob
		VlHog * hog = vl_hog_new(VlHogVariantUoctti, 9, VL_FALSE);
		vl_hog_put_image(hog, (float*)Blobs[i].data, 50, 50, 3, 2);
		vl_size hogWidth = vl_hog_get_width(hog);
		vl_size hogHeight = vl_hog_get_height(hog);
		vl_size hogDimension = vl_hog_get_dimension(hog);
		float * hogArray;
		hogArray = (float*)vl_malloc(sizeof(float)*hogWidth*hogHeight*hogDimension) ;
		vl_hog_extract(hog, hogArray);
		vl_hog_delete(hog);
		
		
		
		/*----------------------------------------Debugging Code for HogArray---------------------------------------------------
		ifstream stopfile;
		stopfile.open("stopHOG.dat", ios::binary);
		vector<double> stopHOG;
		double s;
		while( !stopfile.eof() ){
			stopfile.read((char*)&s, sizeof(double));
			stopHOG.push_back(s);
		}
		//remove garbage element
		stopHOG.pop_back();
		stopfile.close();*/
		/*
		///switch hogArray from row major to column major
		double* newHogArray = new double[hogWidth*hogHeight*hogDimension];
		int index = 0;
		for( int d = 0; d < hogDimension; d++){
			for(int w = 0; w < hogWidth; w++){
				for(int h = 0; h < hogHeight; h++){
					*(newHogArray+index) = *(hogArray + w + (h*hogWidth) + (d*hogWidth*hogHeight));
					index++;
				}
			}
		}
		vector<double> hogA(newHogArray, newHogArray+hogWidth*hogHeight*hogDimension);
		sort(hogA.begin(),hogA.end());
		sort(stopHOG.begin(), stopHOG.end());
		
		int count = 0;
		ofstream csvfile;
		csvfile.open("test2.csv");

		for(int h = 0; h < hogWidth*hogHeight*hogDimension; h++){
			csvfile << hogA[h] << ",";
			if(abs(hogA[h] - stopHOG[h]) <.0001){
				count++;
				//cout << h << ": match\n";
			}//else cout << h << ":mismatch\n";
		}
		csvfile << endl;
		for(int h = 0; h < hogWidth*hogHeight*hogDimension; h++){
			csvfile << stopHOG[h] << ",";
		}
		csvfile.close();
		cout << count;
		----------------------------------------End Debugging Code for HogArray---------------------------------------------------*/
		
		//Classify the blob using SVM
		double g = 0;		
		for(int a = 0; a < alphas.size(); a++){
			double innerProd = 0;			
			for(int j = 0; j < supVects[a].size(); j++){
				double x = *(hogArray+j);
				innerProd = innerProd + supVects[a][j]*x;
			}
			g = g + alphas[a]*innerProd;
		}
		g = g + bias;

		if(g > 0){
			cout << "Stop Sign Detected!!!";
		} else {
			cout << "This isn't a stop sign!";
		}
		cout << " classification value: " << g << endl;
	}
}

Mat Model::filterImage(Mat bgrIMG)
{
	// filters a BGR image by some HSV color parameters
	// if the lower bound of the filter is greater than the upper bound, then the filter is changed to OR and reversed
	// returns a one channel binary image of 1's and 0's

	Mat hsvIMG;
	//convert BGR image to HSV

	cvtColor(bgrIMG, hsvIMG , CV_BGR2HSV);
	// now split the hsv Image into 3 channels, h,s and v
	Mat hsv[3];
	cv::split(hsvIMG, hsv);

	//init filtered image logical image
	Mat filterIMG = hsv[0];
	Mat hRange = hsv[0];
	Mat sRange = hsv[1];
	Mat vRange = hsv[2];
	
	// check Hue values and modify hRange matrix
	if(hLow <= hHigh){
		for(int row = 0; row < hsv[0].rows; ++row) { 
			uchar* H = hsv[0].ptr(row);
			uchar* F = hRange.ptr(row);
			for(int col = 0; col < hsv[0].cols; ++col) {
				*F = (*H >= hLow) & (*H <= hHigh);
				F++;
				H++;
			}
		}
	}
	else{
		for(int row = 0; row < hsv[0].rows; ++row) { 
			uchar* H = hsv[0].ptr(row);
			uchar* F = hRange.ptr(row);
			for(int col = 0; col < hsv[0].cols; ++col) {
				*F = (*H > hLow) | (*H < hHigh);
				F++;
				H++;
			}
		}
	}

		// check Saturation values and modify sRange matrix
	if(sLow <= sHigh){
		for(int row = 0; row < hsv[1].rows; ++row) { 
			uchar* S = hsv[1].ptr(row);
			uchar* F = sRange.ptr(row);
			for(int col = 0; col < hsv[1].cols; ++col) {
				*F = (*S >= sLow) & (*S <= sHigh);
				F++;
				S++;
			}
		}
	}
	else{
		for(int row = 0; row < hsv[1].rows; ++row) { 
			uchar* S = hsv[1].ptr(row);
			uchar* F = sRange.ptr(row);
			for(int col = 0; col < hsv[1].cols; ++col) {
				*F = (*S > sLow) | (*S < sHigh);
				F++;
				S++;
			}
		}
	}

		// check Value values and modify vRange matrix
	if(vLow <= vHigh){
		for(int row = 0; row < hsv[2].rows; ++row) { 
			uchar* V = hsv[2].ptr(row);
			uchar* F = vRange.ptr(row);
			for(int col = 0; col < hsv[2].cols; ++col) {
				*F = (*V >= vLow) & (*V <= vHigh);
				F++;
				V++;
			}
		}
	}
	else{
		for(int row = 0; row < hsv[2].rows; ++row) { 
			uchar* V = hsv[2].ptr(row);
			uchar* F = vRange.ptr(row);
			for(int col = 0; col < hsv[2].cols; ++col) {
				*F = (*V > vLow) | (*V < vHigh);
				F++;
				V++;
			}
		}
	}

	//Logically AND the hRange, sRange, and vRange matrices and assign to filteredIMG matrix

	for(int row = 0; row < filterIMG.rows; ++row) {
		uchar* F = filterIMG.ptr(row);
		uchar* H = hRange.ptr(row);
		uchar* S = sRange.ptr(row);
		uchar* V = vRange.ptr(row);

		for(int col = 0; col < filterIMG.cols; ++col) {
			*F = *H & *S & *V;
			F++;
			H++;
			S++;
			V++;
		}
	}

	return filterIMG;

}

vector<vector<int> > Model::extractPixLoc(Mat filterIMG){
	/*  
	Takes a binary image as input
	Extracts the X and Y coordinates of each pixel with a "1" value
	returns 2 vectors, pixLoc[0] contains x values
					   pixLoc[1] contains y values
	*/

	//initialize vectors for x and y locations
	vector<int> xLoc;
	vector<int> yLoc;
	int index = 0;

	//look through whole filtered image matrix for nonzero elements
	//and save those locations in xLoc and yLoc
	for(int row = 0; row < filterIMG.rows; ++row) {
		uchar* F = filterIMG.ptr(row);
		for(int col = 0; col < filterIMG.cols; ++col) {
			if(*F != 0){
				xLoc.push_back(col);
				yLoc.push_back(row);
				index++;
			}
			F++;
		}
	}
	
	//Put xLoc and yLoc into 1 vector to be returned
	vector<vector<int> > pixLoc;
	pixLoc.push_back(xLoc);
	pixLoc.push_back(yLoc);
	
	return pixLoc;
}

vector<int> Model::segmentImage(vector<int> xLoc, vector<int> yLoc){
	/*
	Segments an image by grouping the logically true pixels by proximity
	returns a vector containing the labels for each pixel
	*/
	
	//get number of pixels of interest and create a vector of zeros for class labels
	int numPixels = xLoc.size();
	vector<int> clas (numPixels, 0);

	//initialize labels to each pixel belonging to its own class
	for(int i = 0; i < numPixels; i++) clas[i] = i+1;

	//reassign classes based on proximity to each other
	for(int i = 0; i < numPixels; i++){
		for(int j = i; j < numPixels; j++){
			// if x and y of both pixel i and pixel j are both within DISTANCE of each other, they belong in the same class
			//NOTE: this is agglomerative
			if( std::abs(xLoc[j] - xLoc[i]) <= distThresh && std::abs(yLoc[j] - yLoc[i]) <= distThresh)
				clas[j] = clas[i];
		}
	}

	return clas;
}

vector<int> Model::getUniqueClasses(vector<int> clas){
	/*
	gets the unique elements from a vector
	returns a vector containing the unique elements 
	removing classes that dont have more than a certain number of pixels
	*/
	
	//create a set of ints to store the labels of each remaining class that has pixels belonging to it
	//basically, the unique elements in vector CLAS
	set<int> classes(clas.begin(), clas.end());

	//set iterator
	set<int>::iterator it;

	//create a vector to store the unique elements in
	vector<int> uclasses;
	
	//iterate through set CLASSES and store each value in vector UCLASSES
	for (it=classes.begin(); it!=classes.end(); ++it)
		uclasses.push_back(*it);
	

	//remove classes that have fewer than LIMIT members
	int i = 0;	
	while(i != uclasses.size()){
		int pixCount = 0;
		for(int j = 0; j < clas.size(); j++){
			if(clas[j] == uclasses[i]) pixCount++;
		}

		if( pixCount <= 100){
			uclasses.erase(uclasses.begin()+i);
		}
		else{
			i++;
		}
	}

	return uclasses;

}

vector<Rect> Model::extractBlobsBB(vector<int> xLoc, vector<int> yLoc, vector<int> clas, vector<int> classes){
	/*
	takes pixel locations, thier labels and the unique classes as input
	returns the bounding boxes which contains all the pixels of a single class
	returns a bounding box for each class
	*/
	
	//initializations	
	Rect blobBB;
	vector<Rect> BlobsBB;
	int xMin;
	int yMin;
	int cols;
	int rows;

	//for each unique class
	for(int c = 0; c < classes.size(); c++){
		vector<int> xLocClass;
		vector<int> yLocClass;
		//for each pixel belonging to that class
		for(int p = 0; p < clas.size(); p++){
			//get all the indices of the pixels belonging to classes[c]
			if(clas[p] == classes[c]){
				xLocClass.push_back(xLoc[p]);
				yLocClass.push_back(yLoc[p]);
			}
		}
		//now XLOCCLASS and YLOCCLASS contain all the positions of the pixels belonging to that class

		//get location of upper left corner of bounding box of blob and width and height
		xMin = *std::min_element(xLocClass.begin(), xLocClass.end());
		yMin = *std::min_element(yLocClass.begin(), yLocClass.end());
		cols = *std::max_element(xLocClass.begin(), xLocClass.end()) - xMin;
		rows = *std::max_element(yLocClass.begin(), yLocClass.end()) - yMin;
		
		// form a Rect structure 
		blobBB = Rect(xMin, yMin, cols, rows);
		//add it to the vector of Blob bounding boxes
		BlobsBB.push_back(blobBB);
		

	}

	return BlobsBB;
}

vector<Mat> Model::extractBlobs(Mat rgbIMG, vector<Rect> BlobsBB){
	/*
	crops the blob bounding box from the image it was taken from
	returns a vector of blob images resized to BLOBWIDTH and BLOBHEIGHT.
	*/
	//initializations	
	Mat Blob;	
	vector<Mat> Blobs;
	Size size = Size(blobWidth, blobHeight);

	for(int r = 0; r < BlobsBB.size(); r++){
		//crop out the rectangle around the blob
		Blob = rgbIMG(BlobsBB[r]).clone();
		//resize it		
		Mat resizedBlob;
		resize(Blob, resizedBlob, size, 0, 0, INTER_LINEAR);
		//add it to the vector of Blobs
		Blobs.push_back(resizedBlob);	
	}

	return Blobs;
}
