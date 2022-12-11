%% created by FKC, 8/18/2022
clear;clc;close all;
% path = 'C:\user\Documents\'; % change the path base your folder location
% cd path
for Subject = 1
    if Subject == 1
        SubName = 'B';    
    end
    taskName = 'Hidden';
    D = dir([taskName '_' SubName '*.mat']);
    fprintf('%s\n',D(end).name);
    Sessions = length(D);
    tic;
    for s = 1:Sessions
        % % Section: load files
        SesName = sprintf('%s%.3d',SubName,s); % example: 'B001'
        fileName = [taskName '_' SesName];     % example: 'Hidden_B001'
        data = load([fileName '.mat'],fileName);
        sumTable = data.(fileName).sumTable;
        RtOnSetTable = data.(fileName).RtOnSetTable;
        ConfigsInfo = data.(fileName).ConfigsInfo;
        % % Section: reaction times
          % example variable: RT        
          % RT = ...
          
          
          
        % % Section: distance
          % example variable: DT
          % DT = ...
          
          
          
        % % Section: save file after calculation
          % Results_Hidden.(SesName).RT = RT;
          % Results_Hidden.(SesName).DT = DT;
          keyboard
    end
end