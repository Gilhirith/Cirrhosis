close all;
clear all;
% clc;

for rd = 1 : 30

% % load data_glrlm_big_sample;
% load img_331_fractal


% tp_data(56 : end, :) = [];
% load feature_total_160113
% t_cnt = 0;
% for i = 1 : 55
% %     if samples(i).class == 2
% %         continue;
% %     end
% %     if i == 8 || i == 24 || i == 32 || i == 8 || i == 14 || i == 19 || i == 30 || i == 32 || i == 33 || i == 42 || i == 49 || i == 52 || i == 53 || i == 54
% %         continue;
% %     end
%     t_cnt = t_cnt + 1;
%     tp_data(t_cnt, 1) = samples(i).sum; %class 1 choose
%     tp_data(t_cnt, 2) = samples(i).num; % del
% %     tp_data(t_cnt, 1) = samples(i).novelty_std; % del
%     tp_data(t_cnt, 3) = samples(i).novelty_map_entropy;
% %     tp_data(t_cnt, 4) = samples(i).width_ratio;
% %     tp_data(t_cnt, 1) = samples(i).delta_dis; 
% %     tp_data(t_cnt, 7) = samples(i).dis_std;
% %     tp_data(t_cnt, 8) = samples(i).turn_ang_sampled;
% %     tp_data(t_cnt, 9) = samples(i).n_seg;
%     tp_data(t_cnt, 4) = samples(i).class;
% end

tic;

% load glcm_res_0120

% load matlab_0123

% load img_glcm
% load fractal_wavelet

load img_tol_Ribeiro
% load capsule_feature_160322
% load glcm

t_cnt = 0;
for i = 1 : 55
%     if capsule{i}.class == 2
%         continue;
%     end
%     if i == 8 || i == 24 || i == 32 || i == 8 || i == 14 || i == 19 || i == 30 || i == 32 || i == 33 || i == 42 || i == 49 || i == 52 || i == 53 || i == 54
%         continue;
%     end
% % % % % Cap+Texture 2014
    t_cnt = t_cnt + 1;
%     tp_data(t_cnt, 1) = capsule{i}.tol_gap; % gaps for class 3 choose
%     tp_data(t_cnt, 2) = capsule {i}.n_gap;
%     tp_data(t_cnt, 3) = capsule{i}.turn_ang; % del
%     tp_data(t_cnt, 4) = capsule{i}.delta_dis; % dis for class 1 & 3
%     tp_data(t_cnt, 5) = capsule{i}.dis_std; % get
% % %     tp_data(t_cnt, 1) = capsule{i}.sca_std; % del
%     tp_data(t_cnt, 6) = capsule{i}.class;
%     tp_data(t_cnt, 1) = img_glcm(i).turn_ang_rms;
    tp_data(t_cnt, 1) = img_glcm(i).energy06;
    tp_data(t_cnt, 2) = img_glcm(i).energy_A1;
    tp_data(t_cnt, 3) = img_glcm(i).energy_phi2;
    tp_data(t_cnt, 4) = img_glcm(i).a10A1;
    tp_data(t_cnt, 5) = img_glcm(i).a01A2;
%     tp_data(t_cnt, 11) = img_glcm(i).energy(1, 1);
%     tp_data(t_cnt, 12) = img_glcm(i).energy(1, 2);
%     tp_data(t_cnt, 13) = img_glcm(i).entropy(1, 1);
%     tp_data(t_cnt, 14) = img_glcm(i).entropy(1, 2);
%     tp_data(t_cnt, 15) = img_glcm(i).inertia(1, 1);
%     tp_data(t_cnt, 1 : 384) = img_glcm(i).GaborFeature(1 : 384);
%     tp_data(t_cnt, 17) = img_glcm(i).cor(1, 1);
%     tp_data(t_cnt, 18) = img_glcm(i).cor(1, 2);
%     tp_data(t_cnt, 19) = img_glcm(i).indiff(1, 1);
%     tp_data(t_cnt, 20) = img_glcm(i).indiff(1, 2);
%     tp_data(t_cnt, 20 : 531) = img_glcm(i).GaborFeature(1 : 512);
%     tp_data(t_cnt, 10) = img_glcm(i).fractal;
    tp_data(t_cnt, 6) = img_glcm(i).class;
end

for i = 56 : 68
    t_cnt = t_cnt + 1;
    tp_data(t_cnt, 1) = img_glcm(i).energy06;
    tp_data(t_cnt, 2) = img_glcm(i).energy_A1;
    tp_data(t_cnt, 3) = img_glcm(i).energy_phi2;
    tp_data(t_cnt, 4) = img_glcm(i).a10A1;
    tp_data(t_cnt, 5) = img_glcm(i).a01A2;
    tp_data(t_cnt, 6) = 4;
