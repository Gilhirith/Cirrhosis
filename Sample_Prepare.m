close all;
clear all;
clc;

global ht_thr;
global nsample_per_img;
global sample_ht;
global sample_wd;

ht_thr = 350;
nsample_per_img = 20;
n_normal = 680;
n_mild = 580;
n_moderate = 440;
n_severe = 300;

addpath(genpath('G:/Liver Capsule/'));

% img_normal_dir = 'G:/Liver Capsule/Image/Cirrhosis/normal_liver/';
% img_severe_dir = 'G:/Liver Capsule/Image/Cirrhosis/cirrhosis/3/';
% img_mild_dir = 'G:/Liver Capsule/Image/Cirrhosis/cirrhosis/1/';
% img_moderate_dir = 'G:/Liver Capsule/Image/Cirrhosis/cirrhosis/2/';

img_normal_dir = 'G:/Liver Capsule/Image/raw_image/normal/';
img_severe_dir = 'G:/Liver Capsule/Image/raw_image/severe/';
img_mild_dir = 'G:/Liver Capsule/Image/raw_image/mild/';
img_moderate_dir = 'G:/Liver Capsule/Image/raw_image/moderate/';

% % % cut original full image and get raw images
% classes = 'normal';
% for fr = 1 : 50
%     if exist([img_normal_dir, classes, '_', num2str(fr), '.jpg'])
%         img = rgb2gray(imread([img_normal_dir, classes, '_', num2str(fr), '.jpg']));
%         figure, imshow(img);
%         [x_l, y_l] = ginput;
%         [x_r, y_r] = ginput;
%         
%         img = img(fix(y_l) : fix(y_r), fix(x_l) : fix(x_r));
%         figure, imshow(img);
%         BW = edge(img, 'canny');  % µ÷ÓÃcannyº¯Êý
% %         figure, imshow(BW);
%         se = strel('disk', 1);
%         BW = imdilate(BW, se);
% %         figure, imshow(BW);
%         stats = regionprops(BW, 'all');
%         allArea = [stats.Area];
%         [max_area, max_area_idx] = max(allArea(:));
%         [h_img w_img] = size(BW);
%         max_area = 0;
%         box = stats(max_area_idx).BoundingBox;
%         row1 = box(2) + 0.5;
%         row2 = row1 + box(4);
%         col1 = box(1) + 0.5;
%         col2 = col1 + box(3);
%         row_select = row1 : row2;
%         col_select = col1 : col2;
%         img_small = img(row_select, col_select);
% %         figure, imshow(img_small);
% %         size(img_small)
%         img_small = img;
%         [ht, wd] = size(img_small);
%         img_w_st = 1;
%         img_w_ed = wd;
%         for img_w_st = 1 : wd
%             if mean(img_small(1 : end, img_w_st)) > 0.5
%                 break;
%             end
%         end
%         for img_w_ed = wd : -1 : 1
%             if mean(img_small(1 : end, img_w_ed)) > 0.5
%                 break;
%             end
%         end
%         img_h_st = 1;
%         img_h_ed = ht;
%         for img_h_st = 1 : ht
%             if mean(img_small(img_h_st, 1 : end)) > 0.5
%                 break;
%             end
%         end
%         for img_h_ed = ht : -1 : 1
%             if mean(img_small(img_h_ed, 1 : end)) > 0.5
%                 break;
%             end
%         end
%         
%         img_small = img_small(img_h_st : img_h_ed, img_w_st : img_w_ed);
% %         figure, imshow(img_small);
%         imwrite(img_small, [img_normal_dir, 'cut_', classes, '_', num2str(fr), '.jpg']);
% %         size(img_small)
% %         tic;
%         close all;
%     end
% end

% % % cut sample image from raw images
% cnt = 0;
% for fr = 1 : 100
%     if exist([img_moderate_dir num2str(fr) '.bmp'])
%         img = im2double(imread([img_moderate_dir num2str(fr) '.bmp']));
%         imwrite(imcomplement(img), [img_moderate_dir, 'im_', num2str(fr), '.bmp']);
% %         figure, imshow(imcomplement(img));
% %         [ht, wd] = size(img);
% %         img_w_st = 1;
% %         img_w_ed = wd;
% %         for img_w_st = 1 : wd
% %             if mean(img(350 : 400, img_w_st)) > 0
% %                 break;
% %             end
% %         end
% %         for img_w_ed = wd : -1 : 1
% %             if mean(img(350 : 400, img_w_ed)) > 0
% %                 break;
% %             end
% %         end
% %         for i = 1 : nsample_per_img
% %             st_h = fix(rand() * (ht - ht_thr - sample_ht - 1) + ht_thr);
% %             st_w = fix(rand() * (img_w_ed - sample_wd - 1 - img_w_st) + img_w_st + 1);
% %             img_sample = img(st_h : st_h + sample_ht - 1, st_w : st_w + sample_wd - 1);
% % %             img_sample = img_sample - min(img_sample(:));
% %             cnt = cnt + 1;
% %             train_x(cnt, :, :) = img_sample;
% %             train_y(cnt) = 1;
% %             imwrite(img_sample, ['samples_mild/', num2str(cnt), '.bmp']);
% % %             figure, imshow(img_sample);
% %         end
% %         
% %         tic;
%     end
% end


