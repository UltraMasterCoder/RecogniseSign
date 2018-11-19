function LabelMap = MyDTUSignFinder(Irgb)

    %% load image
    % load image (DEBUG)
%     Irgb = imread('DTUSignPhotos/DTUSigns001.jpg');
    %% pixel classification
    % we make our image into a NTSC image(luminance, chrominance, and color
    % components )
    Intsc = rgb2ntsc(Irgb);
    Ilum   = Intsc(:,:,1);
    Ichr = Intsc(:,:,2);
    Icom  = Intsc(:,:,3);

    % RGB threshold
    % ISigns = Igreen > 0.5 & Igreen < 0.8 & Iblue > 0.35 & Iblue < 1;

    % NTSC Threshold
    ISigns = Icom > 0.04 & Ichr >0.12;
    % we remove the letters with a matlab filling function
    ISigns = imfill(ISigns,'holes') ;

    %% Morphology operations
    % Binary operations to remove small objects
    se_open1 = strel('square',10); % perhaps this should be 30 ???
    % se_open1 = strel('rectangle',[3 5]);
    Iopened1 = imopen(ISigns, se_open1);

    % it seems that Imorph1 has better performace 

    % se_close1 = strel('square',10);
    % se_close1 = strel('rectangle',[5 10]);
    % Iclosed1 = imclose(Iopened1, se_close1);    

    %% Blob extraction

    %% Applying 'Area'
    Ilabel = bwlabel(Iopened1,4);
    % Remove object from the border
    Iborder = imclearborder(Ilabel);

    areaProps = regionprops(Iborder, 'Area');
    area1 = [areaProps.Area];
    idx12 = find(area1 > 2640);
    Iarea1 = ismember(Iborder, idx12);
    area1 = area1(find(area1 > 2640));
    % Imorph12 = label2rgb(bwlabel(Iarea1,4), 'spring', 'c', 'shuffle');


    se_close2 = strel('rectangle',[5 15]);
    % se_close2 = strel('rectangle',[5 15]);
    Iclosed2 = imclose(Iarea1, se_close2);

    %% Applying 'Circularity'
    Ilabel = bwlabel(Iclosed2,4);
    p1 = regionprops(Ilabel, 'Perimeter');
    perim1 = [p1.Perimeter];
    areaProps = regionprops(Ilabel, 'Area');
    area1 = [areaProps.Area];
    for i = 1:length(perim1)
        circ1(i) = (2*sqrt(pi*area1(i)))/perim1(i);
    end
    Ilabel = bwlabel(Iclosed2,4);
    idxCirc1 = find(circ1 < 0.85);
%     idxCirc1 = find((circ1 < 0.9)  & (circ1 > 0.55) );
    Icirc1 = ismember(Ilabel, idxCirc1);


    %% Applying 'Compactness'

    Ilabel = bwlabel(Icirc1,4);
    areaProps = regionprops(Ilabel, 'Area');
    bbProps = regionprops(Ilabel, 'BoundingBox');

    for i = 1:length(bbProps)
        comp1(i) = areaProps(i).Area/(bbProps(i).BoundingBox(3)*bbProps(i).BoundingBox(4));
    end

    idxComp1 = find(comp1 > 0.50);
    Icomp1 = ismember(Ilabel, idxComp1);



    %% Applying 'Bounding box ratio'
    Ilabel = bwlabel(Icomp1,4);
    bbr1 = regionprops(Ilabel,'BoundingBox');
    for k = 1:length(bbr1)  
        bbr11(k,1) = [bbr1(k).BoundingBox(4)]/[bbr1(k).BoundingBox(3)];
    end

    idx13 = find((transpose(bbr11) < 0.5 & transpose(bbr11) > 0.13) | (transpose(bbr11) < 1.7 & transpose(bbr11) > 1.5));
    Ibbox1 = ismember(Ilabel, idx13);


    figure;
    subplot(3,4,1);
    imshow(Irgb);
    title('Original');
    subplot(3,4,2);
    imshow(ISigns);
    title('Pixel classified');
    subplot(3,4,3);
    imshow(Iopened1);
    title('Opening');
    subplot(3,4,4);
    imshow(Iborder);
    title('Border');

    subplot(3,4,5);
    imshow(Iarea1);
    title('BLOB Area');
    subplot(3,4,6);
    imshow(Iclosed2);
    title('Closing');
    subplot(3,4,7);
    imshow(Icirc1);
    title('BLOB Circularity');
    subplot(3,4,8);
    imshow(Icomp1);
    title('BLOB Compactness');

    subplot(3,4,9);
    imshow(Ibbox1);
    title('BLOB BBRatio');

    % Blob extraction for output
    L8 = bwlabel(Ibbox1,8);
    % Return the raw BLOBS
    LabelMap = L8;
end

