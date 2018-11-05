

% Show image
I = imread('DTUSignPhotos/DTUSigns003.jpg');

% select sign
DTUSROI = roipoly(I);
imwrite(DTUSROI, 'DTUSROI.png');
%DTUSROI = imread('DTUSROI.png');
DTUSVals = double(I(DTUSROI));

% % show hist
% imhist(I);
Ired   = I(:,:,1);
Igreen = I(:,:,2);
Iblue  = I(:,:,3);
DTUSredVals = double(Ired(DTUSROI));
DTUSgreenVals = double(Igreen(DTUSROI));
DTUSblueVals = double(Iblue(DTUSROI));

% inspect the combined histogram of the R, G, B values.
figure;
totVals = [DTUSredVals DTUSgreenVals DTUSblueVals];
nbins = 255;
hist(totVals,nbins);
h = findobj(gca,'Type','patch');
set(h(3),'FaceColor','r','EdgeColor','r','FaceAlpha',0.3,'EdgeAlpha',0.3);
set(h(2),'FaceColor','g','EdgeColor','g','FaceAlpha',0.3,'EdgeAlpha',0.3);
set(h(1),'FaceColor','b','EdgeColor','b','FaceAlpha',0.3,'EdgeAlpha',0.3);
xlim([0 255]);

% show histograms with each colour component
figure;
subplot(1,2,1);
imshow(I);
title('original Image');

subplot(3,2,2);
hist(DTUSredVals,255);
xlim([0 255]);
title('red Values');

subplot(3,2,4);
hist(DTUSgreenVals,255);
xlim([0 255]);
title('green Values');

subplot(3,2,6);
hist(DTUSblueVals,255);
xlim([0 255]);
title('blue Values');

% RGB Threshold
% TODO: This can be done better
ISigns = Ired > 150 & Ired < 200  & Igreen > 45 & Igreen < 80 & Iblue > 60 & Iblue < 100;

% TODO: Here should be a lot of intelligent code to extract signs
% For example morphological operations and BLOB analysis

% Binary operations to remove small objects
se = strel('disk',3);
Iopen = imopen(ISigns, se);

% Blob extraction
L8 = bwlabel(Iopen,8);

% Return the raw BLOBS
LabelMap = L8;

