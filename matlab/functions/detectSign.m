function [newImage, rect] = detectSign(Image, SVM, modelParams)
% This function checks if an image contains a stop sign
% takes an image as input.
% If the image does not contain a stop sign, the original image is returned
% If the image does contain a stop sign, the original image is returned
% with a bounding box drawn around the detection.

rect = [0 0 0 0];
Images = extractSign(Image, modelParams.hLow, modelParams.hHigh, modelParams.sLow, modelParams.sHigh, modelParams.vLow, modelParams.vHigh, modelParams.distThresh);
newImage = Image;
Sign = 0;  %boolean speeds up process, stops testing detections if a stop sign was detected
[numImages,~] = size(Images);
for ims = 1:numImages;
    if Sign == 1
        break;
    end
    Image = imresize(Images{ims,1}, [modelParams.blobWidth,modelParams.blobHeight], 'bil');
    %extract HOG features from the image
    HOG1 = vl_hog(single(Image), modelParams.cellSize);
    newData = HOG1(:)';
    classification = svmclassify(SVM, newData);
    if classification > 0
%         Draw the bounding boxes
        shapeInserter = vision.ShapeInserter;
        shapeInserter.BorderColor = 'Custom';
        shapeInserter.CustomBorderColor = [255 0 0];
        newImage = step(shapeInserter, newImage, int32(Images{ims,2}));
%         Draw text at location
        textColor    = [0, 255, 0];
        textLocation = [1 1];
        textInserter = vision.TextInserter('Detection'...
            ,'Color', textColor, 'FontSize', 16, 'Location', textLocation);
        newImage = step(textInserter, newImage);
%         get x, y, width, and height of bounding box 
        rect = Images{ims,2};
        Sign = 1;
    end

end