end

% load capsule_feature_160626
% 
% ttcnt = 0;
% for i = 56 : 68
%     t_cnt = t_cnt + 1;
%     ttcnt = ttcnt + length(capsule{i}.capsule_pts);
%     tp_data(t_cnt, 1) = capsule{i}.tol_gap; % gaps for class 3 choose
%     tp_data(t_cnt, 2) = capsule {i}.n_gap;
%     tp_data(t_cnt, 3) = capsule{i}.turn_ang; % del
%     tp_data(t_cnt, 4) = capsule{i}.delta_dis; % dis for class 1 & 3
%     tp_data(t_cnt, 5) = capsule{i}.dis_std; % get
%     tp_data(t_cnt, 6) = capsule{i}.class;
% end
% 
% ttcnt
% ttest_data(1).val(1, :) = tp_data(39 : 55, 7);
% ttest_data(1).val(2, :) = tp_data(21 : 37, 7);
% ttest_data(1).val(3, :) = tp_data(1 : 17, 7);
% 
% [h, p, ci] = ttest(ttest_data(1).val(1, :), ttest_data(1).val(2, :), 0.08);

% ttest_data(:, 1) = tp_data(1 : 20, 1);

% load data_glrlm_big_sample;

for i = 1 : size(tp_data, 2) - 1
    tp_data(:, i) = tp_data(:, i) / (max(tp_data(:, i)) + eps);
end

% % PCA
% [pc, score, latent, tsquare] = princomp(tp_data(:, 1 : end - 1));
% cumsum(latent) ./ sum(latent)
% tranMatrix = pc(:, 1 : 40);
% a1 = tp_data(:, 1 : end - 1) * tranMatrix;
% a1 = [a1, tp_data(:, end)];
% clear tp_data;
% tp_data = a1;

kk = randperm(size(tp_data, 1));
[train, test] = crossvalind('holdOut', size(tp_data, 1), 0.2);

% % % % idx_c1 = find(tp_data(:, end) ~= 3);
% % % % tp_data(idx_c1, end) = 2;

data = tp_data(train, :);
final_test = tp_data(test, :);

% % % % % % adaboost
% % % % addpath(genpath('./'));
% % % % 
% % % % weak_learner_n = 20;
% % % % tr_error = zeros(1,weak_learner_n);
% % % % te_error = zeros(1,weak_learner_n);
% % % % for i=1 : weak_learner_n
% % % % 	adaboost_model = ADABOOST_tr(@threshold_tr, @threshold_te, data(:, 1 : end - 1), data(:, end), i);
% % % % 	[L_tr, hits_tr] = ADABOOST_te(adaboost_model, @threshold_te, data(:, 1 : end - 1), data(:, end));
% % % % 	tr_error(i) = (length(data) - hits_tr) / length(data);
% % % % 	[L_te, hits_te] = ADABOOST_te(adaboost_model, @threshold_te, final_test(:, 1 : end - 1), final_test(:, end));
% % % % 	te_error(i) = (length(final_test) - hits_te) / length(final_test);
% % % % end
% % % % 
% % % % % % random forest
% % % % Factor = TreeBagger(50, data(:, 1 : end - 1), data(:, end));
% % % % [Predict_label, Scores] = predict(Factor, final_test(:, 1 : end - 1));
% % % % 
% % % % [max_score, idx] = max(Scores, [], 2);
% % % % 
% % % % x(rd, 1 : 3) = zeros(1, 3);
% % % % idx_1 = find(final_test(:, end) == 1);
% % % % x(rd, 1) = 1 - length(find(idx(idx_1) ~= final_test(idx_1, end))) / length(idx_1);
% % % % idx_2 = find(final_test(:, end) == 2);
% % % % x(rd, 2) = 1 - length(find(idx(idx_2) ~= final_test(idx_2, end))) / length(idx_2);
% % % % idx_3 = find(final_test(:, end) == 3);
% % % % x(rd, 3) = 1 - length(find(idx(idx_3) ~= final_test(idx_3, end))) / length(idx_3);

% % train 3 classifiers
% % train Normal / Cirrhosis

idx_c1 = find(data(:, end) > 1);
tp_data = data;
tp_data(idx_c1, end) = 2;
label = tp_data(:, end);
[train, test] = crossvalind('holdOut', size(tp_data, 1), 0.2);
cp = classperf(label);

svmStruct1 = svmtrain(tp_data(train, 1 : end - 1), label(train), 'Kernel_Function', 'rbf');
classes = svmclassify(svmStruct1, tp_data(test, 1 : end - 1));
classperf(cp, classes, test);
res(rd, 1) = cp.CorrectRate;

