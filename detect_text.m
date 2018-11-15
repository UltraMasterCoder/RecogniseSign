I = imread('chars.png');
Ibw = im2bw(I,0.5);
Icompl = imcomplement(Ibw);

Iobj = bwlabel(Icompl,8);
props = regionprops(Iobj, 'Area');
idx = find([props.Area] < 20000);
Iobj = ismember(Iobj, idx);

results = ocr(Iobj);
% results = ocr(rgb2gray(I));
% 
% Iocr = insertObjectAnnotation(I, 'rectangle', results.WordBoundingBoxes, results.WordConfidences);

regularExpr = '\w';

% Get bounding boxes around text that matches the regular expression
bboxes = locateText(results, regularExpr, 'UseRegexp', true);

digits = regexp(results.Text, regularExpr, 'match');

% draw boxes around the digits
Iocr = insertObjectAnnotation(I, 'rectangle', bboxes, digits);



figure;
subplot(1,2,1);
imshow(I);
title('original');
subplot(1,2,2);
imshow(Iocr);
title('text');
