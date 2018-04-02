function [gabor_bank,gauss_bank] = initialize_gabor
%% Create Gabor Bank
l_exp = 1:4;
lambda = 2.*(2.^l_exp);
theta = 0:45:135;

gabor_bank = gabor(lambda,theta);

%% Create Gauss Bank
n_size = 128;
s = 8;
gauss_arr = cell(8,1);
for i = 1:8
    x_ax = 1:128;
    gauss_arr{i,1} = exp(-(x_ax - (16*i - 8)).^2/(2*s^2));
end

bank_im = zeros(n_size,n_size);
gauss_bank = cell(8,8);
for i = 1:8
    for j = 1:8
        gauss_bank{i,j} = gauss_arr{i,1}.' * gauss_arr{j,1};
        bank_im = bank_im + gauss_bank{i,j};
    end
end
end