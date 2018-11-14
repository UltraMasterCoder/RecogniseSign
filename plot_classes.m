load('class_values/mean_std.mat');
% meanVar = mean;
% stdVar = std;
[num_classes, color_comps] = size(meanVar);
% range = 0:(1/255):1;
range = 0:1:255;
% num_classes = 1;
colormap = ['r', 'g', 'b', 'y', 'c', 'm', 'k'];
class_names = ["DTU sign", "yellow brick wall", "cobblestone", "green nature", "sky", "lightgrey wall"];

xlimits = [0 255];
figure;
% Plot red hist
subplot(3,1,1);
all_distributions = NaN(num_classes,256);
color = 1; % red
for i = 1:num_classes
    mu = meanVar(i,color);
    sigma = stdVar(i,color);
    all_distributions(i,:) = normpdf(range,mu,sigma);
    hold on;
    plot(range, all_distributions(i,:), 'color', colormap(i));
    hold off;
end
title("Hue");
xlim(xlimits);
legend(class_names, 'location', 'northwest');

% Plot green hist
subplot(3,1,2);
all_distributions = NaN(num_classes,256);
color = 2; % green
for i = 1:num_classes
    mu = meanVar(i,color);
    sigma = stdVar(i,color);
    all_distributions(i,:) = normpdf(range,mu,sigma);
    hold on;
    plot(range, all_distributions(i,:), 'color', colormap(i));
    hold off;
end
xlim(xlimits);
title("Saturation");

% Plot blue hist
subplot(3,1,3);
all_distributions = NaN(num_classes,256);
color = 3; % blue
for i = 1:num_classes
    mu = meanVar(i,color);
    sigma = stdVar(i,color);
    all_distributions(i,:) = normpdf(range,mu,sigma);
    hold on;
    plot(range, all_distributions(i,:), 'color', colormap(i));
    hold off;
end
xlim(xlimits);
title("Intensity");

print('class_hists_hsi','-dpng')

% nSign = 41;
% ImageName = sprintf('DTUSignPhotos/DTUSigns%03d.jpg', nSign);
% LMName    = sprintf('DTUSignPhotos/DTUSigns%03d.txt', nSign);
% 
% 
% I = imread(ImageName);
% LM = dlmread(LMName);
% 
% LabelMap = CreateLabelMapFromAnnotations(I, LM);
% RGBLabels = label2rgb(LabelMap);
% 
% Ired   = I(:,:,1);
% Igreen = I(:,:,2);
% Iblue  = I(:,:,3);
% 
% ISigns = Ired > 117 & Ired < 255  & Igreen > 0 & Igreen < 105 & Iblue > 0 & Iblue < 115;
% 
% figure;
% subplot(1,3,1); imshow(I);  title('Input image')
% subplot(1,3,2); imshow(ISigns);  title('Our output')
% subplot(1,3,3);imagesc(RGBLabels); axis image; title('Ground truth signs')
% % 
% figure;
% % Plot red hist
% subplot(3,1,1);
% hist(Ired,255)
% xlim([0 255]);
% title("Red");
% xlim([0 255]);
% 
% % Plot green hist
% subplot(3,1,2);
% hist(Iblue,255)
% xlim([0 255]);
% title("Green");
% 
% % Plot blue hist
% subplot(3,1,3);
% hist(Ired,255)
% xlim([0 255]);
% xlim([0 255]);
% title("Blue");

% nSign = 13;
% ImageName = sprintf('DTUSignPhotos/DTUSigns%03d.jpg', nSign);
% I_bright = imread(ImageName);
% nSign = 21;
% ImageName = sprintf('DTUSignPhotos/DTUSigns%03d.jpg', nSign);
% I_med = imread(ImageName);
% nSign = 19;
% ImageName = sprintf('DTUSignPhotos/DTUSigns%03d.jpg', nSign);
% I_dark = imread(ImageName);
% 
% figure;
% subplot(3,1,1);
% J_bright = histeq(I_bright);
% imshowpair(I_bright,J_bright, 'montage');
% subplot(3,1,2);
% J_med = histeq(I_med);
% imshowpair(I_med,J_med, 'montage');
% subplot(3,1,3);
% J_dark = histeq(I_dark);
% imshowpair(I_dark,J_dark, 'montage');