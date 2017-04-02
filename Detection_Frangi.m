function [Ivessel scale] = Detection_Frangi(img)

    tp_img_diff = imcomplement(img);
    options = struct('FrangiScaleRange', [0 50], 'FrangiScaleRatio', 0.5, 'FrangiBetaOne', 0.5, 'FrangiBetaTwo', 0.5, 'verbose',true,'BlackWhite',true);
    [Ivessel, scale, dir] = FrangiFilter2D(tp_img_diff, options);
    Ivessel = Ivessel / max(Ivessel(:));
%     figure, imshow(Ivessel);
% %         figure, imshow(img_diff);
% %         hold on;
% 
%     Ivessel_bw = im2bw(Ivessel, 0.15);
%     Ivessel_label = bwlabel(Ivessel_bw);
% %         figure, imshow(Ivessel);
%     Ivessel.stats = imfeature(Ivessel_label, 'all');
% 
%     nobj = 0;
% 
%     for j = 1 : length(Ivessel.stats)
%         if Ivessel.stats(j).Area < 200
%             continue;
%         end
%         small_area = Ivessel_bw(Ivessel.stats(j).BoundingBox(2):Ivessel.stats(j).BoundingBox(2)+Ivessel.stats(j).BoundingBox(4), Ivessel.stats(j).BoundingBox(1):Ivessel.stats(j).BoundingBox(1)+Ivessel.stats(j).BoundingBox(3));
%         scale_small_area = scale(Ivessel.stats(j).BoundingBox(2):Ivessel.stats(j).BoundingBox(2)+Ivessel.stats(j).BoundingBox(4), Ivessel.stats(j).BoundingBox(1):Ivessel.stats(j).BoundingBox(1)+Ivessel.stats(j).BoundingBox(3));
%         ori_small_area = dir(Ivessel.stats(j).BoundingBox(2):Ivessel.stats(j).BoundingBox(2)+Ivessel.stats(j).BoundingBox(4), Ivessel.stats(j).BoundingBox(1):Ivessel.stats(j).BoundingBox(1)+Ivessel.stats(j).BoundingBox(3));
%         small_Ivessel_label = bwlabel(small_area);
%         small_Ivessel.stats = imfeature(small_Ivessel_label, 'all');
%         areas = [small_Ivessel.stats.Area];
%         [max_area, index_areas] = max(areas);
%         small_area = ismember(small_Ivessel_label, index_areas);
% 
%         small_Ivessel_skel = bwmorph(small_area, 'skel', Inf);
%         small_Ivessel_skel = bwmorph(small_Ivessel_skel, 'spur', 10);
%     %     BB = bwboundaries(small_Ivessel_skel, 8);
%         clear idx;
%         idx = find(small_Ivessel_skel == 1);
%         [ht, wd] = size(small_area);
% %             figure, imshow(small_Ivessel_skel);
% %             hold on;
%         midline_disorder = [mod(idx, ht), fix(idx / ht + 1)];
%         clear midline_dis;
%         for i = 1 : size(midline_disorder, 1)
%            midline_dis(i, :) = (sqrt(sum((repmat(midline_disorder(i, :), size(midline_disorder, 1), 1) - midline_disorder).^2, 2)))';
%         end
%         end_point_idx = [];
%         for i = 1 : size(midline_disorder, 1)
%             tx = midline_disorder(i, 1);
%             ty = midline_disorder(i, 2);
%             cnt = find(midline_dis(i, :) < 2);
%             if length(cnt) < 3
%                 end_point_idx(end + 1) = i;
%             end
%         end
%         cnt = 0;
%         clear tp_midline;
%         for r = 1 : length(end_point_idx)
%             tp_midline_dis = midline_dis;
%             i = end_point_idx(r);
%             tp_midline{r}.midline(1, :) = midline_disorder(i, :);
% %                 plot(midline_disorder(i, 2), midline_disorder(i, 1), 'r.');
%             tp_midline{r}.midline_idx(1) = idx(i);
%             pre = i;
%             fg = zeros(size(midline_disorder, 1), 1);
%             fg(i) = 1;
%             cnt = cnt + 1;
%             while cnt < size(midline_disorder, 1)
%                 vis_id = find(fg == 1);
%                 tp_midline_dis(i, vis_id) = Inf;
%                 [minval, minidx] = min(tp_midline_dis(i, :));
%                 minnum = find(tp_midline_dis(i, :) <= 1);
%                 if minval > 3 || length(minidx) > 2 || length(minnum) > 1
%                     break;
%                 end
%                 for k = 1 : length(minidx)
%                     if fg(minidx(k)) == 0
%                         pre = i;
%                         i = minidx(k);
%                         fg(minidx(k)) = 1;
%                         break;
%                     end
%                 end 
%                 cnt = cnt + 1;
%                 tp_midline{r}.midline(end + 1, :) = midline_disorder(i, :);
% %                     plot(midline_disorder(i, 2), midline_disorder(i, 1), 'r.');
%                 tp_midline{r}.midline_idx(end + 1) = idx(i);
%             end
%             if cnt > size(midline_disorder, 1) - 20
%                 break;
%             end
%         end
% %             hold off;
%         clear midline;
%         clear midline_idx;
% 
%         if r == 1
%             midline = tp_midline{r}.midline;
%             midline_idx = tp_midline{r}.midline_idx;
%         else
%             len = [];
%             for i = 1 : r
%                 len(end + 1) = length(tp_midline{i}.midline_idx);
%             end
%             [maxlen, maxlenidx] = max(len);
%             midline = tp_midline{maxlenidx}.midline;
%             midline_idx = tp_midline{maxlenidx}.midline_idx;
%             len(maxlenidx) = 0;
%             [maxlen, maxlenidx] = max(len);
%             if maxlen > 20
%                 for i = maxlen : -1 : 1
%                      midline(end + 1, :) = tp_midline{maxlenidx}.midline(i, :);
%                      midline_idx(end + 1) = tp_midline{maxlenidx}.midline_idx(i);
%                 end
%             end
%         end
% 
% 
% 
% 
%     %     figure, imshow(small_area);
%     %     hold on;
%     %     for i = 1 : length(midline)
%     %         plot(midline(i, 2), midline(i, 1), 'r.');
%     %     end
% 
%         if scale_small_area(midline_idx(1)) > scale_small_area(midline_idx(end))
%             maxidx = 1;
%             minidx = length(midline);
%         else
%             maxidx = length(midline);
%             minidx = 1;
%         end
%         nobj = nobj + 1;
% %             plot(midline(:, 2), midline(:, 1), 'r-', 'LineWidth', 2);
%         meas{fr}.obj{nobj}.head_pt = [mod(midline_idx(maxidx), ht) + Ivessel.stats(j).BoundingBox(2) - 1, fix(midline_idx(maxidx) / ht + 1) + Ivessel.stats(j).BoundingBox(1) - 1];
%         meas{fr}.obj{nobj}.tail_pt = [mod(midline_idx(minidx), ht) + Ivessel.stats(j).BoundingBox(2) - 1, fix(midline_idx(minidx) / ht + 1) + Ivessel.stats(j).BoundingBox(1) - 1];
%         midline = [midline(:, 1) + Ivessel.stats(j).BoundingBox(2) - 1, midline(:, 2) + Ivessel.stats(j).BoundingBox(1) - 1];
% 
%         midline = Smooth_2D(midline);
%         midline = Smooth_2D(midline);
%         midline = Smooth_2D(midline);
%         midline2 = resample_equal(midline, 63);
%         iidx = [1, 8, 15, 22, 29, 36, 43, 50, 57, 64];
%         if maxidx == length(idx)
%             iidx = fliplr(iidx);
%         end
%         meas{fr}.obj{nobj}.midline = midline2(iidx, :);
%     % % %     plot(midline(:, 2), midline(:, 1), 'b-');
% %             plot(midline2(iidx, 2), midline2(iidx, 1), 'r-');
%         for i = 2 : nseg - 1
%             meas{fr}.obj{nobj}.midline_ang(i) = acos(dot(midline2(iidx(i + 1), :) - midline2(iidx(i), :), midline2(iidx(i), :) - midline2(iidx(i - 1), :)) / (norm(midline2(iidx(i + 1), :) - midline2(iidx(i), :)) * norm(midline2(iidx(i), :) - midline2(iidx(i - 1), :))));
%             if Cross_Product(midline2(iidx(i - 1), 1), midline2(iidx(i - 1), 2), midline2(iidx(i + 1), 1), midline2(iidx(i + 1), 2), midline2(iidx(i), 1), midline2(iidx(i), 2)) < 0
%                 meas{fr}.obj{nobj}.midline_ang(i) = -meas{fr}.obj{nobj}.midline_ang(i);
%             end
%             meas{fr}.obj{nobj}.midline_ang(i) = meas{fr}.obj{nobj}.midline_ang(i) + meas{fr}.obj{nobj}.midline_ang(i - 1);
%         end
%         meas{fr}.obj{nobj}.midline_ang;
%         meas{fr}.obj{nobj}.scale = scale_small_area(midline_idx);
%         ang = atan2((meas{fr}.obj{nobj}.tail_pt(1) - meas{fr}.obj{nobj}.head_pt(1)), (meas{fr}.obj{nobj}.tail_pt(2) - meas{fr}.obj{nobj}.head_pt(2)));
% 
%         tp_pt = midline - repmat(meas{fr}.obj{nobj}.head_pt, size(midline, 1), 1);
%         rot_mtx = [cos(-ang), -sin(-ang);
%                     sin(-ang), cos(-ang)];
%         res_pt = tp_pt * rot_mtx;
%     %     figure;
%     %     hold on;
%     %     plot(res_pt(:, 2), res_pt(:, 1), 'r.');
%     %     axis equal
%         meas{fr}.obj{nobj}.ori = ori_small_area(midline_idx(maxidx));
%     %     plot(fix(idx / ht + 1), mod(idx, ht), 'r.');
% %             plot(meas{fr}.obj{nobj}.midline(:, 2), meas{fr}.obj{nobj}.midline(:, 1), 'b-', 'LineWidth', 2);
% %             plot(meas{fr}.obj{nobj}.midline(:, 2), meas{fr}.obj{nobj}.midline(:, 1), 'c.');
%         pt1 = [meas{fr}.obj{nobj}.head_pt(1, 1) + 50 * sin(meas{fr}.obj{nobj}.ori + pi/2), meas{fr}.obj{nobj}.head_pt(1, 2) + 50 * cos(meas{fr}.obj{nobj}.ori + pi/2)];
%         pt2 = [meas{fr}.obj{nobj}.head_pt(1, 1) + 50 * sin(meas{fr}.obj{nobj}.ori - pi/2), meas{fr}.obj{nobj}.head_pt(1, 2) + 50 * cos(meas{fr}.obj{nobj}.ori - pi/2)];
% 
%         meas{fr}.obj{nobj}.ori = meas{fr}.obj{nobj}.ori + pi / 2;
%         if meas{fr}.obj{nobj}.ori > pi
%             meas{fr}.obj{nobj}.ori = meas{fr}.obj{nobj}.ori - 2 * pi;
%         end
%         if img_diff(fix(pt2(1)), fix(pt2(2))) > img_diff(fix(pt1(1)), fix(pt1(2)))
%             pt1 = pt2;
%             meas{fr}.obj{nobj}.ori = meas{fr}.obj{nobj}.ori - pi;
%             if meas{fr}.obj{nobj}.ori < -pi
%                 meas{fr}.obj{nobj}.ori = meas{fr}.obj{nobj}.ori + 2 * pi;
%             end
%         end
%     % % %     plot([pt1(2), meas{fr}.obj{nobj}.head_pt(1, 2)], [pt1(1), meas{fr}.obj{nobj}.head_pt(1, 1)], 'b-', 'LineWidth', 2);
% %             plot(meas{fr}.obj{nobj}.head_pt(1, 2), meas{fr}.obj{nobj}.head_pt(1, 1), 'b.');
%     end
% 
%     % close all;
%     % xaxis = [1, 2, 3, 4, 5, 6, 7, 8, 9];
%     % for i = 1 : 1
%     % %     figure, plot(xaxis(:), meas{fr}.obj{i}.midline_ang(:), 'r-');
%     %     f(fr-14174, :) = meas{fr}.obj{i}.midline_ang(:);
%     % end
% 
% %         saveas(gcf, ['meas_cv278/20_', num2str(fr), '.jpg']);
% %         hold off;
% %         close all;
end