******************************************************************
************************Road Sign Detector************************
***********************Author: Haidar Khan ***********************
******************************************************************

******************************************************************
**************************** About Me ****************************
    
    I am a computer engineering student at SUNY New Paltz, located in
New York, USA. My interests are primarily in computer vision, and the 
application of machine learning techniques to computer vision.

******************************************************************
************************ About the Project ***********************
    
    This project is part of my senior design work (capstone project)
at SUNY New Paltz. The project goal is to detect road signs in images
for the purpose of augmenting driver knowledge of the road. This is done
using a combination of simple image processing techniques and machine
learning. 

******************************************************************
************************* Project Details ************************
    
    This project consists of two main parts; training a model for 
detection and using the model to detect on an image or video. Most
of the main code is written in MATLAB. A Graphical User Interface is
available to streamline the process of training a model. Two demo scripts
are provided to show the user how to use the model on an image or video.
In development is code written in C++ using OpenCV (Open Computer Vision)
libraries to do detection using pre-trained models. More details can be
found in the report and presentation included in this 'docs' directory.

******************************************************************
**************************** Quick Run ***************************

In the "matlab" directory, run:
    -'setup.m' - adds required files to path and runs mex
    -'demoModel.m' - runs a pre-trained model on test images
        OR
    -'demoVideo.m' - runs a pre-trained model on a test video

******************************************************************    
************************* Training a Model ***********************

    To train your own model, you will need a set of training images
containing the object of interest (OOI).
    1) run 'matlab/GUI/SignDetector.m'; A GUI will appear.
    2) Enter a name for your model and click CREATE.
    3) Provide the path to your training images and click COPY IMAGES
        This will create a local copy of all training images.
    4) Now a filter will need to be defined for the model
        a. Select an image which shows the OOI clearly.
        b. use the sliders for Hue, Saturation, and Value to select
            ranges for each.
            - NOTE: if HIGH > LOW; the range will invert
    5) Enter a distance threshold for segmentation (typically 5)
    6) Extract blobs from training images by clicking EXTRACT BLOBS
        a. Takes some time; wait for "100% complete"
    7) Begin labeling by clicking BEGIN LABELING
        a. The current blob will be shown
        b. If the blob is your OOI, click POSITIVE otherwise NEGATIVE
    8) Enter a size for blobs (typically 50x50 pixels)
    9) Enter a cellsize for HoG (typically 2 pixels)
    10) Assemble and save training matrix by clicking ASSEMBLE TRAINING DATA
    11) Optional: run Hold-one-out Crossvalidation
    12) Traing and save model by clicking TRAIN AND SAVE

In the current MATLAB directory, you will see a folder with your model name.
This folder contains all training images, labelled blobs, training data matrix,
and final model. The final model will be named 'your_model_name_final.mat'.
Additional '.dat' files will be generated, which are used for interfacing with
the C++ code.

******************************************************************    
************************ C++ Implementation **********************

    The C++ implementation does not include training models, it 
simply uses pretrained models on images/videos. The code is halfway
complete, missing parts include: a "good" HoG implementation and 
debugging classification code.

 ******************************************************************    
************************ Additional Comments **********************

In the future I would like to:
    - Improve filtering techniques, possibly automating it
    - Use a different feature extraction method (Canny Edge)
    - Implement as a smartphone app
    
    
