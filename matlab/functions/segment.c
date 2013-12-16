#include "mex.h" /* Always include this */
#include "math.h"
#include "matrix.h"

#define CLASS_OUT   plhs[0]
#define PIXLOC_IN   prhs[0]
#define NUMPIXELS   prhs[1]
#define DISTANCE    prhs[2]

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    double* class;
    double* pixLoc;
    double distance;
    int numPixels;
    int i;
    int j;
            
    if(nrhs != 3)
        mexErrMsgTxt("Wrong number of input arguments");
    else if(nlhs > 1)
        mexErrMsgTxt("Too many output arguments");    
    

    numPixels = mxGetScalar(NUMPIXELS);
    distance = mxGetScalar(DISTANCE);
    
    pixLoc = mxGetPr(PIXLOC_IN);
    CLASS_OUT = mxCreateDoubleMatrix(numPixels, 1, 0);
    class = mxGetPr(CLASS_OUT);
    //initialize class vector to each pixel belonging to its own class
    for(i = 0; i < numPixels; i++) class[i] = i + 1;
    
    //reassign classes by proximity
    for(i = 0; i < numPixels; i++){
        for( j = i; j < numPixels; j++){
            //norm = sqrt(pow(pixLoc[j] - pixLoc[i],2) + pow(pixLoc[j+numPixels] - pixLoc[i+numPixels],2));
            //if first dimensional distance is less than DISTANCE threshold
             //and if second dimensional distance is less than DISTANCE threshold
            if( abs(pixLoc[j] - pixLoc[i]) <= distance && abs(pixLoc[j+numPixels] - pixLoc[i+numPixels]) <= distance){
                //They are part of the same class
                class[j] = class[i];
            }
        }        
    }    
    return;
}