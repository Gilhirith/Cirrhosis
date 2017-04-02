function Cal_Capsule_Feature_Combine(sca, sample_cnt)

    global capsule;

    thr_gap = 10;
    thr_y = 6;
    capsule{sample_cnt}.tol_gap = 0;
    capsule{sample_cnt}.turn_ang = 0;
    capsule{sample_cnt}.n_gap = 0;
    x1 = capsule{sample_cnt}.capsule_pts(1, 2);
    x2 = capsule{sample_cnt}.capsule_pts(end, 2);
    y1 = capsule{sample_cnt}.capsule_pts(1, 1);
    y2 = capsule{sample_cnt}.capsule_pts(end, 1);
    A = y1 - y2;
    B = x2 - x1;
    C = (x1 - x2) * y2 - (y1 - y2) * x2;
    capsule{sample_cnt}.delta_dis = 0;
        
    for i = 2 : size(capsule{sample_cnt}.capsule_pts, 1)
        len = abs(capsule{sample_cnt}.capsule_pts(i, 2) - capsule{sample_cnt}.capsule_pts(i - 1, 2));
        if len > thr_gap
            capsule{sample_cnt}.tol_gap = capsule{sample_cnt}.tol_gap + len;
            capsule{sample_cnt}.n_gap = capsule{sample_cnt}.n_gap + 1;
        end
        len = abs(capsule{sample_cnt}.capsule_pts(i, 1) - capsule{sample_cnt}.capsule_pts(i - 1, 1));
        if len > thr_y
            capsule{sample_cnt}.tol_gap = capsule{sample_cnt}.tol_gap + len;
            capsule{sample_cnt}.n_gap = capsule{sample_cnt}.n_gap + 1;
        end
        if i < size(capsule{sample_cnt}.capsule_pts, 1)
            vec1 = capsule{sample_cnt}.capsule_pts(i - 1, :) - capsule{sample_cnt}.capsule_pts(i, :);
            vec2 = capsule{sample_cnt}.capsule_pts(i, :) - capsule{sample_cnt}.capsule_pts(i + 1, :);
            tp_ang = real(acos(dot(vec1, vec2) / (norm(vec1) * norm(vec2))));
            capsule{sample_cnt}.turn_ang = capsule{sample_cnt}.turn_ang + min(tp_ang, pi - tp_ang);
        end
        
        capsule{sample_cnt}.sca(i) = sca(fix(capsule{sample_cnt}.capsule_pts(i, 1)), fix(capsule{sample_cnt}.capsule_pts(i, 2)));
        
        tp_dis = abs(A * capsule{sample_cnt}.capsule_pts(i, 2) + B * capsule{sample_cnt}.capsule_pts(i, 1) + C) / (A.^2 + B.^2).^0.5;
        capsule{sample_cnt}.dis(i) = tp_dis;
        if i > 2
            capsule{sample_cnt}.delta_dis = capsule{sample_cnt}.delta_dis + abs(pre_dis - tp_dis);
        end
        pre_dis = tp_dis;
        
    
    end
    wd = max(capsule{sample_cnt}.capsule_pts(:, 2)) - min(capsule{sample_cnt}.capsule_pts(:, 2));
    capsule{sample_cnt}.turn_ang = capsule{sample_cnt}.turn_ang / (size(capsule{sample_cnt}.capsule_pts, 1) - 2);
    capsule{sample_cnt}.tol_gap = capsule{sample_cnt}.tol_gap / wd;
    capsule{sample_cnt}.dis_std = std(capsule{sample_cnt}.dis);
    capsule{sample_cnt}.delta_dis = capsule{sample_cnt}.delta_dis / (size(capsule{sample_cnt}.capsule_pts, 1) - 1);
    capsule{sample_cnt}.sca_std = std(capsule{sample_cnt}.sca(:)) / size(capsule{sample_cnt}.capsule_pts, 1);
end