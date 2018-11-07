%% Merge Matrices from "extract_class.m" 

number_of_classes = 6;
output_file = 'class_values/0_all_class_vals.mat';

%% Examine max length of class

max_rows = 0;
for k = 1:number_of_classes
    X = sprintf('Reshape Matrix to fit class %d',k);
    disp(X)
    name_of_file = sprintf('class_values/class_%d.mat', k);
    load(name_of_file);
    [rows, columns] = size(class_values);
    
    if(rows > max_rows)
        max_rows = rows;
    end    
end
X = sprintf('Reshaping done');
disp(X)
%% Create empty 3-D Matrix
all_class_values = uint8(NaN(max_rows, 3, number_of_classes));

for k = 1:number_of_classes
    X = sprintf('Store class %d in matrix.',k);
    disp(X)
    name_of_file = sprintf('class_values/class_%d.mat', k);
    load(name_of_file);
    [current_rows, current_column] = size(class_values);
    all_class_values(1:current_rows,:,k) = uint8(class_values);
end

X = sprintf('Finished');
disp(X)
save(output_file, 'all_class_values');