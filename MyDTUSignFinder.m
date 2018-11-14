% function LabelMap = MyDTUSignFinder(I)
close all;
clear all;
clc;

% Show image
I = imread('DTUSignPhotos/DTUSigns003.jpg');

% select sign
% DTUSROI = roipoly(I);
% imwrite(DTUSROI, 'DTUSROI.png');
% %DTUSROI = imread('DTUSROI.png');
% DTUSVals = double(I(DTUSROI));

% % show hist
% imhist(I);
I_orig = I;
% I_norm = double(I)./255;
% I = rgb2hsv(I_norm);
I = rgb2ntsc(I);
Ired   = I(:,:,1);
Igreen = I(:,:,2);
Iblue  = I(:,:,3);
% DTUSredVals = double(Ired(DTUSROI));
% DTUSgreenVals = double(Igreen(DTUSROI));
% DTUSblueVals = double(Iblue(DTUSROI));

% inspect the combined histogram of the R, G, B values.
% figure;
% totVals = [DTUSredVals DTUSgreenVals DTUSblueVals];
% nbins = 255;
% hist(totVals,nbins);
% h = findobj(gca,'Type','patch');
% set(h(3),'FaceColor','r','EdgeColor','r','FaceAlpha',0.3,'EdgeAlpha',0.3);
% set(h(2),'FaceColor','g','EdgeColor','g','FaceAlpha',0.3,'EdgeAlpha',0.3);
% set(h(1),'FaceColor','b','EdgeColor','b','FaceAlpha',0.3,'EdgeAlpha',0.3);
% xlim([0 255]);

% show histograms with each colour component
% figure;
% subplot(1,2,1);
% imshow(I);
% title('original Image');
% 
% subplot(3,2,2);
% hist(DTUSredVals,255);
% xlim([0 255]);
% title('red Values');
% 
% subplot(3,2,4);
% hist(DTUSgreenVals,255);
% xlim([0 255]);
% title('green Values');
% 
% subplot(3,2,6);
% hist(DTUSblueVals,255);
% xlim([0 255]);
% title('blue Values');

% RGB Threshold
% TODO: This can be done better
% ISigns = Ired > 117 & Ired < 255  & Igreen > 0 & Igreen < 120 & Iblue > 0 & Iblue < 135;
% HSI Threshold
% ISigns = Igreen > 0.5 & Igreen < 0.8 & Iblue > 0.35 & Iblue < 1;
ISigns = Iblue > 0.04 & Igreen >0.12;
% TODO: Here should be a lot of intelligent code to extract signs
% For example morphological operations and BLOB analysis

%% Morphology operations
% Binary operations to remove small objects
se1 = strel('square',10);
se2 = strel('rectangle',[3 5]);
Imorph1 = imopen(ISigns, se1);
Imorph2 = imopen(ISigns, se2);

% se12 = strel('square',10);
% se22 = strel('rectangle',[5 10]);
% Imorph12 = imclose(Imorph1, se12);
% Imorph22 = imclose(Imorph2, se22);

%% Blob extraction

% Applying 'Area'
Imorph12 = bwlabel(Imorph1,4);
props12 = regionprops(Imorph12, 'Area');
area1 = [props12.Area];
idx12 = find(area1 > 2640);
Imorph12 = ismember(Imorph12, idx12);
% Imorph12 = label2rgb(bwlabel(Imorph12,4), 'spring', 'c', 'shuffle');

Imorph22 = bwlabel(Imorph2,4);
props22 = regionprops(Imorph22, 'Area');
area2 = [props22.Area];
idx22 = find(area2 > 2640);
Imorph22 = ismember(Imorph22, idx22);
% Imorph22 = label2rgb(bwlabel(Imorph22,4), 'spring', 'c', 'shuffle');

se13 = strel('rectangle',[5 15]);
se23 = strel('rectangle',[5 15]);
Imorph13 = imclose(Imorph12, se13);
Imorph23 = imclose(Imorph22, se23);

%% Applying 'Circularity'

p1 = regionprops(Imorph12, 'Perimeter');
perim1 = [p1.Perimeter];

for i = 1:length(idx12)
    circ1(i) = perim1(i)/(2*sqrt(pi*area(i)));
end

Imorph13 = bwlabel(Imorph12,4);
idxCirc1 = find(circ < 0.80);
Imorph13 = ismember(Imorph13, idxCirc1);



%% Remove object from the border
Imorph13 = imclearborder(Imorph13);
Imorph23 = imclearborder(Imorph23);

% p1 = regionprops(Imorph13, 'Perimeter');
% 
% for i = 1:length(idx12)
%     circ(i) = (2*sqrt(pi*


%% Applying 'Bounding box ratio'

bbr1 = regionprops(Imorph13,'BoundingBox');
for k = 1:length(bbr1)
    %bbr1(k).BoundingBox(5) = [bbr1(k).BoundingBox(4)]/[bbr1(k).BoundingBox(3)];  
    bbr11(k,1) = [bbr1(k).BoundingBox(4)]/[bbr1(k).BoundingBox(3)];
end

bbr2 = regionprops(Imorph23,'BoundingBox');
for k = 1:length(bbr2)
    %bbr2(k).BoundingBox(5) = [bbr2(k).BoundingBox(4)]/[bbr2(k).BoundingBox(3)];
    bbr22(k,1) = [bbr2(k).BoundingBox(4)]/[bbr2(k).BoundingBox(3)];
end

%idx13 = find(bbr1.BoundingBox(1)> 1);
Imorph14 = bwlabel(Imorph13,4);
idx13 = find(transpose(bbr11) < 2.5);
Imorph15 = ismember(Imorph14, idx13);
 

%idx23 = find(bbr2.BoundingBox(5) > 1);
Imorph24 = bwlabel(Imorph23,4);
idx23 = find(transpose(bbr22) < 2.5);
Imorph25 = ismember(Imorph24, idx23);



figure;
subplot(3,4,1);
imshow(I_orig);
title('Original');
subplot(3,4,2);
imshow(ISigns);
title('Pixel classified');
subplot(3,4,3);
imshow(Imorph1);
title('Square');
subplot(3,4,4);
imshow(Imorph2);
title('Rectangle');

subplot(3,4,5);
imshow(I);
title('Original');
subplot(3,4,6);
imshow(ISigns);
title('Pixel classified');
subplot(3,4,7);
imshow(Imorph15);
title('Square');
subplot(3,4,8);
imshow(Imorph25);
title('Rectangle');
% Blob extraction
L8 = bwlabel(Imorph2,8);

% Return the raw BLOBS
LabelMap = L8;


