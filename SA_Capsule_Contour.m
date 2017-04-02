function res_pt = SA_Capsule_Contour(Ini_pt_low, Ini_pt_high)

    global n_sample_pts;
    global ini_step;
    global img_Frangi;
    
    for i = 1 : n_sample_pts
        step = ini_step;
        tp = Ini_pt_low(i, 2);
        flag = 1;
        while flag == 1 & step > 1e-5
            step
            pre = tp;
            tp = pre - step;
            if fix(tp) <= 1 || img_Frangi(fix(tp), fix(Ini_pt_low(i, 1))) < img_Frangi(fix(pre), fix(Ini_pt_low(i, 1))) - 0.03% || fix(tp) < fix(Ini_pt_high(i, 2))
                flag = 0;
%                 plot(fix(Ini_pt_low(i, 1)), fix(pre), 'y.');
%                 plot(fix(Ini_pt_low(i, 1)), fix(tp), 'c.');
            end
            step = step * 0.99;
        end
        
        res_pt(i, :) = [pre, Ini_pt_low(i, 1)];
%         ObjectiveFunction = @Cal_Capsule_Val;
%         startingPoint = [Ini_pt_low(i, 1), Ini_pt_low(i, 2)];
%         lb = [Ini_pt_low(i, 1), Ini_pt_low(i, 2)];
%         ub = [Ini_pt_high(i, 1), Ini_pt_high(i, 2)];
%         options = saoptimset('TolFun', 1e-5);
%         [x, fval] = simulannealbnd(ObjectiveFunction, startingPoint, lb, ub, options);
    end
    
    for i = 1 : n_sample_pts
        if res_pt(i, 1) > fix(Ini_pt_high(i, 2))
            plot(res_pt(i, 2), res_pt(i, 1), 'r.', 'LineWidth', 2);
        end
    end
end