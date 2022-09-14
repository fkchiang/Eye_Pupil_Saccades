%% created by FKC, 8/05/2022
clear;clc;close all;
cd G:\ % OneDrive\Documents\GitHub\Eye_Pupil_Saccades
for Subject = 2
    if Subject == 1
        SubName = 'B';
    elseif Subject == 2
        SubName = 'A';
    end
    taskName = 'tgEight';
    D = dir(['Hidden_' SubName '*.mat']);
    fprintf('%s\n',D(end).name);
    Sessions = length(D);
    tic;
    for s = 1:Sessions
        VarName = sprintf('Hidden_%s%.3d',SubName,s);
        load([VarName '.mat'],VarName);
        %% part 1: get normalized time stamp from behavioral data
        sumTable = eval([VarName '.sumTable']);
        idx_CO = sumTable(:,4) == 0;
        RtTable_CO = eval([VarName '.RtOnSetTable(1,idx_CO)']);
        TG = 71:78;
        idx_TG_CO = cellfun(@(x) ismember(x(:,9),TG),RtTable_CO,'un',false);
        norTimeStamp_CO = cellfun(@(x,y) round(x(y,8)./2),RtTable_CO,idx_TG_CO,'un',false);
        %% part 2: idx XY position based on the previous normalized time stamp
        load([VarName '.mat'],'tgEyeData');
        filtEyeXY_CO = tgEyeData.filtEyeXY(idx_CO);
        Resp_XY_CO = cellfun(@(x,y) x(y,:),filtEyeXY_CO,norTimeStamp_CO,'un',false);
        save([VarName '.mat'],'Resp_XY_CO','-append');        
    end
end