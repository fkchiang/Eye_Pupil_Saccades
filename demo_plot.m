%% demo_plot: function plot and scatter
clear;clc;close all;
%% line plot: sample data from matlab document
figure('paperorientation','landscap','units','normalized','position',[0.1, 0.1, 0.8, 0.8]);
subplot(1,2,1);
x=0:0.2:7;
y=sin(x);
plot(x,y,'--b'); % help plot or page 62-64
axis square;     % normal
axis([-30, 30, -30, 30]);
box off;
set(gca,'tickdir','out',...
        'xtick',-30:30:30,'xticklabel',{'xmin','zero','xmax'});
xlabel('Range of X-level','FontSize',15);
title('Eye cursor');
%% scatter: sample data from matlab document
subplot(1,2,2);
theta = linspace(0,2*pi,300);
x = sin(theta) + 0.75*rand(1,300);
y = cos(theta) + 0.75*rand(1,300);
sz = 40;
scatter(x,y,sz,'MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor',[0 .7 .7],...
              'LineWidth',1.5)
axis square;axis([-2, 2, -2, 2]);box off;
set(gca,'tickdir','out',...
        'xtick',-2:0.5:2,'xticklabel',num2str((-2:0.5:2)'),...
        'ytick',-2:0.5:2,'yticklabel',num2str((-2:0.5:2)'));