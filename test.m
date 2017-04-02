close all;
clear all;
clc;

load ini_pts_total
sample_capsule1 = sample_capsule;
clear sample_capsule;

load sa_res_160113

for i = 56 : 68
    sample_capsule(i).up_bound = sample_capsule1(i).up_bound;
    sample_capsule(i).low_bound = sample_capsule1(i).low_bound;
    sample_capsule(i).class = 4;
end

tic;

save('sa_res_160626.mat', 'sample_capsule');

load sa_res_160113


load sa_res_160113

img = imread('../raw_all/cut_normal_20.jpg');
figure, imshow(img);
hold on;

plot(sample_capsule(i).filtered_pt(:, 1), sample_capsule(i).filtered_pt(:, 2), 'r.');

% global sample;

load sa_res_160113_1-8;

for i = 1 : 8
    sample_capsule(i).low_bound = samples(i).low_bound;
    sample_capsule(i).up_bound = samples(i).up_bound;
    sample_capsule(i).class = samples(i).class;
    sample_capsule(i).SA_res_pt = samples(i).SA_res_pt;
end

load sa_res_160113_9-17;

for i = 9 : 17
    sample_capsule(i).low_bound = samples(i).low_bound;
    sample_capsule(i).up_bound = samples(i).up_bound;
    sample_capsule(i).class = samples(i).class;
    sample_capsule(i).SA_res_pt = samples(i).SA_res_pt;
end

load sa_res_160113_18-20;

for i = 18 : 20
    sample_capsule(i).low_bound = samples(i+1).low_bound;
    sample_capsule(i).up_bound = samples(i+1).up_bound;
    sample_capsule(i).class = samples(i+1).class;
    sample_capsule(i).SA_res_pt = samples(i+1).SA_res_pt;
end

load sa_res_160113_21-38;

for i = 21 : 38
    sample_capsule(i).low_bound = samples(i).low_bound;
    sample_capsule(i).up_bound = samples(i).up_bound;
    sample_capsule(i).class = samples(i).class;
    sample_capsule(i).SA_res_pt = samples(i).SA_res_pt;
end

load sa_res_160113_39-49;

for i = 39 : 49
    sample_capsule(i).low_bound = samples(i+1).low_bound;
    sample_capsule(i).up_bound = samples(i+1).up_bound;
    sample_capsule(i).class = samples(i+1).class;
    sample_capsule(i).SA_res_pt = samples(i+1).SA_res_pt;
end

load sa_res_160113_50-55;

for i = 50 : 55
    sample_capsule(i).low_bound = samples(i).low_bound;
    sample_capsule(i).up_bound = samples(i).up_bound;
    sample_capsule(i).class = samples(i).class;
    sample_capsule(i).SA_res_pt = samples(i).SA_res_pt;
end

