% Do some housekeeping

clear; clc; close all;
ROOT = 'C:\Users\Haidar\Documents\RoadSignDetector';
addpath_recurse([ROOT '\functions']);
addpath_recurse([ROOT '\GUI']);

% Mex the segmentation function
mex([ROOT '\functions\segment.cs']);