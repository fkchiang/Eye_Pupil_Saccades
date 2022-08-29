% checked and saved by FKC, 5/25/2022 for tgEight_blkw22 in A & B
% checked and saved by FKC, 6/25/2022 for tgEight_blkwFKC in A & B
close all;clc;clear;
% cd /home/fengkuei/04_tgEight_blkw % 6/25/2022 @ the brain
cd G:\
temparray = [];
for Subject = 1
    if Subject == 1
        SubName = 'B';
        gamma = 1;
    elseif Subject == 2
        SubName = 'A';
        gamma = 1;
    end
    D = dir(['tgEight_hiddenFKC_' SubName '*.mat']);
    Sessions = length(D);
    SI = nan(Sessions,6,'single');
    MI = cell(Sessions,6);
    TargetSelected = 71:78;
    TimeOUT = 101:108;
    NumTargets = 8;
    for s = 1:Sessions
        load(D(s).name,'tgBHV');
        sumTable = tgBHV.sumTable;
        ConfigsInfo = tgBHV.ConfigsInfo;
        freq_table = tgBHV.freq_table;
        SacTable = tgBHV.SacTable;
        idx_commonOrder = ConfigsInfo(:,3:10);   % [block#,commonOrder]    
        blockChain = func_blockChain(sumTable);
        blockChain = func_removeBLK(blockChain); % remove blks with less than 20 trials
        for blk = 1:length(blockChain)
            ta_raw    = freq_table{blk}(:,2:9);
            ta_sorted = ta_raw(idx_commonOrder(blk,:),:);
            temp_sumDiag = sum(diag(ta_sorted));
            temp_sumDiagRes = sum(ta_sorted(:)) - temp_sumDiag;
            tgBHV.SI(1,blk) = (temp_sumDiag - temp_sumDiagRes)/(temp_sumDiag + temp_sumDiagRes);
            
            Hidden_Bdata.SI(s,blk) = (temp_sumDiag - temp_sumDiagRes)/(temp_sumDiag + temp_sumDiagRes);
            % % % % MI
            sac_array = SacTable{1,blk};
            [tf_matrix,counts_martrix] = func_mcTransMatrix(sac_array);
            [M, Q] = func_community_louvain(tf_matrix,gamma);
            % % reorder M: with group order 1 then 2 then 3
            idx_sorted = M(idx_commonOrder(blk,:));
            switch max(idx_sorted)
                case 1
                    % all eight target in one group
                case 2
                    if idx_sorted(1) == 1
                        % two labels for subgroups listed in order 1 then 2
                    elseif idx_sorted(1) == 2
                        temp = M;
                        M(temp==1) = 2;
                        M(temp==2) = 1;
                    end
                case 8
                    fprintf('Error: Subject %s-session=%.2d, block=%.2d\n',SubName,s,blk);
                    fprintf('warning: subgroup number should be changed manually\n')
            end
            fprintf('Session=%.2d, block=%.2d\n',s,blk);
            tgBHV.MI(1:8, blk) = M;
            tgBHV.MI(  9, blk) = Q;
            tgBHV.MI( 10, blk) = gamma;
            Hidden_Bdata.MI(s,blk) = Q;
            temparray=[temparray;M(idx_commonOrder(blk,:))'];
        end
%         save(D(s).name,'tgBHV','-append');  
        % saved, FKC, 6/26/2022
    end
end