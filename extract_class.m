% Label a class in the training images
% #####Classes#####
% 1: DTU sign
% 2: yellow brick wall
% 3: cobblestone
% 4: green nature
% 5: sky
% 6: grey wall

% probably a separate class. Just if the classifiers perform not good
% enough.
% x: blue sign
% x: brown nature

% #####Description#####
% This script helps you to label one particular class in each of our
% training images. Follow these steps to accomplish this:
% 1. Select the class number you want to label
%   - Find the number of each class in the list above.
%   - Write the number in the variable class_num
% 2. Run the script
%   - A ROIpoly window appears, where each image is displayed one after
%     another. 
%   - Label the class in each image.
%      - If there is more than one object representing tha class
%        you want to label in the image, just label the least common one.
%      - If the class doesn't appear in the image, just close the window.
%        The next image will be displayed in a new window automatically.
% 3. After labeling the last image the window remains open. Close the
%    window.
% 4. All values of the class are stored in one file in the directory
%    "class_values". The filename contains the class number.
class_num = 2;

all_red_vals = [];
all_green_vals = [];
all_blue_vals = [];
% im_numbers = [1:2:67];  % All Images
im_numbers = [1:2:4];
output_file = sprintf('class_values/class_%d.mat',class_num);

for im_num = im_numbers
    % Compute prefix for image number
    if im_num < 10
        im_num_prefix = '00';
    else
        im_num_prefix = '0';
    end
    % Read image
    input_file = sprintf('DTUSignPhotos/DTUSigns%s%d.jpg',im_num_prefix,im_num);
    I = imread(input_file);
    % Split color components
    I_red   = I(:,:,1);
    I_green = I(:,:,2);
    I_blue  = I(:,:,3);
    % select classes
    Class_ROI = roipoly(I);
    red_vals = double(I_red(Class_ROI));
    green_vals = double(I_green(Class_ROI));
    blue_vals = double(I_blue(Class_ROI));

    all_red_vals = [all_red_vals; red_vals];
    all_green_vals = [all_green_vals; green_vals];
    all_blue_vals = [all_blue_vals; blue_vals];
end

% % store values in matrix
class_values = NaN(length(all_red_vals), 3);
class_values(:,1) = all_red_vals;
class_values(:,2) = all_green_vals;
class_values(:,3) = all_blue_vals;
save(output_file, 'class_values');


