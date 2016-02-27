function main_loopingtest
global recobj
global figUIobj
global sobj
global floop
global sTrig
global s

floop = get(figUIobj.loop,'value');
fstim = get(figUIobj.stim,'value');

if floop == 0;% Loop-Out
    set(figUIobj.loop,'string','Loop-Out','BackGroundColor','r');
    if sobj.ScrNum ~= 0
        %Toku では dio を 4つ
        outputSingleScan(sTrig,[0,0,0,0]); %trigger reset
    end
    sobj.Dir8 = randperm(8);
    sobj.Dir16 = randperm(16);
elseif floop == 1;%Looping
    tic
    ch_save;%  check save file name  %%%%%
    set(figUIobj.loop,'string','Looping','BackGroundColor','g');
    daqsetting;
    
    %%%%%  main looping  %%%%%
    
    while floop == 1
        try %error check
            recobj.cycleNum = recobj.cycleNum +1;            
            startBackground(s); %wait trigger for recording
            %%%%%%%%%%%%%%%%%%%%%%%
            if fstim == 1%visual stim ON
                visual_stimulus;
                recobj.tRec = sobj.vbl_1- recobj.RecStartTime; %Absolute time
                sobj.tPTBon = sobj.vbl_2 - sobj.vbl_1;
                sobj.tPTBoff = sobj.vbl_3 -  sobj.vbl_1;
                if strcmp(sobj.pattern, '2stim') == 1
                    sobj.tPTBon2 = sobj.vbl2_2 - sobj.vbl_1;
                    sobj.tPTBoff2 = sobj.vbl2_3 - sobj.vbl_1;
                end
            elseif fstim == 0;%visual stimulus OFF, Elechtorichal Rec Only
                trigger_AIFV;
                recobj.tRec = toc(recobj.STARTloop);
                recobj.TTL2 = 0;
                sobj.tPTBon = 0;
                sobj.tPTBon2 = 0;
                sobj.tPTBoff = 0;
                sobj.tPTBoff2 = 0;
                sobj.position = 0;
                sobj.position_cord = zeros(1,4);
                sobj.position_cord2 = zeros(1,4);
                sobj.stim2_center = zeros(1,2);
                sobj.dist_pix = 0;
            end
            %%%%%%%%%%%%%%%%%
            %%%%%  data get   %%%%%
            %%%%%%%%%%%%%%%%%
            % data は RecPlotData の中で recobj.dataall に入るようになってる
            % savedata を作る前に interval とる必要あり（？）
            s.wait(recobj.rect/1000 +1);
            %wait(s,recobj.rect/1000);
            drawnow update
            %%%%%%%%%%%%%%%%%
            %%%%%  set save data  %%%%%
            %%%%%%%%%%%%%%%%%
            savedata;
            %%%%%%%%%%%%%%%%%
            %%%%%   reset trigger   %%%%
            %%%%%%%%%%%%%%%%%
            outputSingleScan(sTrig,[0,0,0,0]); %trigger reset
            stop(s)
            pause(recobj.interval);
            floop = get(figUIobj.loop,'value');
        catch ME1
            %PTB error
            Screen('CloseAll');
            rethrow(ME1);
        end
        disp(['#: ',num2str(recobj.cycleNum)])
    end %%% Loop END %%%
    
    
    %%% Reset Cycle Num %%%
    recobj.cycleNum = 0- recobj.prestim;
    disp(['Loop-Out:', num2str(recobj.cycleNum)]);
    sobj.stimsz = stim_size(sobj.MonitorDist,figUIobj.size); %Random size の後 size を戻す
    sobj.stimsz2 = stim_size(sobj.MonitorDist,figUIobj.size2);
    clear recobj.STARTloop;
end