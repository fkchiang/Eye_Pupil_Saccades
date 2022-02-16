%%  func_EyeBlinkFilter
% % FKC, 6/10/2019
% % 1. filter out the eye blink based on the pupil size.
% % 2. then add new pupil size and X_ & Y_coordinate by interpolation into the gap.
% % visualize the sample plot:
% %     BHV = mlread;
% %     Pupil = arrayfun(@(x) x.AnalogData.General.Gen1, BHV, 'uniformoutput',false);
% %     EyeXY = arrayfun(@(x) x.AnalogData.Eye, BHV, 'uniformoutput',false);
% %     [nPupil,nEyeXY] = func_EyeBlinkFilter(Pupil{1},EyeXY{1}); % plot first trial 
% %     plot(Pupil{1},'-b');hold on;
% %     plot(nPupil,'--r','linewidth',1.5);hold on;
% %     legend('raw','filted');xlabel('time (ms)');ylabel('Raw data from iScan');axis normal;
function [nPupil,nEyeXY] = func_EyeBlinkFilter(Pupil,EyeXY)
    if sum(Pupil < -3.25) <= 0 % -3.25 is a criterion from raw data in pupil size.
        nPupil = Pupil;
        nEyeXY = EyeXY;
        return
    end
    std_Pupil = scaledata(Pupil,0,1);
    idx_blink = std_Pupil < 0.2;
    window = [0,1];
    Loc_Start = zeros(1,length(idx_blink)-1);
    Loc_End = zeros(1,length(idx_blink)-1);
    temp_Start = zeros(1,length(idx_blink));
    temp_End = zeros(1,length(idx_blink));
    for i = 1:( length(idx_blink) - 1 )
        if diff(idx_blink(window+i))==0
            continue
        elseif diff(idx_blink(window+i)) ==  1 % [0,1]
            temp_Start(1,i) = 1;
        elseif diff(idx_blink(window+i)) == -1 % [1,0]
            temp_End(1,i+1) = 1;
        end
    end
    size_start = length(find(temp_Start==1));
    size_end = length(find(temp_End==1));

    if isequal(size_start,size_end)
        cS = (find(temp_Start==1,1,'first') - 5) <= 0;    
        switch cS        
            case 1 % need adjust
                temp = find(temp_Start==1);
                Loc_Start = [1,temp(2:end)-5];
            case 0 % no adjust
                Loc_Start = find(temp_Start==1)-5;
        end    
        cE = (find(temp_End==1,1,'last') + 5) > length(idx_blink);
        switch cE
            case 1 % need adjust
                temp = find(temp_End==1);
                Loc_End = [temp(1:(end-1))+5,length(idx_blink)];
            case 0 % no adjust
                Loc_End = find(temp_End==1)+5;
        end                   
    elseif ~isequal(size_start,size_end)
        if diff([size_end,size_start]) == 1
            temp = find(temp_End==1);
            Loc_End = [temp+5, length(idx_blink)];
            cS = (find(temp_Start==1,1,'first') - 5) <= 0;
            switch cS        
                case 1 % need adjust
                    temp = find(temp_Start==1);
                    Loc_Start = [1,temp(2:end)-5];
                case 0 % no adjust
                    Loc_Start = find(temp_Start==1)-5;
            end            
        elseif diff([size_end,size_start]) == -1
            temp = find(temp_Start==1);
            Loc_Start = [1, temp-5];
            cE = (find(temp_End==1,1,'last') + 5) > length(idx_blink);
            switch cE       
                case 1 % need adjust
                    temp = find(temp_End==1);
                    Loc_End = [temp(1:(end-1))+5,length(idx_blink)];
                case 0 % no adjust
                    Loc_End = find(temp_End==1)+5;
            end                       
        end
    end

    Loc_SE = [Loc_Start;Loc_End];
    
%     fprintf('EyeXY_size = %.f\n',length(EyeXY)); % for debug
    nPupil = Pupil;
    for bik = 1:size(Loc_SE,2)
%         fprintf('bik = %.f\n',bik); % for debug
        x = [Loc_SE(1,bik),Loc_SE(2,bik)];
        vPupil = [Pupil(Loc_SE(1,bik)),Pupil(Loc_SE(2,bik))];        
        xq = Loc_SE(1,bik):Loc_SE(2,bik);
        vq = interpn(x,vPupil,xq,'linear');    
        nPupil(xq) = vq;
    end
        
    newEyeX = EyeXY(:,1);
    for bik = 1:size(Loc_SE,2)
        x = [Loc_SE(1,bik),Loc_SE(2,bik)];
        vEyX = [EyeXY(Loc_SE(1,bik),1),EyeXY(Loc_SE(2,bik),1)];
        
        xq = Loc_SE(1,bik):Loc_SE(2,bik);
        vq = interpn(x,vEyX,xq,'linear');    
        newEyeX(xq) = vq;    
    end

    newEyeY = EyeXY(:,2);
    for bik = 1:size(Loc_SE,2)
        x = [Loc_SE(1,bik),Loc_SE(2,bik)];
        vEyY = [EyeXY(Loc_SE(1,bik),2),EyeXY(Loc_SE(2,bik),2)];
        xq = Loc_SE(1,bik):Loc_SE(2,bik);
        vq = interpn(x,vEyY,xq,'linear');
        newEyeY(xq) = vq;    
    end
    nEyeXY = [newEyeX,newEyeY];
end