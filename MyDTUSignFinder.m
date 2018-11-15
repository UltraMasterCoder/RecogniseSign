% function LabelMap = MyDTUSignFinder(I)

% Show image
I = imread('DTUSignPhotos/DTUSigns001.jpg');

% select sign
% DTUSROI = roipoly(I);
% imwrite(DTUSROI, 'DTUSROI.png');
% %DTUSROI = imread('DTUSROI.png');
% DTUSVals = double(I(DTUSROI));

% % show hist
% imhist(I);
I_orig = I;
I = rgb2ntsc(I_orig);
Iy   = I(:,:,1);
Ichrom = I(:,:,2);
Icolor  = I(:,:,3);
% DTUSredVals = double(Iy(DTUSROI));
% DTUSgreenVals = double(Ichrom(DTUSROI));
% DTUSblueVals = double(Icolor(DTUSROI));

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

% NTSC Threshold
% TODO: This can be done better
ISigns = Iblue > 0.04 & Igreen > 0.12;


% TODO: Here should be a lot of intelligent code to extract signs
% For example morphological operations and BLOB analysis

% Binary operations to remove small objects
se1 = strel('square',10);
se2 = strel('rectangle',[5 10]);
Imorph1 = imopen(ISigns, se1);
Imorph2 = imopen(ISigns, se2);

% se12 = strel('square',10);
% se22 = strel('rectangle',[5 10]);
% Imorph12 = imclose(Imorph1, se12);
% Imorph22 = imclose(Imorph2, se22);

Fill holes in signd (Text)
Imorph1 = imfill(Imorph1,'holes');
Imorph2 = imfill(Imorph2,'holes');


Imorph12 = bwlabel(Imorph1,4);
props12 = regionprops(Imorph12, 'Area');
idx12 = find([props12.Area] > 2000);
Imorph12 = ismember(Imorph12, idx12);
% Imorph12 = label2rgb(bwlabel(Imorph12,4), 'spring', 'c', 'shuffle');

Imorph22 = bwlabel(Imorph2,4);
props22 = regionprops(Imorph22, 'Area');
idx22 = find([props22.Area] > 2000);
Imorph22 = ismember(Imorph22, idx22);
% Imorph22 = label2rgb(bwlabel(Imorph22,4), 'spring', 'c', 'shuffle');

se13 = strel('rectangle',[5 15]);
se23 = strel('rectangle',[5 15]);
Imorph13 = imclose(Imorph12, se13);
Imorph23 = imclose(Imorph22, se23);


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
imshow(Imorph13);
title('Square');
subplot(3,4,8);
imshow(Imorph23);
title('Rectangle');
% Blob extraction
L8 = bwlabel(Imorph2,8);

% Return the raw BLOBS
LabelMap = L8;


