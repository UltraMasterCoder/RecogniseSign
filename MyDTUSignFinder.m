% function LabelMap = MyDTUSignFinder(I)

%% load image
% load image (DEBUG)
Irgb = imread('DTUSignPhotos/DTUSigns037.jpg');
%% pixel classification
% we make our image into a NTSC image(luminance, chrominance, and color
% components )
Intsc = rgb2ntsc(Irgb);
Ilum   = Intsc(:,:,1);
Ichr = Intsc(:,:,2);
Icom  = Intsc(:,:,3);

% RGB threshold
% ISigns = Igreen > 0.5 & Igreen < 0.8 & Iblue > 0.35 & Iblue < 1;

% NTSC Threshold
ISigns = Icom > 0.04 & Ichr >0.12;
% we remove the letters with a matlab filling function
ISigns = imfill(ISigns,'holes') ;

%% Morphology operations
% Binary operations to remove small objects
se1 = strel('square',10); % perhaps this should be 30 ???
se2 = strel('rectangle',[3 5]);
Imorph1 = imopen(ISigns, se1);
Imorph2 = imopen(ISigns, se2);

% it seems that Imorph1 has better performace 

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
imshow(Irgb);
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
imshow(Intsc);
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


