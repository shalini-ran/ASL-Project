function [result,centroid] = findEdgeMapCentroid(img)
    
    a = regionprops(img,'Centroid');
    centroid = a.Centroid;
   %figure; imshow(img); hold on; plot(centroid(1),centroid(2),'x');
    img_dilated = imdilate(img,strel('square',3));
    img_eroded = imerode(img,strel('square',3));
    result = img_dilated-img_eroded;
end