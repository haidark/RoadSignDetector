function vid2frames(fileName)
%helper function to extract frames from a video
obj = VideoReader(fileName);
% remove extension
fileName = fileName(1:end-4);
mkdir(fileName)
for i = 1:2:obj.NumberOfFrames
   frame = read(obj, i);
   imwrite(frame,[fileName '\frame_' num2str(i) '.jpg']);
end