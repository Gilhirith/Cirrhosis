function Gaussian_Pyramid

close all;
clear all;
clc;

img1=imread('G:/Liver Capsule/Image/raw_all/sample_normal_2.jpg');
[m, n]=size(img1);
w=fspecial('gaussian',[3 3]);
img2=imresize(imfilter(img1,w),[m/2 n/2]);
img3=imresize(imfilter(img2,w),[m/4 n/4]);
img4=imresize(imfilter(img3,w),[m/8 n/8]);

imshow(img1);
figure,imshow(img2);
figure,imshow(img3);
figure,imshow(img4);

for i = 1 : 20
    x = fix(rand() * (m - 31) + 15);
    y = fix(rand() * (n - 246) + 231);
    img = img1(x : x + 14, y : y + 14);
    imshow(img);
    imwrite(img, ['lev1_', num2str(i), '.jpg']);
end

for i = 1 : 20
    [m, n]=size(img2);
    x = fix(rand() * (m - 31) + 15);
    y = fix(rand() * (n - 111) + 96);
    img = img1(x : x + 14, y : y + 14);
    imwrite(img, ['lev2_', num2str(i), '.jpg']);
end

for i = 1 : 20
    [m, n]=size(img3);
    x = fix(rand() * (m - 31) + 15);
    y = fix(rand() * (n - 65) + 50);
    img = img1(x : x + 14, y : y + 14);
    imwrite(img, ['lev3_', num2str(i), '.jpg']);
end

for i = 1 : 20
    [m, n]=size(img4);
    x = fix(rand() * (m - 31) + 15);
    y = fix(rand() * (n - 31) + 15);
    img = img1(x : x + 14, y : y + 14);
    imwrite(img, ['lev4_', num2str(i), '.jpg']);
end

end