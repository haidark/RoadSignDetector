% Demos a model on a video
% Define root directory
ROOT = 'C:\Users\Haidar\Documents\RoadSignDetector';
% Folder containing video
folder = [ROOT '\data\videos\'];
% load the model
load([ROOT '\models\Stop_final']);
% name of video
vidName = 'day_v8';
% extension
ext = '.mp4';

fileName = [folder vidName ext];
obj = VideoReader(fileName);
% Output a video containing original video 
% + detections with bounding boxes drawn
outputVideo = VideoWriter([folder vidName '_BB.avi']);
outputVideo.FrameRate = obj.FrameRate;
open(outputVideo);
i = 1;
while i  <= obj.NumberOfFrames
    frame = read(obj, i);
    [I, rect] = detectSign(frame, SVM, modelParams);
    writeVideo(outputVideo,I);
    if rect(1) == 0 && rect(2) == 0 && rect(3) == 0 && rect(4) == 0
        i = i+4;
    else
        i = i+1;
    end    
end

close(outputVideo);
