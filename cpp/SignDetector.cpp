// SignDetector.cpp : Defines the entry point for the console application.
//


#include "stdafx.h"
#include <time.h>
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <iostream>
#include <cmath>
#include <set>
#include <vector>

extern "C" {
#include <vl/generic.h>
#include <vl/hog.h>
}
#include "Model.h"

using namespace cv;
using namespace std;
/*
Mat filterImage(int hLow, int hHigh, int sLow, int sHigh, int vLow, int vHigh, Mat bgrIMG);
vector<vector<int> > extractPixLoc(Mat filterIMG);
vector<int> segmentImage(vector<int> xLoc, vector<int> yLoc, int distance);
vector<int> getUniqueClasses(vector<int> clas, int limit);
vector<Rect> extractBlobsBB(vector<int> xLoc, vector<int> yLoc, vector<int> clas, vector<int> classes);
vector<Mat> extractBlobs(Mat rgbIMG, vector<Rect> BlobsBB);
*/
int main( int argc, char** argv )
{
    /*ifstream stopfile;
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


	
	
	Model stop = Model("StopSignModel");	
	
	
	if( argc != 2)
    {
     cout <<" Usage: display_image ImageToLoadAndDisplay" << endl;
	 waitKey(0);  
     return -1;
    }

    Mat image;
    image = imread(argv[1], CV_LOAD_IMAGE_COLOR);   // Read the file
	image = imread("stop.jpg", CV_LOAD_IMAGE_COLOR);
	Mat rgbIMG = image;
    if(! image.data )                              // Check for invalid input
    {
        cout <<  "Could not open or find the image" << std::endl ;
		waitKey(0);  
        return -1;
    }
	clock_t start, finish;
	start = clock();
	//run it 1000 times
	for(int i = 0; i < 10; i++)stop.detectModel(image);

	finish = clock();

	cout << ((finish - start)/CLOCKS_PER_SEC);


	
	namedWindow( "Display window", CV_WINDOW_AUTOSIZE );   // Create a window for display.
	imshow( "Display window", image);                   // Show our image inside it.

    waitKey(0);                                          // Wait for a keystroke in the window
    return 0;
}


	//for(int row = 0; row < image.rows; ++row) {
	//	uchar* p = image.ptr(row);
	//	// for(int col = 0; col < img.cols; ++col) {
	//	//       cout << *p++  //points to each pixel value in turn assuming a CV_8UC1 greyscale image 
	//	// }
 //
	//	for(int col = 0; col < image.cols*3; ++col) {
	//		cout << int(*p++) << endl;  //points to each pixel B,G,R value in turn assuming a CV_8UC3 color image 
	//	}
	//} 


	/*
	ascii files
	ifstream paramsfile;
	ifstream biasfile;
	ifstream alphasfile;
	ifstream labelsfile;
	ifstream supVectsfile;

	// read parameters from "MODELNAME_params.csv"
	cout << "Reading parameters...\n";
	paramsfile.open(modelName+"_params.csv", ios::in | ios::binary);
	string p;
	// get hue lower convert from 0-360 to 0-180
	getline(paramsfile, p);
	hLow = atoi(p.c_str())*180/360;
	// get hue upper convert from 0-360 to 0-180
	getline(paramsfile, p);
	hHigh = atoi(p.c_str())*180/360;
	// get saturation lower convert from 0-100 to 0-255
	getline(paramsfile, p);
	sLow = atoi(p.c_str())*255/100;
	// get saturation upper convert from 0-100 to 0-255
	getline(paramsfile, p);
	sHigh = atoi(p.c_str())*255/100;
	// get value lower convert from 0-100 to 0-255
	getline(paramsfile, p);
	vLow = atoi(p.c_str())*255/100;
	// get value upper convert from 0-100 to 0-255
	getline(paramsfile, p);
	vHigh = atoi(p.c_str())*255/100;
	// get distance Threshold
	getline(paramsfile, p);
	distThresh = atoi(p.c_str());
	// get blob Width
	getline(paramsfile, p);
	blobWidth = atoi(p.c_str());
	// get blob Height
	getline(paramsfile, p);
	blobHeight = atoi(p.c_str());
	// get cellsize
	getline(paramsfile, p);
	cellSize = atoi(p.c_str());

	paramsfile.close();

	// read bias value from "MODELNAME_bias.csv"
	cout << "Reading bias values...\n";
	biasfile.open(modelName+"_bias.csv");
	// bias is one value so get the whole line from the file and convert to double
	string b;
	getline(biasfile, b);
	bias = atof(b.c_str());
	biasfile.close();

	// read alpha values from "MODELNAME_alphas.csv"
	cout << "Reading alpha values...\n";
	alphasfile.open(modelName+"_alphas.csv");
	// each line represent one alpha value, read line and convert to double
	string a;
	while( getline(alphasfile, a) ){
		alphas.push_back(atof(a.c_str()));
	}

	alphasfile.close();

	// read labels from "MODELNAME_labels.csv"
	cout << "Reading labels...\n";
	labelsfile.open(modelName+"_labels.csv");
	//each line contains 1 or -1, read it and convert to int
	string l;
	while( getline(labelsfile, l)){
		labels.push_back(atoi(l.c_str()));
	}
	labelsfile.close();

	// read support vector values from "MODELNAME_supVects.csv"
	cout << "Reading support vector values...\n";
	supVectsfile.open(modelName+"_supVects.csv");
	//read each line, split it by commas, convert each split string to double and build the matrix
	string sline;
	int count = 1;
	while( getline(supVectsfile, sline) ){
		cout << "\tReading support vector line: " << count << "...\n";
		vector<double> s;
		vector<string> ssplit = split(sline, ',');
		for(int i = 0; i<ssplit.size(); i++)
			s.push_back(atof(ssplit[i].c_str()));
		supVects.push_back(s);
		count++;
	}

	supVectsfile.close();	

	*/