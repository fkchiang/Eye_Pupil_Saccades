clear;clc;close all;
% 1. create an example matrix with NaNs
eMtx = randi(5,3,5); % [trials, saccades]
eMtx(3,[2,4]) = nan; 
% 2. would like to change this matrix to a column vector and sort it by trials first and then saccades.
%    the length of this column vector is equal to the numbers of values with no NaNs.
temp = eMtx';
cVec = temp(:);
idx_nan = isnan(cVec);
% check: [temp(:),idx_nan]
cVec = cVec(~idx_nan); % got the column vector.
