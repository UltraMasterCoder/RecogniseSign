%% Test your own function on one image
clear; close all; clc;

% What image number are you testing
nSign = 9;
 
ImageName = sprintf('DTUSignPhotos/DTUSigns%03d.jpg', nSign);
LMName    = sprintf('DTUSignPhotos/DTUSigns%03d.txt', nSign);

% Read image and annotations
I = imread(ImageName);
LM = dlmread(LMName);

% Ground truth label map
LabelMap = CreateLabelMapFromAnnotations(I, LM);
RGBLabels = label2rgb(LabelMap);

% Find the signs using my function
MyMap = MyDTUSignFinder(I);
RGBMyLabels = label2rgb(MyMap);

% How many labels are there in ground truth image and ground truth image
nLabels = max(max(MyMap));
nGTLabels = max(max(LabelMap));

% Note that this will be very slow if you have more than 30 labels in your
% image. Try to reduce the number of found objects before calling this
% function
CDSC = CombinedDiceScore(MyMap, LabelMap);
str=sprintf('Combined DICE score %g with %g labels. There are %g GT labels', CDSC, nLabels, nGTLabels)

figure;
subplot(2,2,1); imshow(I);  title('Input image')
subplot(2,2,3);imagesc(RGBLabels); axis image; title('Ground truth signs')
subplot(2,2,4);imagesc(RGBMyLabels); axis image; title('Found sign candidates')
annotation('textbox', [0.05 0.25 0.3 0.3],'String', str,'FitBoxToText', 'on');
