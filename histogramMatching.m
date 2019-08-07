clear
clc
close all

pkg load image 

% 이미지 로딩 
aa=imread('girl.jpg');
ref=imread('lena.jpg');
figure(1); imshow(aa); colormap(gray)
figure(2); imshow(ref); colormap(gray)

M = zeros(256,1,'uint8'); % Store mapping - Cast to uint8 to respect data type
hist1 = imhist(aa); % Compute histograms
hist2 = imhist(ref);
cdf1 = cumsum(hist1) / numel(aa); % Compute CDFs
cdf2 = cumsum(hist2) / numel(ref);

% Compute the mapping
for idx = 1 : 256
    [~,ind] = min(abs(cdf1(idx) - cdf2));
    M(idx) = ind-1;
end

% Now apply the mapping to get first image to make
% the image look like the distribution of the second image
out = M(double(aa)+1);

figure(3); imshow(out); colormap(gray)