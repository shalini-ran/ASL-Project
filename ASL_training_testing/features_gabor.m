function feat_vec = features_gabor(im_in,gabor_bank,gauss_bank)

im = imresize(im_in,[128,128]);
[mag,~] = imgaborfilt(rgb2gray(im),gabor_bank);

feat_vec = zeros(1,1024);
for i = 1:16
    mag_im = mag(:,:,i);
    for k = 1:8
        for l = 1:8
            wght_im = mag_im.*gauss_bank{k,l};
            feat_vec(1,(i-1)*64+(k-1)*8+l) = sum(wght_im(:));
        end
    end
end

feat_vec = feat_vec/norm(feat_vec);



end

