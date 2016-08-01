function CenterPixels = ExtractCenterPixels(ImageName, p)

im = imread(ImageName);

H = size(im,1);
W = size(im,2);
%go to the upper left corner of the extraction region
mid_x = floor((W-p*W)/2)+1; 
mid_y = floor((H-p*H)/2)+1;

%extract rectangular from the region
CenterPixels= im(mid_y: floor(mid_y+p*H)-1,...
    mid_x: floor(mid_x+p*W)-1,:);
end