% % train Moderate / other Cirrhosis

idx_c1 = find(data(:, end) ~= 2);
tp_data = data;
% tp_data = data(idx_c1, :);
tp_data(idx_c1, end) = 1;
label = tp_data(:, end);
[train, test] = crossvalind('holdOut', size(tp_data, 1), 0.2);
cp = classperf(label);

svmStruct2 = svmtrain(tp_data(train, 1 : end - 1), label(train), 'Kernel_Function', 'rbf');
classes = svmclassify(svmStruct2, tp_data(test, 1 : end - 1));

classperf(cp, classes, test);
res(rd, 2) = cp.CorrectRate;

% % train Mild / other Cirrhosis

idx_c1 = find(data(:, end) ~= 3);
tp_data = data;
% tp_data = data(idx_c1, :);
tp_data(idx_c1, end) = 2;
label = tp_data(:, end);
[train, test] = crossvalind('holdOut', size(tp_data, 1), 0.2);
cp = classperf(label);

svmStruct2 = svmtrain(tp_data(train, 1 : end - 1), label(train), 'Kernel_Function', 'rbf');
classes = svmclassify(svmStruct2, tp_data(test, 1 : end - 1));

classperf(cp, classes, test);
res(rd, 3) = cp.CorrectRate;

% % train Severe / other

idx_c1 = find(data(:, end) ~= 4);
tp_data = data;
% tp_data = data(idx_c1, :);
tp_data(idx_c1, end) = 3;
label = tp_data(:, end);
[train, test] = crossvalind('holdOut', size(tp_data, 1), 0.2);
cp = classperf(label);

svmStruct2 = svmtrain(tp_data(train, 1 : end - 1), label(train), 'Kernel_Function', 'rbf');
classes = svmclassify(svmStruct2, tp_data(test, 1 : end - 1));

classperf(cp, classes, test);
res(rd, 4) = cp.CorrectRate;

% % % % % % % % % train Moderate / Severe
% % % % % % % 
% % % % % % % idx_c1 = find(data(:, end) == 2 | data(:, end) == 3);
% % % % % % % tp_data = data(idx_c1, :);
% % % % % % % label = tp_data(:, end);
% % % % % % % [train, test] = crossvalind('holdOut', size(tp_data, 1), 0.2);
% % % % % % % cp = classperf(label);
% % % % % % % 
% % % % % % % svmStruct3 = svmtrain(tp_data(train, 1 : end - 1), label(train));
% % % % % % % % classes = svmclassify(svmStruct3, tp_data(test, 1 : 19));
% % % % % % % % 
% % % % % % % % classperf(cp, classes, test);
% % % % % % % % cp.CorrectRate
% % % % % % % % % END train Moderate / Severe
% % % % % % 
% % % % % % % test_total
% % % % % classes = svmclassify(svmStruct1, final_test(:, 1 : end - 1));
% % % % % idx0 = find(classes == 1);
% % % % % idx1 = find(classes == 2);
% % % % % classes = svmclassify(svmStruct2, final_test(:, 1 : end - 1));
% % % % % idx1 = find(classes == 2);
% % % % % idx1 = setdiff(idx1, idx0);
% % % % % idx2 = find(classes == 3);
% % % % % idx2 = setdiff(idx2, idx0);
% % % % % % classes = svmclassify(svmStruct3, final_test(:, 1 : end - 1));
% % % % % % idx2 = find(classes == 2);
% % % % % % idx2 = setdiff(idx2, idx0);
% % % % % % idx2 = setdiff(idx2, idx1);
% % % % % % idx3 = find(classes == 3);
% % % % % % idx3 = setdiff(idx3, idx0);
% % % % % % idx3 = setdiff(idx3, idx1);
% % % % % classes(idx0) = 1;
% % % % % classes(idx1) = 2;
% % % % % classes(idx2) = 3;
% % % % % % classes(idx3) = 3;
% % % % % cnt(1) = 0;
% % % % % cnt(2) = 0;
% % % % % cnt(3) = 0;
% % % % % for i = 1 : size(final_test, 1)
% % % % %     if classes(i) == final_test(i, end)
% % % % %         cnt(classes(i)) = cnt(classes(i)) + 1;
% % % % %     end
% % % % % end
% % % % % 
% % % % % res(rd, 3) = cnt(1) / length(find(final_test(:, end) == 1));
% % % % % res(rd, 4) = cnt(2) / length(find(final_test(:, end) == 2));
% % % % % res(rd, 5) = cnt(3) / length(find(final_test(:, end) == 3));
end

mean(res, 1)
% % % mean(x, 1)
% % % classify Normal / Cirrhosis
% % % classify Mild / other Cirrhosis
% % % classify Moderate / Severe