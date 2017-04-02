close all;
clear all;
% clc;

for rd = 1 : 50
    
load LX_SVM

clear tp_data;

k = 0;
for i = 1 : 68
%     if i == 8 || i == 14 || i == 19 || i == 30 || i == 32 || i == 33 || i == 42 || i == 49 || i == 52 || i == 53 || i == 54
%         continue;
%     end
    k = k + 1;
    tp_data(k, :) = data(i, [17 : 20]);
end
    
for i = 1 : size(tp_data, 2) - 1
    tp_data(:, i) = tp_data(:, i) / max(tp_data(:, i));
end

% tp_data = data(1 : end, [1 : 16, 20]); %[2, 5, 8, 11, 14, 15, 20]
% tp_data = data(1 : end, [17:20]);
clear data;
data = tp_data;

% kk = randperm(size(tp_data, 1));
% [train, test] = crossvalind('holdOut', size(tp_data, 1), 0.2);
% 
% data = tp_data(train, :);
% final_test = tp_data(test, :);

% % train 3 classifiers
% % train Normal / Cirrhosis

idx_c1 = find(data(:, end) > 0);
tp_data = data;
tp_data(idx_c1, end) = 1;
label = tp_data(:, end);
[train, test] = crossvalind('holdOut', size(tp_data, 1), 0.2);
cp = classperf(label);

svmStruct1 = svmtrain(tp_data(train, 1 : end - 1), label(train));
classes = svmclassify(svmStruct1, tp_data(test, 1 : end - 1));

classperf(cp, classes, test);
res(rd, 1) = cp.CorrectRate;

% % train Mild / other Cirrhosis

idx_c1 = find(data(:, end) ~= 1);
% tp_data = data(idx_c1, :);
% idx_c2 = find(tp_data(:, end) == 2 | tp_data(:, end) == 3);
tp_data(idx_c1, end) = 0;
label = tp_data(:, end);
[train, test] = crossvalind('holdOut', size(tp_data, 1), 0.2);
cp = classperf(label);

svmStruct2 = svmtrain(tp_data(train, 1 : end - 1), label(train));
classes = svmclassify(svmStruct2, tp_data(test, 1 : end - 1));

classperf(cp, classes, test);
res(rd, 2) = cp.CorrectRate;

% train Moderate / Severe

idx_c1 = find(data(:, end) < 2);
% tp_data = data(idx_c1, :);
tp_data(idx_c1, end) = 1;
label = tp_data(:, end);
[train, test] = crossvalind('holdOut', size(tp_data, 1), 0.2);
cp = classperf(label);

svmStruct3 = svmtrain(tp_data(train, 1 : end - 1), label(train));
classes = svmclassify(svmStruct3, tp_data(test, 1 : end - 1));

classperf(cp, classes, test);
res(rd, 3) = cp.CorrectRate;

idx_c1 = find(data(:, end) < 3);
% tp_data = data(idx_c1, :);
tp_data(idx_c1, end) = 2;
label = tp_data(:, end);
[train, test] = crossvalind('holdOut', size(tp_data, 1), 0.2);
cp = classperf(label);

svmStruct3 = svmtrain(tp_data(train, 1 : end - 1), label(train));
classes = svmclassify(svmStruct3, tp_data(test, 1 : end - 1));

classperf(cp, classes, test);
res(rd, 4) = cp.CorrectRate;

% % % END train Moderate / Severe

end

mean(res, 1)
% % test_total
classes = svmclassify(svmStruct1, final_test(:, 1 : end - 1));
idx0 = find(classes == 0);
idx1 = find(classes == 1);
classes = svmclassify(svmStruct2, final_test(:, 1 : end - 1));
idx1 = find(classes == 1);
idx1 = setdiff(idx1, idx0);
idx2 = find(classes == 2);
idx2 = setdiff(idx2, idx0);
% classes = svmclassify(svmStruct3, final_test(:, 1 : end - 1));
% idx2 = find(classes == 2);
% idx2 = setdiff(idx2, idx0);
% idx2 = setdiff(idx2, idx1);
% idx3 = find(classes == 3);
% idx3 = setdiff(idx3, idx0);
% idx3 = setdiff(idx3, idx1);
classes(idx0) = 0;
classes(idx1) = 1;
classes(idx2) = 2;
% classes(idx3) = 3;
cnt0 = 0;
for i = 1 : size(final_test, 1)
    if classes(i) == final_test(i, end)
        cnt0 = cnt0 + 1;
    end
end

cnt0 / size(final_test, 1)
% % classify Normal / Cirrhosis
% % classify Mild / other Cirrhosis
% % classify Moderate / Severe