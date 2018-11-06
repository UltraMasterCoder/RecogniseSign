function newImage = standardiseRGB( Image )
%STANDARDISERGB Summary of this function goes here
%   Detailed explanation goes here
    DEBUG = 1 ;
    % split image 
    R = Image(:,:,1) ;
    G = Image(:,:,2) ; 
    B = Image(:,:,3) ;
    if DEBUG == 1 
        % show histogram before
        subplot(3,2,1) 
        histogram(R) ;
        title('Red Original')
        subplot(3,2,3) 
        histogram(G) ;
        title('Green Original')
        subplot(3,2,5) 
        histogram(B) ;
        title('Blue Original')
    end
    % get limits 
   Clim = [ min(R(:)) , max(R(:)) , ...
            min(G(:)) , max(G(:)) , ...  
            min(B(:)) , max(B(:)) ] ;
    
    % get dimension of image
    dim = size(Image) ;
    
    % now we rescale the values 
    Vmaxd = 255 ; Vmind = 0 ;
    for RGB = 1:3 
        Vmin = Clim(fix(1.75*RGB)) ; Vmax = Clim(RGB*2) ;
        Ratio = (Vmaxd - Vmind) / (Vmax - Vmin) ;
        for row = 1:dim(1) 
            for col = 1:dim(2)
                Image(row,col,RGB) =  Ratio * Image(row,col,RGB) + Vmind ;
            end 
        end 
    end
    if DEBUG == 1 
        % show histogram after
        subplot(3,2,2) 
        histogram(Image(:,:,1)) ; 
        title('Red Standard')
        subplot(3,2,4) 
        histogram(Image(:,:,2)) ;
        title('Green standard')
        subplot(3,2,6) 
        histogram(Image(:,:,3)) ;
        title('Blue standard')
    end 
    % return new image
    newImage = Image ;
end

