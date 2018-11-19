
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
    
     p1 = regionprops(Ilabel, 'Perimeter');
    perim1 = [p1.Perimeter];
    areaProps = regionprops(Ilabel, 'Area');
    area1 = [areaProps.Area];
    for i = 1:length(perim1)
        circ1(i,N) = (2*sqrt(pi*area1(i)))/perim1(i);
    end
    
   
end





