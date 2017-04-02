function [x_sample] = Get_Initial_Pts(pts)

    global n_sample_pts img_wd img_ht;
    
%     plot(pts(:, 1), pts(:, 2), 'g-');
%     pts = Smooth_2D(pts);
%     pts = Smooth_2D(pts);
%     pts = Smooth_2D(pts);
%     pts = Smooth_2D(pts);
    x_sample = resample_equal(pts, n_sample_pts);
    
%     plot(x_sample(:, 1), x_sample(:, 2), 'b-');
%     k = (pts(2, 2) - pts(1, 2)) / (pts(2, 1) - pts(1, 1));
% 
%     n = 0;
%     for x = 1 : img_wd / n_sample_pts : img_wd
%         n = n + 1;
%         x_sample(n, 2) = k * (x - pts(1, 1)) + pts(1, 2);
%         x_sample(n, 1) = x;
%     end
    
%     close all;
    
end