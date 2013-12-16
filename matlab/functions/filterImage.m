function [filter, pixLoc] = filterImage(rgbI, hLow, hHigh, sLow, sHigh, vLow, vHigh)
% Filters an RGB image by converting to the HSI colorspace and filtering
% within the limits defined by sLOW < s < sHIGH, and hLOW < h < hHIGH and
% vLow < v < vHigh.
% If the lower limit for any of the three (Hue, Saturation, or Value) is 
% greater than the upper limit, the desired range for that color aspect
% will go in the other direction.
% For example if hLow is 300 and hHigh is 60, the acceptable range for Hue
% will be H <= 60 OR H >= 300.
% h falls between 0 and 360, while s, and v fall between 0 and 100
% returns FILTER, a logical image and pixLoc, the locations of all pixels
% passed the filtration process

hsvI = rgb2hsv(rgbI);
%put the hsv image in a comfortable format
H = hsvI(:,:,1)*360;
S = hsvI(:,:,2)*100;
V = hsvI(:,:,3)*100;

% Get acceptable pixels for HUE
if hLow <= hHigh
    hRange = H >= hLow & H <= hHigh;
else
    hRange = H <= hHigh | H >= hLow;
end
% Get acceptable pixels for SATURATION
if sLow <= sHigh
    sRange = S >= sLow & S <= sHigh;
else
    sRange = S <= sHigh | S >= sLow;
end
% get acceptable pixels for VALUE
if vLow <= vHigh
    vRange = V >= vLow & V <= vHigh;
else
    vRange = V <= vHigh | V >= vLow;
end
% This logical statement filters by color defined by the ranges!
% filter = H >= hLow & H <= hHigh & S >= sLow & S <= sHigh & V >= vLow & V <= vHigh;
filter = (hRange) & (sRange) & (vRange);
[I, J] = find(filter);
pixLoc = [I, J];

