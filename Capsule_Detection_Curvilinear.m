function [small_Ivessel_skel cap_pos] = Capsule_Detection_Curvilinear()

global img;
global img_ht;
global img_wd;
global midline_pts;
global fr;
global min_midline_len;
global meas;
global joint_pts_tol;
global avg_head_width;
global CNN_sample_ht;
global CNN_sample_wd;
global fish;
global nseg;
global ang_data;
global bg_frame;
global ed_frame;
global delta_frame;
global nfish;
global ang_data_fg;

label = zeros(img_ht, img_wd);
% %
sigma_begin = 1;
sigma_end  = 100;
sigma_step = 1;
thres = 0.5;
sigma_array =sigma_begin:sigma_step:sigma_end;
sigma_nb = numel(sigma_array);

snlo = zeros(img_ht,img_wd,sigma_nb);

sigma = sigma_array(2); % edit fish:10 line: 4
w = 6; %3 * sigma
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

% % for bright line
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
% tic
idx = find(img > 0.01); %>0.001
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
    
    px = t * nx;
    py = t * ny;
    if px >= -thres && px <= thres && py <= thres && py >= -thres && (dxx(id) * nx^2 + 2 * dxy(id) * nx * ny + dyy(id) * ny^2) > 0.015 %  && order2 > 8 && order2 < 15
        [row, col] = ind2sub(s, id);
%         quiver(col, row, nx * 10, ny * 10); %for dark line: quiver(col, row, nx * 10, ny * 10);
        label(row, col) = 1;
        maxt = max((dxx(id) * nx^2 + 2 * dxy(id) * nx * ny + dyy(id) * ny^2), maxt);
        mint = min((dxx(id) * nx^2 + 2 * dxy(id) * nx * ny + dyy(id) * ny^2), mint);
%         sequence(num) = order2;
        num = num + 1;
    end
end
% maxt
% mint
% toc;

% figure, imshow(label, []);
small_Ivessel_skel = bwmorph(label, 'skel', Inf);
joint_pts = bwmorph(small_Ivessel_skel, 'branchpoints');
% small_Ivessel_skel = bwmorph(small_Ivessel_skel, 'spur', 5);
% figure, imshow(small_Ivessel_skel);
% hold on;
idx2 = find(small_Ivessel_skel == 1);
cap_pos = zeros(length(idx2), 2);
[cap_pos(:, 1), cap_pos(:, 2)] = ind2sub(s, idx2);
% plot(cap_pos(:, 2), cap_pos(:, 1), 'g.');

% midline_pts = small_Ivessel_skel - joint_pts;
% joint_pts_set = joint_pts;
% 
% while length(find(joint_pts == 1)) > 0
%     midline_label = bwlabel(midline_pts);
% %     figure, imshow(midline_pts);
% %     hold on;
%     midline.stats = imfeature(midline_label, 'all');
%     areas = [midline.stats.Area];
%     idx_skel = find(areas > 20);
%     midline_pts = ismember(midline_label, idx_skel);
%     joint_pts = bwmorph(midline_pts, 'branchpoints');
%     midline_pts = midline_pts - joint_pts;
%     joint_pts_set = joint_pts_set + joint_pts;
%     idx2 = find(joint_pts == 1);
%     [I, J] = ind2sub(s, idx2);
% %     plot(J, I, 'b.');
% end
% 
% idx = find(joint_pts_set == 1);
% 
% joint_pts_tol = [];
% [joint_pts_tol(:, 2), joint_pts_tol(:, 1)] = ind2sub(s, idx);
% % % % plot(joint_pts_tol(:, 1), joint_pts_tol(:, 2), 'y.');
% midline_label = bwlabel(midline_pts);
% midline.stats = imfeature(midline_label, 'all');
% 
% % if fr > bg_frame + delta_frame
% %     for i = 1 : nfish
% %         ang_data{i}.delta_midline_ang(fr, 2 : nseg) = ang_data{i}.delta_midline_ang(fr - delta_frame, 2 : nseg);
% %         tp = ang_data{i}.delta_ori(end);
% %         ang_data{i}.delta_ori(fr, 1) = tp;
% %         ang_data{i}.delta_vel_ang(fr, 1) = 0;
% %         ang_data{i}.vel(fr, 1 : 2) = ang_data{i}.vel(fr - delta_frame, 1 : 2);
% %     end
% % end
% 
% meas{fr}.nobj = 0;
% for i = 1 : length(midline.stats)
%     if midline.stats(i).Area > min_midline_len
%         midline_pts = midline.stats(i).PixelList;
%         midline_pts = Midline_Reorder(midline_pts);
%         
%         midline_pts = Smooth_2D(midline_pts);
%         midline_pts = Smooth_2D(midline_pts);
%         midline_pts = Smooth_2D(midline_pts);
%         midline_pts2 = resample_equal(midline_pts, 20);
%         
% %         plot(midline_pts2(:, 1), midline_pts2(:, 2), 'r.');
%         ang1 = atan2(midline_pts2(2, 2) - midline_pts2(1, 2), midline_pts2(2, 1) - midline_pts2(1, 1));
%         rect_1 = Get_Head_Rect(midline_pts2(1, 1), midline_pts2(1, 2), ang1, avg_head_width * 2, avg_head_width * 3);
%         ang2 = atan2(midline_pts2(end, 2) - midline_pts2(end - 1, 2), midline_pts2(end, 1) - midline_pts2(end - 1, 1));
%         rect_2 = Get_Head_Rect(midline_pts2(end, 1), midline_pts2(end, 2), ang2, avg_head_width * 2, avg_head_width * 3);
% 
%         minx = int32(min(rect_1(2, :)));
%         maxx = int32(max(rect_1(2, :)));
%         miny = int32(min(rect_1(1, :)));
%         maxy = int32(max(rect_1(1, :)));
%         if minx < 1
%             minx = 1;
%         end
%         if maxx > img_height
%             maxx = img_height;
%         end
%         if miny < 1
%             miny = 1;
%         end
%         if maxy > img_width
%             maxy = img_width;
%         end
%         img_small1 = imcomplement(img(minx : maxx, miny : maxy));
%         
%         minx = int32(min(rect_2(2, :)));
%         maxx = int32(max(rect_2(2, :)));
%         miny = int32(min(rect_2(1, :)));
%         maxy = int32(max(rect_2(1, :)));
%         if minx < 1
%             minx = 1;
%         end
%         if maxx > img_height
%             maxx = img_height;
%         end
%         if miny < 1
%             miny = 1;
%         end
%         if maxy > img_width
%             maxy = img_width;
%         end
%         img_small2 = imcomplement(img(minx : maxx, miny : maxy));
%         
%         if mean(img_small1(:)) > mean(img_small2(:))
%             midline_pts2 = flipud(midline_pts2);
%         end
%         
%         midline_pts2 = midline_pts2(2 : end, :);
% 
%         plot(midline_pts2(:, 1), midline_pts2(:, 2), 'g-', 'LineWidth', 1);
% %             text(midline_pts2(1, 1), midline_pts2(1, 2), num2str(minidx), 'Color', 'm', 'FontSize', 20);
% 
%     end
% end

end