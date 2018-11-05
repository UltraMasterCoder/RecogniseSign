function LabelMap = MyDTUSignFinder(I)

Ired   = I(:,:,1);
Igreen = I(:,:,2);
Iblue  = I(:,:,3);

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

