function [cropped_mask,cropped_img] = pre_process(img)
level = graythresh(img);
bmm = im2bw(img,level);
bmm  = imdilate(bmm,strel('square',3));
bmm_noholes = imfill(bmm,'holes');
x = bwareaopen(bmm_noholes,10000);
x_bb = regionprops(x,'BoundingBox');
cropped_mask = imcrop(x,x_bb.BoundingBox);
cropped_img = imcrop(img,x_bb.BoundingBox);
end