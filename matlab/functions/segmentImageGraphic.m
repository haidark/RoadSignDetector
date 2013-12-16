% Creates a video for segmentation video visualization
clear; clc;  close all;

I = imread('C:\Users\Haidar\Documents\RoadSignDetector\data\testImages\stop.jpg');
[filter, pixLoc] = filterImage(I, 345, 15, 30, 100, 0, 100);
graph = ones(size(I))*255;

[numPixels, ~] = size(pixLoc);
class = (1:numPixels)';
colors = zeros(numPixels, 3);
for i = 1:numPixels
    colors(i, :) = randi([0, 255], [1,3]);
    graph(pixLoc(i,1), pixLoc(i,2), :) = colors(i, :);
end


outputVideo = VideoWriter('segGraphic5.avi');
outputVideo.FrameRate = 10;
open(outputVideo);
writeVideo(outputVideo,uint8(graph));
% f = figure;
% imshow(uint8(graph));
dist = 5;
count = 0;
for i = 1:numPixels
    for j = i:numPixels
        if(abs(pixLoc(j,1) - pixLoc(i,1)) <= dist && abs(pixLoc(j,2) - pixLoc(i,2)) <= dist)
            class(j) = class(i);
            colors(j,:) = colors(i,:);
            graph(pixLoc(j,1), pixLoc(j,2),:) = colors(i, :);
            if mod(count, 1000) == 0
                writeVideo(outputVideo,uint8(graph));
            end
            count = count +1;
%             imshow(uint8(graph));
%             pause(.00001);
        end
    end 
end
classes = unique(class);
close(outputVideo);