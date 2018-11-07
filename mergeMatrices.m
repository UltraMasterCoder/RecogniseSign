%% Merge Matrices from "extract_class.m" 

number_of_classes = 6;


%% Change Directory - Matrices Folder
% cd .\class_values

%% Examine max length of class

max_rows = 0;
for k = 1:number_of_classes
    name_of_file = sprintf('class_values/class_%d.mat', k);
    load(name_of_file);
    [rows, columns] = size(class_values);
    
    if(rows > max_rows)
        max_rows = rows;
    end    
end

%% Create empty 3-D Matrix
all_class_values = NaN(max_rows, 3, number_of_classes);

for k = 1:number_of_classes
    name_of_file = sprintf('class_values/class_%d.mat', k);
    load(name_of_file);
    [current_rows, current_column] = size(class_values);
    all_class_values(1:current_rows,:,k) = class_values;
end

