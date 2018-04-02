function predictASL(input_img_path, output_img_path, KNNClassifier, gabor_bank, gauss_bank, count)
%------------------------------------------------------------------------------
% INPUT:
% input_img_path 	- input image path
% output_img_path 	- output image path
% KNNClassifier     - pre-trained classifier
% gabor_bank        - from initialize_gabor.m
% gauss_bank        - from initialize_gabor.m
% count             - sequence number of the image
%------------------------------------------------------------------------------
tic;

if nargin < 2
    input_img_path =('./upload/test.jpg');
    output_img_path =('./output/test.jpg');
end

if(isempty(input_img_path))
    input_img_path =('./upload/test.jpg');
end
    
if(isempty(output_img_path))
    output_img_path =('./output/test.jpg');
end

imwrite(zeros(640,480), output_img_path,'Quality',100);

% read input image
InputImg = imread(input_img_path) ;

% resize to low-res Android camera aspect ratio
InputImg = imresize(InputImg,[852 1136]);

% run prediction pipeline
imwrite(InputImg, sprintf('input_file_%d.jpg',count));
letter = {'a','b','c','d','e','f','g','h','i','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y'};
[cropped_mask,cropped_img] = pre_process(InputImg);
features = [feat_extract_gabor(cropped_img,gabor_bank,gauss_bank),feat_hocd(cropped_mask)];
prediction = KNNClassifier.predictFcn(features);
outI = imread(strcat('alphabet/',letter{prediction},'.jpg'));

% resize output image and write it to output path
outI = imresize(outI, [size(InputImg,1) size(InputImg,2)]);
imwrite(outI, output_img_path,'Quality',100);
toc

end
