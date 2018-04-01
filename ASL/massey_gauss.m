clc; clear all; close all;
x = 1;
letter = {'a','b','c','d','e','f','g','h','i','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y'};
features_complete = [];
[gabor_bank,gauss_bank] = initialize_gabor;
srcFiles = dir('MasseyDataset/*.png');
count = ones(1,24);
%% select images from dataset, segment out background and store them in a new folder
for j = 1:24                 
        for k= 1:size(srcFiles,1)
            
            str = cell2mat(strsplit(srcFiles(k).name));
            
            if str(7) == letter{j} && count(j) <= 10
                
                count(j) = count(j) + 1;
                filename = strcat('MasseyDataset/',srcFiles(k).name);
                X = imread(filename);           
               
                %%%%Morphological Preprocessing%%%%%
               [cropped_mask,cropped_img] = pre_process(X);
           
%                 %%%%Extracting only HOCD%%%%
                features{x} = features_hocd(cropped_mask);
%                 
%                 %%%%Extracting only Gabor%%%%
%                 features{x} = features_gabor(cropped_img,gabor_bank,gauss_bank);
%                 
                %%%Extracting HOCD+Gabor%%%%
%                features{x} = [features_gabor(cropped_img,gabor_bank,gauss_bank),features_hocd(cropped_mask)];
                        
                %%%Extracting SURF Points%%%%
                 points = detectSURFFeatures(rgb2gray(cropped_img));
                [features{x},valid_points]  = extractFeatures(rgb2gray(cropped_img),points);
                
                
                %%% update total features %%%
                features_complete = [features_complete;features{x}];
                
                %%% assign class labels %%%
                Y(x,1) = j;
                x = x+1
            end
         end
end


% 
% % uncomment if using surf bag of words features
% 
% k = 200;
% [~,C] = kmeans(features_complete,k);
% 
% %% compute histograms for each image by assigning feature descriptors in image to nearest cluster centroid
% hist = zeros(x-1,k);
% dist = [];
% for i = 1:x-1
%     for j = 1:size(features{i},1)
%         for l = 1:size(C,1)
%             dist(l) = sqrt(sum((features{i}(j,:)-C(l,:)).^2,2));
%         end
%         [~,idx] = min(dist);
%         hist(i,idx) = hist(i,idx) + 1;
%     end
% end
% 
% 
% for i = 1:x-1
%     hist(i,:) = hist(i,:)/norm(hist(i,:),2);
% end
% 
% 




%%% compute KNN Classifier Model and generalization error for this model %%%

%%%uncomment if using only hocd features, keep other two commented
%[trainedClassifier, gen_error] = trainKNNClassifier_hocd([features_complete,Y]);

%%%uncomment if using only gabor features, keep other two commented
% [trainedClassifier, gen_error] = trainKNNClassifier_gabor([features_complete,Y]);

%%%uncomment if using only hocd and gabor features, keep other two commented
% [trainedClassifier, gen_error] = trainKNNClassifier_hocd_plus_gabor([features_complete,Y]);

%%%uncomment if using only SURF Bag of Words features, keep other two commented
[trainedClassifier, gen_error] = trainKNNClassifier_SURFBoW([hist,Y]);






% load('captured.mat','img');
% features_complete_test = [];
% x_test = 1;
% for i = 1:15
%     img_test{i} = imresize(img{i},1);
%     [feat_leaf,cropped] = leaf_method(img_test{i});
%     features_test{i} = [feat_extract_gabor(cropped),feat_leaf];
% %     label_test(i,1) = i;
%     features_complete_test = [features_complete_test;features_test{i}]; 
%     x_test = x_test+1;
% end




% hist_test = features_complete_test;
% 
% predicted = predict(Mdl,hist_test);
% error = 1 - (size(find(predicted == label_test),1)/size(predicted,1));




