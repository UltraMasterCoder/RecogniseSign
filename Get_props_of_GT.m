
%% Test your own function on a validation set
clear; close all; clc;
% What image number are you testing
validationSet = [1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67];

% Gather the dice score
DSCScores = [];
sum_ground_truth = 0;
sum_labels_found = 0;

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
    
    Ilabel = LabelMap;
    
%     areaProps = regionprops(Ilabel, 'Area');
    bbProps = regionprops(Ilabel, 'Orientation');
    
    for i = 1:length(bbProps)
        comp1(i,N) = bbProps(i).Orientation;
    end
   
end





