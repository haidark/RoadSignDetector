function Images = extractSign(rgbI, hLow, hHigh, sLow, sHigh, vLow, vHigh, distance)
% Takes as RBG Image and extracts large clusters of pixels in the given ranges as possible
% loacations for a road sign
% returns IMAGES, a cell array
%column 1 are RGB images which are all the possible stop signs in an image.
%column 2 is the bounding box for that image

[~, pixLoc] = filterImage(rgbI, hLow, hHigh, sLow, sHigh, vLow, vHigh);

% segment the image into classes by proximity

[class, classes] = segmentImage(pixLoc, distance, 100);

Images = cell(length(classes),2);
%Store the potential stop sign images in a cell array
for i = 1:length(classes)
    pix = pixLoc(class == classes(i),:);
    xMin = min(pix(:,2));
    yMin = min(pix(:,1));
    rows = max(pix(:,1)) - yMin;
    cols = max(pix(:,2)) - xMin;
    Images{i,1} = imcrop(uint8(rgbI),[xMin, yMin, cols, rows]);
    Images{i,2} = [xMin, yMin, cols, rows];
end





