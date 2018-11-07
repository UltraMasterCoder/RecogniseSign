
import mlreportgen.dom.*;

% Read image
I = imread('DTUSignPhotos/DTUSigns003.jpg');
[Ix, Iy] = size(I);
max_size = Ix*Iy;
% Split color components
I_red   = I(:,:,1);
I_green = I(:,:,2);
I_blue  = I(:,:,3);
% Specify number of classes used
num_of_classes = 4;

% % select classes
% % DTUS_ROI = roipoly(I);
% % imwrite(DTUS_ROI, 'DTUSROI.png');
% DTUS_ROI = imread('DTUS_ROI.png');
% DTUS_red_vals = double(I_red(DTUS_ROI));
% DTUS_green_vals = double(I_green(DTUS_ROI));
% DTUS_blue_vals = double(I_blue(DTUS_ROI));
% 
% % nature_ROI = roipoly(I);
% % imwrite(nature_ROI, 'nature_ROI.png');
% nature_ROI = imread('nature_ROI.png');
% nature_red_vals = double(I_red(nature_ROI));
% nature_green_vals = double(I_green(nature_ROI));
% nature_blue_vals = double(I_blue(nature_ROI));
% 
% % ybrickWall_ROI = roipoly(I);
% % imwrite(ybrickWall_ROI, 'ybrickWall_ROI.png');
% ybrickWall_ROI = imread('ybrickWall_ROI.png');
% ybrickWall_red_vals = double(I_red(ybrickWall_ROI));
% ybrickWall_green_vals = double(I_green(ybrickWall_ROI));
% ybrickWall_blue_vals = double(I_blue(ybrickWall_ROI));
% 
% % cobblestone_ROI = roipoly(I);
% % imwrite(cobblestone_ROI, 'cobblestone_ROI.png');
% cobblestone_ROI = imread('cobblestone_ROI.png');
% cobblestone_red_vals = double(I_red(cobblestone_ROI));
% cobblestone_green_vals = double(I_green(cobblestone_ROI));
% cobblestone_blue_vals = double(I_blue(cobblestone_ROI));
% 
% class_names = ["DTU Sign", "nature", "ybrickWall", "cobblestone" ];
% 
% all_red_vals = NaN(max_size, num_of_classes);
% all_red_vals(1:length(DTUS_red_vals),1) = DTUS_red_vals;
% all_red_vals(1:length(nature_red_vals),2) = nature_red_vals;
% all_red_vals(1:length(ybrickWall_red_vals),3) = ybrickWall_red_vals;
% all_red_vals(1:length(cobblestone_red_vals),4) = cobblestone_red_vals;
% 
% all_green_vals = NaN(max_size, num_of_classes);
% all_green_vals(1:length(DTUS_green_vals),1) = DTUS_green_vals;
% all_green_vals(1:length(nature_green_vals),2) = nature_green_vals;
% all_green_vals(1:length(ybrickWall_red_vals),3) = ybrickWall_green_vals;
% all_green_vals(1:length(cobblestone_red_vals),4) = cobblestone_green_vals;
% 
% all_blue_vals = NaN(max_size, num_of_classes);
% all_blue_vals(1:length(DTUS_blue_vals),1) = DTUS_blue_vals;
% all_blue_vals(1:length(nature_blue_vals),2) = nature_blue_vals;
% all_blue_vals(1:length(ybrickWall_red_vals),3) = ybrickWall_blue_vals;
% all_blue_vals(1:length(cobblestone_red_vals),4) = cobblestone_blue_vals;
% 
% 
% colormap = ['r', 'g', 'b', 'y', 'c', 'm', 'k'];
% % show histograms with each colour component
% figure;
% subplot(1,2,1);
% imshow(I);
% title('original Image');
% 
% 
% subplot(3,2,2);
% hist(all_red_vals,255);
% xlim([0 255]);
% title('red Values - classes');
% h = findobj(gca,'Type','patch');
% for i = 1:num_of_classes
%     set(h(i),'FaceColor',colormap(i),'EdgeColor',colormap(i),'FaceAlpha',0.3,'EdgeAlpha',0.3);
% end
% legend(class_names);
% 
% subplot(3,2,4);
% hist(all_green_vals,255);
% xlim([0 255]);
% title('green Values - classes');
% h = findobj(gca,'Type','patch');
% for i = 1:num_of_classes
%     set(h(i),'FaceColor',colormap(i),'EdgeColor',colormap(i),'FaceAlpha',0.3,'EdgeAlpha',0.3);
% end
% 
% subplot(3,2,6);
% hist(all_blue_vals,255);
% xlim([0 255]);
% title('blue Values - classes');
% h = findobj(gca,'Type','patch');
% for i = 1:num_of_classes
%     set(h(i),'FaceColor',colormap(i),'EdgeColor',colormap(i),'FaceAlpha',0.3,'EdgeAlpha',0.3);
% end
% 
% % % RGB Threshold
% % % TODO: This can be done better
% % ISigns = Ired > 150 & Ired < 200  & Igreen > 45 & Igreen < 80 & Iblue > 60 & Iblue < 100;
% % 
% % % TODO: Here should be a lot of intelligent code to extract signs
% % % For example morphological operations and BLOB analysis
% % 
% % % Binary operations to remove small objects
% % se = strel('disk',3);
% % Iopen = imopen(ISigns, se);
% % 
% % % Blob extraction
% % L8 = bwlabel(Iopen,8);
% % 
% % % Return the raw BLOBS
% % LabelMap = L8;
% 
