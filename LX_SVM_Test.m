close all;
clear all;
% clc;

for rd = 1 : 10
    
load LX_SVM_0826
clear tp_data;

k = 0;
for i = 1 : 67
%     if i == 22 || i == 26 || i == 34 || i == 39 || i == 44 || i == 53
%         continue;
%     end
% %     if i == 22 || i == 26 || i == 34 || i == 39 || i == 46
% %         continue;
% %     end

%     if i == 8 || i == 14 || i == 19 || i == 30 || i == 32 || i == 33 || i == 42 || i == 49 || i == 52 || i == 53 || i == 54
%         continue;
%     end
    k = k + 1;
%     tp_data(k, 1) = data(i, 11);
    tp_data(k, 1 : 3) = data(i, [17 : 19]);
    tp_data(k, 4) = data(i, [21]);
    tp_data(k, 5) = data(i, [31]); %16 9 12 31
%     tp_data(k, 6) = data(i, [31]);
    tp_data(k, 6) = data(i, [20]);
end

% % sample normalization
for i = 1 : size(tp_data, 2) - 1
    tp_data(:, i) = tp_data(:, i) / max(tp_data(:, i));
end

clear data;
data = tp_data;

% % train Normal / Cirrhosis

idx_c1 = find(data(:, end) > 0);
tp_data = data;
tp_data(idx_c1, end) = 1;
label = tp_data(:, end);
[train, test] = crossvalind('holdOut', size(tp_data, 1), 0.2);
cp = classperf(label);

svmStruct1 = svmtrain(tp_data(train, 1 : end - 1), label(train), 'Kernel_Function', 'linear');
classes = svmclassify(svmStruct1, tp_data(test, 1 : end - 1));

classperf(cp, classes, test);
res(rd, 1) = cp.CorrectRate;

% % END train Normal / Cirrhosis




% % train Mild / other

idx_c1 = find(data(:, end) ~= 1);
tp_data = data;
tp_data(idx_c1, end) = 0;
label = tp_data(:, end);
[train, test] = crossvalind('holdOut', size(tp_data, 1), 0.2);
cp = classperf(label);

svmStruct2 = svmtrain(tp_data(train, 1 : end - 1), label(train), 'Kernel_Function', 'linear');
classes = svmclassify(svmStruct2, tp_data(test, 1 : end - 1));

classperf(cp, classes, test);
res(rd, 2) = cp.CorrectRate;

% % END train Mild / other




% % train Moderate / other

idx_c1 = find(data(:, end) ~= 2);
tp_data = data;
tp_data(idx_c1, end) = 1;
label = tp_data(:, end);
[train, test] = crossvalind('holdOut', size(tp_data, 1), 0.2);
cp = classperf(label);

svmStruct3 = svmtrain(tp_data(train, 1 : end - 1), label(train), 'Kernel_Function', 'linear');
classes = svmclassify(svmStruct3, tp_data(test, 1 : end - 1));

classperf(cp, classes, test);
res(rd, 3) = cp.CorrectRate;

% % END train Moderate / other



% % train Severe / other

idx_c1 = find(data(:, end) ~= 3);
tp_data = data;
tp_data(idx_c1, end) = 2;
label = tp_data(:, end);
[train, test] = crossvalind('holdOut', size(tp_data, 1), 0.2);
cp = classperf(label);

svmStruct3 = svmtrain(tp_data(train, 1 : end - 1), label(train), 'Kernel_Function', 'linear');
classes = svmclassify(svmStruct3, tp_data(test, 1 : end - 1));

classperf(cp, classes, test);
res(rd, 4) = cp.CorrectRate;

% % END train Moderate / Severe

end

mean(res, 1)
