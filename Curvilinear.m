% % Main
clc;
clear all;
close all;
% %
img_ori = im2double(imread('CoreView_275_Master_Camera_00001.bmp'));
bkd = im2double(imread('bkd_275_new.bmp'));
figure, imshow(img_ori);
img_ori = imsubtract(bkd, img_ori);

LOW_HIGH = stretchlim(img_ori, [0.9, 1]);
img_ori =imadjust(img_ori, LOW_HIGH);

% img_ori = img_ori(1430 : 1652, 1253 : 1502);
% img_ori = img_ori(1120 : 1384, 1090 : 1346);
% img_ori = img_ori(162 : 349, 1213 : 1575);
% imwrite(img_ori, 'fish_sigle.jpg');
% img_ori = imread('test.bmp');

figure, imshow(img_ori);
[img_height, img_width, img_dimension] = size(img_ori);
if img_dimension > 1
    img_ori = rgb2gray(img_ori);
end
% img_ori = imcomplement(img_ori);
figure, imshow(img_ori);
hold on;
img = double(img_ori);
label = zeros(img_height, img_width);
% %
sigma_begin = 1;
sigma_end  = 100;
sigma_step = 1;
thres = 0.5;
sigma_array =sigma_begin:sigma_step:sigma_end;
sigma_nb = numel(sigma_array);
       
% 计算规范化的DoH算子
snlo = zeros(img_height,img_width,sigma_nb);

sigma = sigma_array(10); % edit fish:10 line: 4
w = 30; %3 * sigma
[x y] = meshgrid(-w : w, -w : w);
sigma2 = sigma^2;
temp = exp(-(x.^2 + y.^2) / (2 * sigma2)) / (2 * pi * sigma2);

% % for dark line
% mxx = temp .* (x.^2 / sigma2 - 1);
% % figure, mesh(x, y, mxx);
% myy = temp .* (y.^2 / sigma2 - 1);
% % figure, mesh(x, y, myy);
% mxy = temp .* (x .* y / sigma2);
% % figure, mesh(x, y, mxy);
% mx = temp .* (-x);
% % figure, mesh(x, y, mx);
% my = temp .* (-y);
% % figure, mesh(x, y, my);

mxx = -temp .* (x.^2 / sigma2 - 1);
% figure, mesh(x, y, mxx);
myy = -temp .* (y.^2 / sigma2 - 1);
% figure, mesh(x, y, myy);
mxy = -temp .* (x .* y / sigma2);
% figure, mesh(x, y, mxy);
mx = -temp .* (-x);
% figure, mesh(x, y, mx);
my = -temp .* (-y);
% figure, mesh(x, y, my);


dxx = imfilter(img,mxx,'replicate');
dyy = imfilter(img,myy,'replicate');
dxy = imfilter(img,mxy,'replicate');
dx = imfilter(img,mx,'replicate');
dy = imfilter(img,my,'replicate');
% figure, imshow(dxx);
% figure, imshow(dyy);
% figure, imshow(dxy);
% figure, imshow(dx);
% figure, imshow(dy);

num = 1;
tic
idx = find(img >= 0.2);
s = size(img);

maxt = -1e10;
mint = 1e10;
for i = 1 : length(idx)
    id = idx(i);
%     tic;
    [EigVector(1 : 2, 1 : 2), ev] = eig([dxx(id), dxy(id); dxy(id), dyy(id)]);
%     toc;
%     Del = dxx(id).*dyy(id)-dxy(id).^2;
    if abs(ev(1, 1)) > abs(ev(2, 2))
        nx = EigVector(1,1);
        ny = EigVector(1,2);
%         order2 = abs(ev(id, 1)); 
    else
        nx = EigVector(2,1);
        ny = EigVector(2,2);
%         order2 = abs(ev(id, 2)); 
    end
    tp = sqrt(nx^2 + ny^2);
    nx = nx / tp;
    ny = ny / tp;
    theta = atan2(ny, nx);

    t = - (dx(id) * nx + dy(id) * ny) / (dxx(id) * nx^2 + 2 * dxy(id) * nx * ny + dyy(id) * ny^2);
%     maxt = max((dxx(id) * nx^2 + 2 * dxy(id) * nx * ny + dyy(id) * ny^2), maxt);
%     mint = min((dxx(id) * nx^2 + 2 * dxy(id) * nx * ny + dyy(id) * ny^2), mint);
    px = t * nx;
    py = t * ny;
    if px >= -thres && px <= thres && py <= thres && py >= -thres% && (dxx(id) * nx^2 + 2 * dxy(id) * nx * ny + dyy(id) * ny^2) < -0.2 %  && order2 > 8 && order2 < 15
        [row, col] = ind2sub(s, id);
%         quiver(col, row, nx * 10, ny * 10); %for dark line: quiver(col, row, nx * 10, ny * 10);
%         row = mod(id, img_height);
%         if row == 0
%             row = img_height;
%         end
%         col = (id - row) / img_height + 1;
        label(row, col) = 1;
%         sequence(num) = order2;
        num = num + 1;
    end
end
% maxt
% mint
toc

% figure, imshow(label, []);

small_Ivessel_skel = bwmorph(label, 'skel', Inf);
small_Ivessel_skel = bwmorph(small_Ivessel_skel, 'spur', 5);
% figure, imshow(small_Ivessel_skel);

idx = find(small_Ivessel_skel == 1);

[I, J] = ind2sub(s, idx);
plot(J, I, 'r.');
axis equal;
% plot(label(I, ));