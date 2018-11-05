
import mlreportgen.dom.*;

% Read image
I = imread('DTUSignPhotos/DTUSigns003.jpg');
% Split color components
I_red   = I(:,:,1);
I_green = I(:,:,2);
I_blue  = I(:,:,3);

% select classes
% DTUS_ROI = roipoly(I);
% imwrite(DTUS_ROI, 'DTUSROI.png');
DTUS_ROI = imread('DTUS_ROI.png');
DTUS_Vals = double(I(DTUS_ROI));
DTUS_red_vals = double(I_red(DTUS_ROI));
DTUS_green_vals = double(I_green(DTUS_ROI));
DTUS_blue_vals = double(I_blue(DTUS_ROI));

% Background_ROI = roipoly(I);
% imwrite(Background_ROI, 'Background_ROI.png');
Background_ROI = imread('Background_ROI.png');
Background_Vals = double(I(Background_ROI));
Background_red_vals = double(I_red(Background_ROI));
Background_green_vals = double(I_green(Background_ROI));
Background_blue_vals = double(I_blue(Background_ROI));

class_names = ['DTU Sign', 'Background'];

% ul = OrderedList({Text('item1'),'item 2',3});
% 
% all_red_vals{1} = DTUS_red_vals;
% all_red_vals{2} = Background_red_vals;
% 
% all_green_vals{1} = DTUS_green_vals;
% all_green_vals{2} = Background_green_vals;
% 
% all_blue_vals{1} = DTUS_blue_vals;
% all_blue_vals{2} = Background_blue_vals;
pixel_count = 0;
for obj = [length(DTUS_red_vals), length(Background_red_vals)]
    if pixel_count < obj
        pixel_count = obj;
    end
end
all_red_vals = zeros(pixel_count, num_of_classes);
all_red_vals(:,1) = DTUS_red_vals;
all_red_vals(:,2) = Background_red_vals;
% all_red_vals = [DTUS_red_vals DTUS_green_vals ];
all_green_vals = [DTUS_green_vals Background_green_vals];
all_blue_vals = [DTUS_blue_vals Background_green_vals];
[N, num_of_classes] = size(all_red_vals);
colormap = ['r', 'g', 'b'];%....
% show histograms with each colour component
figure;
subplot(1,2,1);
imshow(I);
title('original Image');

subplot(3,2,2);
hist(all_red_vals,255);
xlim([0 255]);
title('red Values');
h = findobj(gca,'Type','patch');
for i = 1:num_of_classes
    set(h(i),'FaceColor',colormap(i),'EdgeColor',colormap(i),'FaceAlpha',0.3,'EdgeAlpha',0.3);
end

subplot(3,2,4);
hist(all_green_vals,255);
xlim([0 255]);
title('green Values');
h = findobj(gca,'Type','patch');
for i = 1:num_of_classes
    set(h(i),'FaceColor',colormap(i),'EdgeColor',colormap(i),'FaceAlpha',0.3,'EdgeAlpha',0.3);
end

subplot(3,2,6);
hist(all_blue_vals,255);
xlim([0 255]);
title('blue Values');
h = findobj(gca,'Type','patch');
for i = 1:num_of_classes
    set(h(i),'FaceColor',colormap(i),'EdgeColor',colormap(i),'FaceAlpha',0.3,'EdgeAlpha',0.3);
end

% % RGB Threshold
% % TODO: This can be done better
% ISigns = Ired > 150 & Ired < 200  & Igreen > 45 & Igreen < 80 & Iblue > 60 & Iblue < 100;
% 
% % TODO: Here should be a lot of intelligent code to extract signs
% % For example morphological operations and BLOB analysis
% 
% % Binary operations to remove small objects
% se = strel('disk',3);
% Iopen = imopen(ISigns, se);
% 
% % Blob extraction
% L8 = bwlabel(Iopen,8);
% 
% % Return the raw BLOBS
% LabelMap = L8;

