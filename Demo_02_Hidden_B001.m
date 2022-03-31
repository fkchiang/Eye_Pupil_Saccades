clear;clc;close all;
load('Hidden_B001.mat','Hidden_B001','tgEyeData');

idx_CO = Hidden_B001.sumTable(:,4) == 0;
% newSumTable = Hidden_B001.sumTable(idx_CO,:);
% for tr = 1:240
%     for = k = 1:8        
%         varables(tr,k) = func_pdist(p1,p2);
%     end    
% end

variables = nan(size(newsumTable,1),8);

ones(5,10)