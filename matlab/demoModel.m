% Demos a model on images
% Define root directory
ROOT = 'C:\Users\Haidar\Documents\RoadSignDetector';
% Load the model
load([ROOT '\models\Stop_final']);
% Folder containing images
folder = [ROOT '\data\testImages'];
% Pick a file format
ext = '.jpg';
D = dir([folder '\*' ext]);

for pic = 1:length(D)
    disp(['Reading Image: ' D(pic).name '...']);
    I = imread([folder D(pic).name]);
    [h,w,~] = size(I);
    [I, ~] = detectSign(I, SVM, modelParams);
    imwrite(I, [folder num2str(pic) ext]); 
end