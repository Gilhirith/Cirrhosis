function Get_Final_Capsule(Ivessel_skel, Ini_pt_low, Ini_pt_high, sample_cnt)

    global capsule;
    
    thr_y = 8;
    
    k = 0;
    for i = 1 : size(Ini_pt_low, 1)
        idx = find(Ivessel_skel(:, fix(Ini_pt_low(i, 1))) == 1);
        if length(idx) > 0
            idx2 = find(idx > fix(Ini_pt_high(i, 2)) & idx < fix(Ini_pt_low(i, 2)));
            if length(idx2) > 0
                [loc, idx3] = max(idx(idx2));
%                 if k == 0 || (k > 0 && abs(loc - pre_y) < thr_y)
                    k = k + 1;
                    tp_capsule_pts(k, 1 : 2) = [loc, fix(Ini_pt_high(i, 1))];
%                     plot(fix(Ini_pt_high(i, 1)), loc, 'r.');
%                 end
%                 pre_y = loc;
            end
        end
    end

%     mean_y = mean(tp_capsule_pts(:, 1));
    k = 0;
    for i = 1 : size(tp_capsule_pts, 1)
        if i < 6  || i > size(tp_capsule_pts, 1) - 5
            k = k + 1;
            capsule{sample_cnt}.capsule_pts(k, 1 : 2) = tp_capsule_pts(i, 1 : 2);
            plot(capsule{sample_cnt}.capsule_pts(k, 2), capsule{sample_cnt}.capsule_pts(k, 1), 'b.');
        else
            if abs(tp_capsule_pts(i, 1) - mean(tp_capsule_pts([i - 5 : i - 1, i + 1, i + 5], 1))) < thr_y
                k = k + 1;
                capsule{sample_cnt}.capsule_pts(k, 1 : 2) = tp_capsule_pts(i, 1 : 2);
                plot(capsule{sample_cnt}.capsule_pts(k, 2), capsule{sample_cnt}.capsule_pts(k, 1), 'b.');
            end
        end
    end
    plot(capsule{sample_cnt}.capsule_pts(:, 2), capsule{sample_cnt}.capsule_pts(:, 1), 'r-');
end