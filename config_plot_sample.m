% sample plot
clear;clc;close all;
load('Hidden_B001','Hidden_B001','tgEyeData');
load('dotsEIGHTfinal.mat', 'config80');
config = config80;
Trial = 2;
func_ConfigPlot_w_Eye(Trial,Hidden_B001,tgEyeData,config);
print(gcf,'-dpdf','-r300','-bestfit','Hidden_B001_block#01_sample_trial#02');