% % % cut sample image from Frangi-filtered images (image patches)
% cnt = 0;
% class_idx = 0;
% class_name = 'normal';
% for fr = 1 : 100
%     if exist([img_normal_dir num2str(fr) '.bmp'])
%         img = im2double(imread([img_moderate_dir, 'Frangi_', num2str(fr), '.bmp']));
% %         figure, imshow(imcomplement(img));
%         [ht, wd] = size(img);
%         for i = 1 : nsample_per_img
%             st_h = fix(rand() * (ht - sample_ht - 1) + 1);
%             st_w = fix(rand() * (wd - sample_wd - 1) + 1);
%             img_sample = img(st_h : st_h + sample_ht - 1, st_w : st_w + sample_wd - 1);
%             cnt = cnt + 1;
%             train_x(:, :, cnt) = img_sample;
%             train_y(cnt) = class_idx;
%             imwrite(img_sample, ['samples_', class_name, '_Frangi/', num2str(cnt), '.bmp']);
%             cnt = cnt + 1;
%             train_x(:, :, cnt) = fliplr(img_sample);
%             train_y(cnt) = class_idx;
%             imwrite(fliplr(img_sample), ['samples_', class_name, '_Frangi/', num2str(cnt), '.bmp']);
% %             cnt = cnt + 1;
% %             train_x(:, :, cnt) = flipud(img_sample);
% %             train_y(cnt) = class_idx;
% %             imwrite(flipud(img_sample), ['samples_', class_name, '_Frangi/', num2str(cnt), '.bmp']);
%         end
%     end
% end
% save(['train_', class_name, '_Frangi.mat'], 'train_x', 'train_y');
% tic;

% % % sample image preprocess & sample augmentation
% class_name = 'severe';
% cnt = 0;
% for i = 1 : n_severe
%     img = im2double(imread(['samples_', class_name, '/', num2str(i), '.bmp']));
%     img = (img - mean(img(:)));
%     img = img - min(img(:));
% %     figure, imshow(img);
% %     figure, imshow(fliplr(img));
% %     figure, imshow(flipud(img));
%     imwrite(img, ['samples_', class_name, '/nor_', num2str(i), '_0.bmp']);
%     imwrite(fliplr(img), ['samples_', class_name, '/nor_', num2str(i), '_1.bmp']);
%     imwrite(flipud(img), ['samples_', class_name, '/nor_', num2str(i), '_2.bmp']);
%     cnt = cnt + 1;
%     train_x(:, :, cnt) = img;
%     train_y(cnt) = 3;
%     cnt = cnt + 1;
%     train_x(:, :, cnt) = fliplr(img);
%     train_y(cnt) = 3;
%     cnt = cnt + 1;
%     train_x(:, :, cnt) = flipud(img);
%     train_y(cnt) = 3;
% %     figure, imshow(img);
% end
% 
% save(['train_', class_name, '.mat'], 'train_x', 'train_y');\


% % cut sample image from Frangi-filtered images (image patches)
img_dir = 'G:/Liver Capsule/Image/raw_all/';
classes = 'severe';

sample_wd = 10;
sample_ht = 10;

cnt = 0;
for i = 1 : 50
    if exist([img_dir, 'sample_', classes, '_', num2str(i), '.jpg'])
        img = imread([img_dir, 'sample_', classes, '_', num2str(i), '.jpg']);
%         img = img - min(img(:));
        figure, imshow(img);
        [x, y] = ginput;
        [ht, wd] = size(img);
        for j = 1 : nsample_per_img
            st_h = fix(rand() * y + 1);
%             st_h = fix(rand() * (ht - y - sample_ht - 1) + y);
            st_w = fix(rand() * (wd - sample_wd - 1) + 1);
            img_sample = img(st_h : st_h + sample_ht - 1, st_w : st_w + sample_wd - 1);
            cnt = cnt + 1;
            imwrite(img_sample, [img_dir, 'sample_10_neg/sample_20_', classes, '_', num2str(cnt), '.jpg']);
%             imwrite(img, [img_dir, 'sample_10_', classes, '_', num2str(i), '.jpg']);
        end
    end
    tic;
end


for i = 1 : 400
    if exist([img_dir, 'sample_30_', classes, '_', num2str(i), '.jpg'])
        img = imread([img_dir, 'sample_30_', classes, '_', num2str(i), '.jpg']);
        cnt = cnt + 1;
        imwrite(img, [img_dir, 'sample30_', classes, '_', num2str(cnt), '.jpg']);
    end
    tic;
end