% load('class_values/0_all_class_vals.mat');
% 
% 
% [rows,comps,classes] = size(all_class_values);
% 
% all_class_values = double(all_class_values)./255;
% 
% for class = 1:classes
%    all_class_values(:,:,class) = rgb2hsv(all_class_values(:,:,class));
% end

[mean, std] = extractMeanStd(all_class_values);