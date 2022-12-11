close all;clc;clear;
load('tgEight_blkwise_B007.mat', 'tgBHV','tgEyeData');
load('dotsEIGHTfinal.mat', 'config80');
sumTable = tgBHV.sumTable;
TrialError = sumTable(:,4);
RtOnSetTable = tgBHV.RtOnSetTable;
filtEyeXY = tgEyeData.filtEyeXY;
SacLabel = {'S1','S2','S3','S4','S5','S6','S7','S8'};
%% configuration plot
Trial = 220;
if TrialError(Trial) ~= 0
    disp('incomplete trials');
    return
end
Loc_XY = sumTable(Trial,15:22);
%% Eye tracjectory
TG = 71:78;
idx_CO  =  ismember(RtOnSetTable{1,Trial}(:,9),TG);
idx_eyeMove = floor(RtOnSetTable{1,Trial}(idx_CO,4)./2);
idx_eyeStay = floor(RtOnSetTable{1,Trial}(idx_CO,8)./2);
figure(1);
plot(0,0,'yo','MarkerFaceColor','y','MarkerSize',3);hold on;
plot(config80(Loc_XY,2),config80(Loc_XY,3),'go','MarkerFaceColor','g','MarkerSize',10);hold on;
xlabel('Distance(VD)');
ylabel('Distance(VD)');
set(gca,'tickdir','out','Color','k');
axis square;axis([-20 20 -20 20]);box off;
pause(1);
for i = 1:8
    figure(1);
    text(config80(Loc_XY(i),2)+1,config80(Loc_XY(i),3)-1,SacLabel{i},'Fontsize',12,'Color','y');hold on;
    ie = idx_eyeMove(i):1:idx_eyeStay(i);
    plot(filtEyeXY{1,Trial}(ie,1), filtEyeXY{1,Trial}(ie,2),'-w');hold on;
    pause(1);
end