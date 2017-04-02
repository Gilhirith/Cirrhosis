function [x_low, x_high] = Get_Manual_Pts()

    global n_manual_pts;
    global img_Frangi;
    global img_wd img_ht;
    global img;
    
    class(1).name = 'normal';
    class(2).name = 'mild';
    class(3).name = 'moderate';
    class(4).name = 'severe';

    img_dir = 'G:/Liver Capsule/Image/raw_all/';
    
    n_sample_pts = 100;
    n_manual_pts = 12;
    ini_step = 2;

    sample_cnt = 55;
    for cls = 4 : 4
        for fr = 1 : 20
            if exist([img_dir, 'cut_', class(cls).name, '_', num2str(fr), '.jpg'])
                img = im2double(imread([img_dir, 'cut_', class(cls).name, '_', num2str(fr), '.jpg']));
                [img_ht img_wd] = size(img);
                figure, imshow(img);
                hold on;
    
%                 for x = 1 : img_wd / (n_manual_pts - 1) : img_wd
%                     plot([x, x], [1, img_ht], 'b--');
%                 end

                set(gcf, 'outerposition', get(0, 'screensize'));
    
                for i = 1 : n_manual_pts
                    [x_low(i, 1), x_low(i, 2)] = ginput;
                end
    
                for i = 1 : n_manual_pts
                    [x_high(i, 1), x_high(i, 2)] = ginput;
                end
                
                sample_cnt = sample_cnt + 1;
                sample_capsule(sample_cnt).low_bound = x_low;
                sample_capsule(sample_cnt).up_bound = x_high;
                
            end
        end
    end

    save('ini_pts_total.mat', 'sample_capsule');
%     close all;
    
end