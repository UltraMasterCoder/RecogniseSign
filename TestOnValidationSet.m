
%% Test your own function on a validation set
clear; close all; clc;
% What image number are you testing
validationSet = [1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67]

% Gather the dice score
DSCScores = [];

for N = 1:length(validationSet)
    % Current sign id
    nSign = validationSet(N);
 
    ImageName = sprintf('DTUSignPhotos/DTUSigns%03d.jpg', nSign);
    LMName    = sprintf('DTUSignPhotos/DTUSigns%03d.txt', nSign);

    I = imread(ImageName);
    LM = dlmread(LMName);

    % Ground truth label map
    LabelMap = CreateLabelMapFromAnnotations(I, LM);
    RGBLabels = label2rgb(LabelMap);

    % Find the signs using my function
    MyMap = MyDTUSignFinder(I);
    RGBMyLabels = label2rgb(MyMap);

    nLabels = max(max(MyMap));
    nGTLabels = max(max(LabelMap));
    
    % Note that this will be very slow if you have more than 30 labels in your
    % image (nLabels). Try to reduce the number of found objects before calling this
    % function
    CDSC = CombinedDiceScore(MyMap, LabelMap);
    DSCScores = [DSCScores, CDSC];
    str=sprintf('Photo %d Combined DICE score %g with %g found labels. There are %g GT labels', nSign, CDSC, nLabels, nGTLabels)

    figure;
    subplot(2,2,1); imshow(I);  title('Input image')
    subplot(2,2,3);imagesc(RGBLabels); axis image; title('Ground truth signs')
    subplot(2,2,4);imagesc(RGBMyLabels); axis image; title('Found sign candidates')
    %figure, imagesc(RGBMyLabels); axis image; title('Found sign candidates')
    %figure, imagesc(RGBLabels); axis image; title('Ground truth signs')
    annotation('textbox', [0.05 0.26 0.3 0.3],'String', str,'FitBoxToText', 'on');
end

% What is the mean score
mean(DSCScores)


