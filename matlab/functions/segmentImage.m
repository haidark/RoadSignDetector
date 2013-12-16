function [class, classes] = segmentImage(pixLoc, distance, limit)
% This functions segments an Image that has had a filter applied 
% to it into classes, the location of the filtered pixels is given by
% PIXLOC. the segmentation is done by euclidean distance, specified by
% DSITANCE
% it returns a vector CLASS which contains labels for every pixel, and a
% vector CLASSES which contains the identifiers for the classes that
% contain more than a 100 pixels.

[numPixels, ~] = size(pixLoc);
% call mex function to segment image by distance
class = segment(pixLoc, numPixels, distance);

%get labels of remaining classes
classes = unique(class);

%delete each class from list of classes that doesnt contain more than 300
%pixels
i = 1;
while i ~= length(classes)+1    
    if sum(class == classes(i)) <= limit
        classes(i) = [];
    else
        i = i+1;
    end
end

