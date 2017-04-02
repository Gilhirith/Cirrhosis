close all;
clear all;
clc;

class(1).name = 'normal';
class(2).name = 'mild';
class(3).name = 'moderate';

img_dir = 'G:/Liver Capsule/Image/raw_all/';
save_dir = 'G:/Liver Capsule/Image/Code/res_160113/';

sample_cnt = 49;
n_lev = 8;
eps = 1e-5;

img_cnt = 0;

load img_tol_Ribeiro;
load img_big_sample;

for i = 1 : 68
%     for fr = 1 : 30
%         if exist([img_dir, 'cut_', class(cls).name, '_', num2str(fr), '.jpg'])
%             img = im2double(imread([img_dir, 'cut_', class(cls).name, '_', num2str(fr), '.jpg']));
%             cls
            img_parenchyma = img_big_sample{i}.img_patch;
            img_cnt = img_cnt + 1;
            figure, imshow(img_parenchyma);
%             [x, y] = ginput();
%             [x2, y2] = ginput();
%             img_parenchyma = img(y : y2, x : x2);
%             figure, imshow(img_parenchyma);
            
            [M,N,O] = size(img_parenchyma);
% %             M = 128;
% %             N = 128;
% 
%             %--------------------------------------------------------------------------
%             %1.将各颜色分量转化为灰度
%             %--------------------------------------------------------------------------
%             % Gray = double(0.3*Image(:,:,1)+0.59*Image(:,:,2)+0.11*Image(:,:,3));
% 
%             %--------------------------------------------------------------------------
%             %2.为了减少计算量，对原始图像灰度级压缩，将Gray量化成16级
%             %--------------------------------------------------------------------------
%             for i = 1:M
%                 for j = 1:N
%                     for n = 1:256/16
%                         if (n-1)*16<=Gray(i,j) & Gray(i,j)<=(n-1)*16+15
%                             Gray(i,j) = n-1;
%                         end
%                     end
%                 end
%             end
% 
%             %--------------------------------------------------------------------------
%             %3.计算四个共生矩阵P,取距离为1，角度分别为0,45,90,135
%             %--------------------------------------------------------------------------
%             P = zeros(16,16,4);
%             for m = 1:16
%                 for n = 1:16
%                     for i = 1:M
%                         for j = 1:N
%                             if j<N&Gray(i,j)==m-1&Gray(i,j+1)==n-1
%                                 P(m,n,1) = P(m,n,1)+1;
%                                 P(n,m,1) = P(m,n,1);
%                             end
%                             if i>1&j<N&Gray(i,j)==m-1&Gray(i-1,j+1)==n-1
%                                 P(m,n,2) = P(m,n,2)+1;
%                                 P(n,m,2) = P(m,n,2);
%                             end
%                             if i<M&Gray(i,j)==m-1&Gray(i+1,j)==n-1
%                                 P(m,n,3) = P(m,n,3)+1;
%                                 P(n,m,3) = P(m,n,3);
%                             end
%                             if i<M&j<N&Gray(i,j)==m-1&Gray(i+1,j+1)==n-1
%                                 P(m,n,4) = P(m,n,4)+1;
%                                 P(n,m,4) = P(m,n,4);
%                             end
%                         end
%                     end
%                     if m==n
%                         P(m,n,:) = P(m,n,:)*2;
%                     end
%                 end
%             end

            [P(:, :, 1), SI] = graycomatrix(img_parenchyma, 'NumLevels', n_lev, 'G', [], 'Offset',[6 0]); %1
            [P(:, :, 2), SI] = graycomatrix(img_parenchyma, 'NumLevels', n_lev, 'G', [], 'Offset',[6 6]);
            [P(:, :, 3), SI] = graycomatrix(img_parenchyma, 'NumLevels', n_lev, 'G', [], 'Offset',[0 6]);
            [P(:, :, 4), SI] = graycomatrix(img_parenchyma, 'NumLevels', n_lev, 'G', [], 'Offset',[-6 6]);

            %%---------------------------------------------------------
            % 对共生矩阵归一化
            %%---------------------------------------------------------
            for n = 1:4
                P(:,:,n) = P(:,:,n)/sum(sum(P(:,:,n)));
            end
            img_glcm(img_cnt).energy06 = sum(sum(P(:, :, 3).^2));
%             img_tol_Ribeiro(img_cnt).energy06 = sum(sum(P(:, :, 3).^2));

