%% created by FKC, 8/05/2022
clear;clc;close all;
cd G:\
for Subject = 2
    if Subject == 1
        SubName = 'B';
    elseif Subject == 2
        SubName = 'A';
    end
    taskName = 'tgEight';
    D = dir(['*_' SubName '*_' taskName '_hiddenTG_' SubName '*.bhv2']);
    fprintf('%s\n',D(end).name);
    Sessions = length(D);
    tic;
    for s = 1:Sessions
        fileName = sprintf('%s%.3d',SubName,s);
        [tgBHV,tgEyeData] = func_mlread_invi(D(s).name);
%         save([ taskName '_hiddenFKC_' fileName '.mat'],'tgBHV','tgEyeData');
        eval([sprintf('Hidden_%s.profiles', fileName) '= tgBHV.profiles']);
        eval([sprintf('Hidden_%s.sumTable', fileName) '= tgBHV.sumTable']);
        eval([sprintf('Hidden_%s.RtOnSetTable', fileName) '= tgBHV.RtOnSetTable']);
        eval([sprintf('Hidden_%s.ConfigsInfo', fileName) '= tgBHV.ConfigsInfo']);
        save(['Hidden_' fileName '.mat'],['Hidden_', fileName],'tgEyeData');
        toc;
    end
end
% cd D:\OneDrive\Documents\GitHub\Eye_Pupil_Saccades