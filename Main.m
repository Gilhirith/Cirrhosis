close all;
clear all;
clc;

global n_sample_pts;
global n_manual_pts;
global img_ht;
global img_wd;
global img_Frangi;
global ini_step;
global class;
global samples;
global capsule;
global img;
global sample_capsule;

n_sample_pts = 100;
n_manual_pts = 12;
ini_step = 2;

class(1).name = 'normal';
class(2).name = 'mild';
class(3).name = 'moderate';
class(4).name = 'severe';

addpath(genpath('G:/Liver Capsule/'));

img_dir = 'G:/Liver Capsule/Image/raw_all/';
save_dir = 'G:/Liver Capsule/Image/Code/res_160113/';

sample_cnt = 55;

load sa_res_160626
load res_160113

for cls = 4 : 4
    for fr = 2 : 20
        if exist([img_dir, 'cut_', class(cls).name, '_', num2str(fr), '.jpg'])
            img = im2double(imread([img_dir, 'cut_', class(cls).name, '_', num2str(fr), '.jpg']));
            sample_cnt = sample_cnt + 1;
            [img_ht img_wd] = size(img);
            
%             clear img_color;
%             img_color(:, :, 1) = img;
%             img_color(:, :, 2) = img;
%             img_color(:, :, 3) = img;
%             nol = (test_samples(sample_cnt).novelty_map - min(test_samples(sample_cnt).novelty_map(:))) / max(test_samples(sample_cnt).novelty_map(:));
%             img_color(:, :, 1) = img_color(:, :, 1) + nol;
%             img_color = img_color ./ max(img_color(:));
%             figure, imshow(img_color);
            
            LOW_HIGH = stretchlim(img, [0.7, 1]);
            img_adjust = imadjust(img, LOW_HIGH);


%             [ht, wd] = size(img);
%             img_w_st = 1;
%             img_w_ed = wd;
%             for img_w_st = 1 : wd
%                 if mean(img(350 : 400, img_w_st)) > 0.0005
%                     break;
%                 end
%             end
%             for img_w_ed = wd : -1 : 1
%                 if mean(img(350 : 400, img_w_ed)) > 0.0005
%                     break;
%                 end
%             end

    %         figure, imshow(img(200 : end, img_w_st : img_w_ed));
            [img_Frangi sca] = Detection_Frangi(img(1 : end, 1 : end));
            figure, imshow(img);
            img = img_Frangi;
%             figure, imshow(imcomplement(img));
%             img = imadjust(imcomplement(img), [], [0 0.95]);
%             figure, imshow(img);
            hold on;
%             sample_capsule(sample_cnt).low_bound(:, 2) = size(img, 1);
%             sample_capsule(sample_cnt).up_bound(:, 2) = 1;
            [Ini_pt_low] = Get_Initial_Pts(sample_capsule(sample_cnt).low_bound);
            [Ini_pt_high] = Get_Initial_Pts(sample_capsule(sample_cnt).up_bound);
%             [Ini_pt_low] = Get_Initial_Pts(sample_capsule(sample_cnt).low_bound);
%             [Ini_pt_high] = Get_Initial_Pts(sample_capsule(sample_cnt).up_bound);

            [Ivessel_skel ~] = Capsule_Detection_Curvilinear();
            [idx idy] = find(Ivessel_skel == 1);
%             img = imadjust(imcomplement(img), [], [0 0.95]);
%             figure, imshow(img);
%             hold on;
            
%             plot(idy, idx, 'b.');
%             figure, imshow(Ivessel_skel);
            Get_Final_Capsule(Ivessel_skel, Ini_pt_low, Ini_pt_high, sample_cnt);
            Cal_Capsule_Feature_Combine(sca, sample_cnt);
            close all;
% % % % % % %             capsule{sample_cnt}.class = cls;
% % %             imwrite(img_Frangi, [img_severe_dir, 'Frangi_', num2str(fr), '.bmp']);
% % 
% % %             [dx dy] = gradient(img(260 : end - 5, img_w_st : img_w_ed));
% % %             dy = dy.^2;
% % %             dy = dy / max(dy(:));
% % %     %         figure, imshow(dy);
% % %             imwrite(dy, [img_severe_dir, 'Gradient_', num2str(fr), '.bmp']);
% % 
% %             [Manual_pt_low, Manual_pt_high] = Get_Manual_Pts();
% %             samples(sample_cnt).low_bound = Manual_pt_low;
% %             samples(sample_cnt).up_bound = Manual_pt_high;
% %             samples(sample_cnt).class = cls;
% %     %         save(['tmp_1224_', num2str(fr), '.mat']);
% %     %         
% %     %         load(['tmp_1224_', num2str(fr), '.mat']);
% %     %         
% %     %         figure, imshow(img_Frangi);
% %     %         hold on;
% %     %         
% %             [Ini_pt_low] = Get_Initial_Pts(Manual_pt_low);
% %             [Ini_pt_high] = Get_Initial_Pts(Manual_pt_high);
% %     %         
% %             Res_pt = SA_Capsule_Contour(Ini_pt_low, Ini_pt_high);
% %             samples(sample_cnt).SA_res_pt = Res_pt;

%             detection_res_combine{i}.
%             saveas(gcf, [save_dir, 'cur_res_', class(cls).name, '_', num2str(fr), '.jpg']);
%             close all;
% % %             tic;
% %     % %         Demo_LAC(img_Frangi, 4);

        end
    end
end


% save('capsule_feature_160322.mat', 'capsule');
% % save('capsule_feature_160626.mat', 'capsule');
