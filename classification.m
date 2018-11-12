close all;
clear all;
clc;

name_of_file = ('class_values/0_all_class_vals.mat');
load(name_of_file);

[meanVar,stdVar] = extractMeanStd(all_class_values);

% Number of classes
dim = size(meanVar);
n_class = dim(1);

% mean RGB
meanR = [];
meanG = [];
meanB = [];

% Add original class to Matrix
for class = 1:n_class
    meanVar(class,4) = class;
    %stdVar(class,4) = class;
end

% mean RGB
meanR(:,1) = meanVar(:,1);
meanR(:,2) = meanVar(:,4);
meanG(:,1) = meanVar(:,2);
meanG(:,2) = meanVar(:,4);
meanB(:,1) = meanVar(:,3);
meanB(:,2) = meanVar(:,4);

% sort average pixel value
for class = 1:n_class
        meanRsort = sortrows(meanR);
        meanGsort = sortrows(meanG);
        meanBsort = sortrows(meanB);
end

%% Minimum Distance Classification

MinDistClassR = [];
MinDistClassG = [];
MinDistClassB = [];

for class = 1:(n_class - 1)
    
    MinDistClassR(class,1) = (meanRsort(class,1) + meanRsort(class+1,1)) / 2;
    MinDistClassG(class,1) = (meanGsort(class,1) + meanGsort(class+1,1)) / 2;
    MinDistClassB(class,1) = (meanBsort(class,1) + meanBsort(class+1,1)) / 2;
    
end

%% Parametric Classification

ParClassR = [];
yps12R = [];
ParClassG = [];
yps12G = [];
ParClassB = [];
yps12B = [];

% Calculation of 2 solutions
for class = 1:(n_class - 1)
    % R
    [yps1R,yps2R] = ParamClass(meanRsort(class,1),meanRsort(class+1,1),...
                stdVar(int64(meanRsort(class,2)),1),stdVar(int64(meanRsort(class+1,2)),1));
   
    yps12R(class,:) = [yps1R,yps2R];
    
    % G
        [yps1G,yps2G] = ParamClass(meanGsort(class,1),meanGsort(class+1,1),...
                stdVar(int64(meanGsort(class,2)),2),stdVar(int64(meanGsort(class+1,2)),2));
    
    yps12G(class,:) = [yps1G,yps2G];
    
    % B
        [yps1B,yps2B] = ParamClass(meanBsort(class,1),meanBsort(class+1,1),...
                stdVar(int64(meanBsort(class,2)),3),stdVar(int64(meanBsort(class+1,2)),3));
   
    yps12B(class,:) = [yps1B,yps2B];
    
end
    
% Choose of one solution with smaller distance to value of MinDistClass
for class = 1: (n_class-1)
    
    % R
    if abs(yps12R(class,1) - MinDistClassR(class)) < ...
       abs(yps12R(class,2) - MinDistClassR(class))
       ParClassR(class) = yps12R(class,1);
    else
        ParClassR(class) = yps12R(class,2);
    end
    
    % G
    if abs(yps12G(class,1) - MinDistClassG(class)) < ...
       abs(yps12G(class,2) - MinDistClassG(class))
       ParClassG(class) = yps12G(class,1);
    else
        ParClassG(class) = yps12G(class,2);
    end
    
    %B
    if abs(yps12B(class,1) - MinDistClassB(class)) < ...
       abs(yps12B(class,2) - MinDistClassB(class))
       ParClassB(class) = yps12B(class,1);
    else
        ParClassB(class) = yps12B(class,2);
    end

end
