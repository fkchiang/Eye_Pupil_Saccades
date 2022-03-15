clear;clc;close all;
load('Hidden_B001.mat','Hidden_B001');
load('dotsEIGHTfinal.mat','config80');
sumTable = Hidden_B001.sumTable;
idx_CO = sumTable(:,4) == 0;
sumTable_CO = sumTable(idx_CO,:);

SacOrder = sumTable_CO(:,8:15);
Loc_TG = sumTable_CO(:,16:23);

idx_block = sumTable_CO(:,2);
blockNum = unique(sumTable_CO(:,2),'stable');

for b = 1:6
    Loc_block = find(idx_block == blockNum(b),1,'first');
    
    SacOrder_block = Loc_TG(Loc_block,SacOrder(Loc_block,:));
    keyboard
%     SacOrder_block = Loc_block(b,SacOrder(Loc_block(b,1)));
    
    
    
%     actualTG{1,b} = 
end




