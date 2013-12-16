#ifndef MODEL_H
#define MODEL_H

#include <iostream>
#include <fstream>
#include <cmath>
#include <set>
#include <vector>
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>

extern "C" {
#include <vl/generic.h>
#include <vl/hog.h>
}

using namespace cv;
using namespace std;

class Model
{
public:
	Model( std::string ModelName);	
	~Model(){}
	void detectModel(Mat Image);

private:
	//parameters
	int hLow;
	int hHigh;
	int sLow;
	int sHigh;
	int vLow;
	int vHigh;
	int distThresh;
	int blobWidth;
	int blobHeight;
	int cellSize;
	//Model
	std::vector<double> alphas;
	double bias;
	std::vector<int> labels;
	std::vector<std::vector<double>> supVects;
	//functions
	Mat filterImage(Mat bgrIMG);
	vector<vector<int>> extractPixLoc(Mat filterIMG);
	vector<int> segmentImage(vector<int> xLoc, vector<int> yLoc);
	vector<int> getUniqueClasses(vector<int> clas);
	vector<Rect> extractBlobsBB(vector<int> xLoc, vector<int> yLoc, vector<int> clas, vector<int> classes);
	vector<Mat> extractBlobs(Mat rgbIMG, vector<Rect> BlobsBB);

};

#endif