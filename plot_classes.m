load('class_values/mean_std.mat');
[num_classes, color_comps] = size(meanVar);
range = 0:1:255;
% num_classes = 1;
colormap = ['r', 'g', 'b', 'y', 'c', 'm', 'k'];
class_names = ["DTU sign", "yellow brick wall", "cobblestone", "green nature", "sky", "lightgrey wall"];

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
title("Red");
xlim([0 255]);
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
xlim([0 255]);
title("Green");

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
xlim([0 255]);
title("Blue");

print('class_hists','-dpng')