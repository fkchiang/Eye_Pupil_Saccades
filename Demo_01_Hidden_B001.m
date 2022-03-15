clear;clc;close all;
load('Hidden_B001.mat','Hidden_B001','tgEyeData');
%% part 1: get normalized time stamp from behavioral data
sumTable = Hidden_B001.sumTable;
idx_CO = sumTable(:,4) == 0;
RtTable_CO = Hidden_B001.RtOnSetTable(1,idx_CO);
TG = 71:78;
idx_TG_CO = cellfun(@(x) ismember(x(:,9),TG),RtTable_CO,'un',false);
norTimeStamp_CO = cellfun(@(x,y) round(x(y,8)./2),RtTable_CO,idx_TG_CO,'un',false);
%% part 2: idx XY position based on the previous normalized time stamp
filtEyeXY_CO = tgEyeData.filtEyeXY(idx_CO);
Resp_XY_CO = cellfun(@(x,y) x(y,:),filtEyeXY_CO,norTimeStamp_CO,'un',false);
% save('Hidden_B001.mat','Resp_XY_CO','-append');
%% part 3: calculate the distance between actual targets and Resp_XY_CO in each block
