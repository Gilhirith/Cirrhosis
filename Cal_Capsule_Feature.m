% function Cal_Capsule_Feature()
close all;
global sample_capsule;

n_sample_pts = 100;
y_thr = 4;
x_thr = 6;
d_thr = 14;
load sa_res_160113;

fp = fopen('res_capsule.txt', 'w');

for i = 20 : 55 % 20, 38, 55
    img = im2double(imread(['../raw_all/cut_normal_', num2str(i - 0), '.jpg']));
%     figure, imshow(img);
%     hold on;
    LOW_HIGH = stretchlim(img, [0.7, 1]);
    img_adjust = imadjust(img, LOW_HIGH);
    
    img_Frangi = Detection_Frangi(img);
    
    figure, imshow(imcomplement(img_Frangi));
    LOW_HIGH = stretchlim(img_Frangi, [0.8 0.9995]);
    img_Frangi = imadjust(img_Frangi, LOW_HIGH);
    
    img_Frangi = img_Frangi * 0.95;
    img_Frangi = img_Frangi + 0.05;
    
    
    figure, imshow(imcomplement(img_Frangi));
    hold on;
    set(gcf, 'outerposition', get(0, 'screensize'));
    i
    pt_cnt = 0;
    x_sample = resample_equal(sample_capsule(i).up_bound, n_sample_pts);
    for j = 1 : n_sample_pts
        if sample_capsule(i).SA_res_pt(j, 1) > fix(x_sample(j, 2))
            if pt_cnt == 0
                pt_cnt = pt_cnt + 1;
                sample_capsule(i).filtered_pt(pt_cnt, :) = sample_capsule(i).SA_res_pt(j, :);
            else
                if sqrt(sum((sample_capsule(i).SA_res_pt(j, :) - sample_capsule(i).SA_res_pt(j - 1, :)).^2)) < 5
%                 if abs(sample_capsule(i).SA_res_pt(j, 1) - sample_capsule(i).filtered_pt(pt_cnt, 1)) < y_thr
%                 if abs(sample_capsule(i).SA_res_pt(j, 1) - sample_capsule(i).SA_res_pt(j - 1, 1)) < y_thr
                    pt_cnt = pt_cnt + 1;
                    sample_capsule(i).filtered_pt(pt_cnt, :) = sample_capsule(i).SA_res_pt(j, :);
%                     plot(sample_capsule(i).filtered_pt(pt_cnt, 2), sample_capsule(i).filtered_pt(pt_cnt, 1), 'r.', 'LineWidth', 1);
                else
                    if abs(sample_capsule(i).SA_res_pt(j, 1) - sample_capsule(i).filtered_pt(pt_cnt, 1)) < y_thr
                        pt_cnt = pt_cnt + 1;
                        sample_capsule(i).filtered_pt(pt_cnt, :) = sample_capsule(i).SA_res_pt(j, :);
%                         plot(sample_capsule(i).filtered_pt(pt_cnt, 2), sample_capsule(i).filtered_pt(pt_cnt, 1), 'b.', 'LineWidth', 1);
                    end
                end
            end
        end
    end
    
    sample_capsule(i).smoothed_pt = Smooth_2D(sample_capsule(i).filtered_pt);
    tp_sample = resample_equal(sample_capsule(i).smoothed_pt, 10); % fix(max(sample_capsule(i).smoothed_pt(:, 2) - max(sample_capsule(i).smoothed_pt(:, 1)))) / 
%     plot(tp_sample(:, 2), tp_sample(:, 1), 'b-', 'LineWidth', 1);
    plot(sample_capsule(i).low_bound([1,7,12], 1), sample_capsule(i).low_bound([1,7,12], 2) + 15, 'b--', 'LineWidth', 5);
    plot(sample_capsule(i).low_bound([1,7,12], 1), sample_capsule(i).low_bound([1,7,12], 2) + 15, 'yo', 'MarkerSize', 10,  'MarkerFaceColor', 'y');
    plot(sample_capsule(i).up_bound([1,7,12], 1), sample_capsule(i).up_bound([1,7,12], 2) - 20, 'b--', 'LineWidth', 5);
    plot(sample_capsule(i).up_bound([1,7,12], 1), sample_capsule(i).up_bound([1,7,12], 2) - 20, 'yo', 'MarkerSize', 10,  'MarkerFaceColor', 'y');
%     plot(sample_capsule(i).filtered_pt(:, 2), sample_capsule(i).filtered_pt(:, 1), 'y.', 'LineWidth', 6);
    plot(sample_capsule(i).filtered_pt(:, 2), sample_capsule(i).filtered_pt(:, 1), 'r-', 'LineWidth', 5);

    sample_capsule(i).turn_ang_sampled = 0;
    for j = 2 : size(tp_sample, 1) - 1
        vec1 = tp_sample(j - 1, :) - tp_sample(j, :);
        vec2 = tp_sample(j, :) - tp_sample(j + 1, :);
        tp_ang = real(acosd(dot(vec1, vec2) / (norm(vec1) * norm(vec2))));
        sample_capsule(i).turn_ang_sampled = sample_capsule(i).turn_ang_sampled + min(tp_ang, 180 - tp_ang);
    end
    
    sample_capsule(i).cnt_width = 0;
    sample_capsule(i).n_seg = 0;
    
    for j = 2 : pt_cnt
        if sqrt(sum((sample_capsule(i).filtered_pt(j, :) - sample_capsule(i).filtered_pt(j - 1, :)).^2)) < d_thr || abs(sample_capsule(i).filtered_pt(j, 1) - sample_capsule(i).filtered_pt(j - 1, 1)) < y_thr