% % % % %             %--------------------------------------------------------------------------
% % % % %             %4.对共生矩阵计算能量、熵、惯性矩、相关4个纹理参数
% % % % %             %--------------------------------------------------------------------------
% % % % %             H = zeros(1,4);
% % % % %             I = H;
% % % % %             Ux = H;      Uy = H;
% % % % %             deltaX = H;  deltaY = H;
% % % % %             C = H;       IDM = H;
% % % % %             for n = 1:4
% % % % %                 E(n) = sum(sum(P(:,:,n).^2)); %%能量
% % % % %                 for i = 1 : n_lev
% % % % %                     for j = 1 : n_lev
% % % % %                         if P(i,j,n)~=0
% % % % %                             H(n) = -P(i,j,n)*log(P(i,j,n))+H(n); %%熵
% % % % %                         end
% % % % %                         I(n) = (i-j)^2*P(i,j,n)+I(n);  %%惯性矩
% % % % % 
% % % % %                         Ux(n) = i*P(i,j,n)+Ux(n); %相关性中μx
% % % % %                         Uy(n) = j*P(i,j,n)+Uy(n); %相关性中μy
% % % % %                     end
% % % % %                 end
% % % % %             end
% % % % %             for n = 1 : 4
% % % % %                 for i = 1 : n_lev
% % % % %                     for j = 1 : n_lev
% % % % %                         deltaX(n) = (i-Ux(n))^2*P(i,j,n)+deltaX(n); %相关性中σx
% % % % %                         deltaY(n) = (j-Uy(n))^2*P(i,j,n)+deltaY(n); %相关性中σy
% % % % %                         C(n) = i*j*P(i,j,n)+C(n);
% % % % %                         IDM(n) = P(i,j)/(1+(i-j)^2) + IDM(n); %反差分
% % % % %                     end
% % % % %                 end
% % % % %                 C(n) = (C(n)-Ux(n)*Uy(n))/(deltaX(n)+eps)/(deltaY(n)+eps); %相关性  
% % % % %             end
% % % % % 
% % % % %             %--------------------------------------------------------------------------
% % % % %             %求能量、熵、惯性矩、相关的均值和标准差作为最终8维纹理特征
% % % % %             %--------------------------------------------------------------------------
% % % % %             img_glcm(img_cnt).energy(1, 1) = mean(E);
% % % % %             img_glcm(img_cnt).energy(1, 2) = sqrt(cov(E));
% % % % % 
% % % % %             img_glcm(img_cnt).entropy(1, 1) = mean(H);
% % % % %             img_glcm(img_cnt).entropy(1, 2) = sqrt(cov(H));
% % % % % 
% % % % %             img_glcm(img_cnt).inertia(1, 1) = mean(I);
% % % % %             img_glcm(img_cnt).inertia(1, 2) = sqrt(cov(I));
% % % % % 
% % % % %             img_glcm(img_cnt).cor(1, 1) = mean(C);
% % % % %             img_glcm(img_cnt).cor(1, 2) = sqrt(cov(C));
% % % % %             
% % % % %             img_glcm(img_cnt).indiff(1, 1) = mean(IDM);
% % % % %             img_glcm(img_cnt).indiff(1, 2) = sqrt(cov(IDM));
% % % % % 
            img_glcm(img_cnt).glcm_mtx = P;
            img_glcm(img_cnt).img_patch = img_parenchyma;
%             img_tol_Ribeiro(img_cnt).glcm_mtx = P;
%             img_tol_Ribeiro(img_cnt).img_patch = img_parenchyma;
            
            close all;
%             sprintf('0,45,90,135方向上的能量依次为： %f, %f, %f, %f',E(1),E(2),E(3),E(4))  % 输出数据;
%             sprintf('0,45,90,135方向上的熵依次为： %f, %f, %f, %f',H(1),H(2),H(3),H(4))  % 输出数据;
%             sprintf('0,45,90,135方向上的惯性矩依次为： %f, %f, %f, %f',I(1),I(2),I(3),I(4))  % 输出数据;
%             sprintf('0,45,90,135方向上的相关性依次为： %f, %f, %f, %f',C(1),C(2),C(3),C(4))  % 输出数据;

%             [glcm,SI] = graycomatrix(img_parenchyma, 'NumLevels', 9, 'G', [])
%             
%             if min(glcm(:)) == 0
%                 glcm = glcm + 1;
%             end
%             
%             p = glcm / max(glcm(:));
%             for i = 1 : size(p, 1)
%                 for j = 1 : size(p, 2)
%                     ASM=sum(p(i,j).^2);
%                     ENT=sum(p(i,j).*(-log(p(i,j))));
%                     IDM=sum(p(i,j)/(1+(i-j)^2));
%                 end
%             end
% 

%         end
%     end
end

tic;