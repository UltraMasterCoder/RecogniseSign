function [meanVar,stdVar] = extractMeanStd( class_val)
%EXTRACTMEANSTD Summary of this function goes here
%   Detailed explanation goes here
    dim = size(class_val) ; 
    meanTemp = zeros(dim(3),3 ) ;
    stdTemp = zeros(dim(3),3 ) ;
    
    for class =1:dim(3) 
        for RGB = 1:3
            n = nnz(class_val(:,RGB,class));
            meanTemp(class,RGB) = mean(double(class_val(1:n,RGB,class))) ;
            stdTemp(class,RGB) = std(double(class_val(1:n,RGB,class))) ; 
        end 
        
    end 
    
    meanVar = meanTemp ;
    stdVar = stdTemp ;

end