%         if abs(sample_capsule(i).filtered_pt(j, 1) - sample_capsule(i).filtered_pt(j - 1, 1)) < y_thr && abs(sample_capsule(i).filtered_pt(j, 2) - sample_capsule(i).filtered_pt(j - 1, 2)) < x_thr
%             plot([sample_capsule(i).filtered_pt(j, 2), sample_capsule(i).filtered_pt(j-1, 2)], [sample_capsule(i).filtered_pt(j, 1), sample_capsule(i).filtered_pt(j-1, 1)], 'r-', 'LineWidth', 1);
            sample_capsule(i).cnt_width = sample_capsule(i).cnt_width + abs(sample_capsule(i).filtered_pt(j, 2) - sample_capsule(i).filtered_pt(j - 1, 2));
        else
            sample_capsule(i).n_seg = sample_capsule(i).n_seg + 1;
        end
    end
    sample_capsule(i).n_seg
    sample_capsule(i).n_seg = sample_capsule(i).n_seg;
    sample_capsule(i).width_ratio = sample_capsule(i).cnt_width / abs(sample_capsule(i).filtered_pt(end, 2) - sample_capsule(i).filtered_pt(1, 2));
%     sample_capsule(i).width_ratio
    sample_capsule(i).delta_ht = (max(sample_capsule(i).filtered_pt(:, 1)) - min(sample_capsule(i).filtered_pt(:, 1))) / abs(sample_capsule(i).filtered_pt(end, 2) - sample_capsule(i).filtered_pt(1, 2));
    
    sample_capsule(i).turn_ang = 0;
    for j = 2 : pt_cnt - 1
        vec1 = sample_capsule(i).filtered_pt(j - 1, :) - sample_capsule(i).filtered_pt(j, :);
        vec2 = sample_capsule(i).filtered_pt(j, :) - sample_capsule(i).filtered_pt(j + 1, :);
        tp_ang = real(acos(dot(vec1, vec2) / (norm(vec1) * norm(vec2))));
        sample_capsule(i).turn_ang = sample_capsule(i).turn_ang + min(tp_ang, pi - tp_ang);
%         tp_sample{i}.turn_ang(j - 1) = min(tp_ang, pi - tp_ang);
    end
    sample_capsule(i).turn_ang = sample_capsule(i).turn_ang / (pt_cnt - 2);
    
    
    x1 = sample_capsule(i).filtered_pt(1, 2);
    x2 = sample_capsule(i).filtered_pt(end, 2);
    y1 = sample_capsule(i).filtered_pt(1, 1);
    y2 = sample_capsule(i).filtered_pt(end, 1);
    A = y1 - y2;
    B = x2 - x1;
    C = (x1 - x2) * y2 - (y1 - y2) * x2;
    
    sample_capsule(i).dis = 0;
    sample_capsule(i).delta_dis = 0;
    for j = 1 : pt_cnt
        tp_dis = abs(A * sample_capsule(i).filtered_pt(j, 2) + B * sample_capsule(i).filtered_pt(j, 1) + C) / (A.^2 + B.^2).^0.5;
        sample_capsule(i).dis(j) = tp_dis;
        if j > 2
            sample_capsule(i).delta_dis = sample_capsule(i).delta_dis + abs(pre_dis - tp_dis);
        end
        pre_dis = tp_dis;
    end
    sample_capsule(i).dis_std = std(sample_capsule(i).dis);
    sample_capsule(i).delta_dis = sample_capsule(i).delta_dis / (pt_cnt - 1);
    sample_capsule(i).pt_cnt = pt_cnt;
    
%     fprintf(fp, '%f %f %f %f %d %d %d\n', sample_capsule(i).width_ratio, sample_capsule(i).turn_ang, sample_capsule(i).delta_dis, sample_capsule(i).dis_std, sample_capsule(i).n_seg, sample_capsule(i).pt_cnt, sample_capsule(i).class);
    
end

% fclose(fp);


load res_160113;

fp = fopen('res_texture.txt', 'w');

imin = 1e10;
imax = -1e10;
for i = 1 : 55
    sample_capsule(i).sum = test_samples(i).sum;
    sample_capsule(i).num = test_samples(i).num;
    sample_capsule(i).novelty_std = std(test_samples(i).novelty_map(:));
    fprintf(fp, '%f %f\n', test_samples(i).sum, test_samples(i).num);
    imin = min(imin, min(test_samples(i).novelty_map(:)));
    imax = max(imax, max(test_samples(i).novelty_map(:)));
end


for i = 1 : 55
    sample_capsule(i).novelty_map_gray_scale = fix(256 * ((test_samples(i).novelty_map(:) - imin) / imax));
    sample_capsule(i).novelty_map_entropy = entropy(sample_capsule(i).novelty_map_gray_scale);
end

samples = sample_capsule;

fclose(fp);

save('feature_total_160113.mat', 'samples');
% end