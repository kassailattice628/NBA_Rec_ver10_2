function check_duration2
global sobj
global recobj
global figUIobj

switch get(figUIobj.EOf,'value')
    case 0 %FV + Elech
        %% sobj
        sobj.duration = sobj.flipNum*sobj.m_int;
        set(figUIobj.stimDur,'string',['flips = ',num2str(floor(sobj.duration*1000)),' ms']);
        sobj.delayPTB = sobj.delayPTBflip*sobj.m_int;
        set(figUIobj.delayPTB,'string',['flips = ',num2str(floor(sobj.delayPTB*1000)),' ms']);
        
        %%%%%%%%% duration 1 error %%%%%%%%%
        if sobj.duration*1000 + sobj.delayPTB*1000 > recobj.rect
            errordlg('Stim. duration is longer than Recording time !!');
            
            sobj.flipNum = 75;
            set(figUIobj.flipNum, 'string', 75);
            sobj.delayPTBflip = 20;
            set(figUIobj.delayPTBflip, 'string', 20);
            sobj.duration = sobj.flipNum*sobj.m_int;
            sobj.delayPTB = sobj.delayPTBflip*sobj.m_int;
            recobj.rect = 2000; %ms
            set(figUIobj.rect, 'string', 2000);
        end
        
        if figUIobj.pattern ~= 8
            sobj.duration2 = 0;
            set(figUIobj.stimDur2,'string','flips = 0 ms');
            sobj.delayPTB2 = 0;
            set(figUIobj.delayPTB2,'string','flips = 0 ms');
            
        else %figUIboj.pattern == 8 % for 2nd stimulus
            sobj.duration2 = sobj.flipNum2*sobj.m_int;
            set(figUIobj.stimDur2,'string',['flips = ',num2str(floor(sobj.duration2*1000)),' ms']);
            sobj.delayPTB2 = sobj.delayPTBflip2*sobj.m_int;
            set(figUIobj.delayPTB2,'string',['flips = ',num2str(floor(sobj.delayPTB2*1000)),' ms']);
            
            %%%%%%%%% duration 2 error %%%%%%%%%
            if (sobj.duration2*1000 + sobj.delayPTB2*1000 > recobj.rect)
                errordlg('2nd Stim. duration is longer than Recording time !!');
                sobj.flibNum2 = 75;
                set(figUIobj.flipNum2, 'string', 75);
                sobj.delayPTBflip2 = 20;
                set(figUIobj.delayPTBflip2, 'string', 20);
                sobj.duration2 = sobj.flibNum2*sobj.m_int;
                sobj.delayPTB2 = sobj.delayPTBflip2*sobj.m_int;
                recobj.rect = 2000; %ms
                set(figUIobj.rect, 'string', 2000);
            end
        end
        %% pulse
        if (recobj.pulseDelay + recobj.pulseDuration)*1000 > recobj.rect
            errordlg('Pulse duration is longer than Recording time !!');
            recobj.pulseDuration = 0.2; %sec
            set(figUIobj.pulseDuration, 'string', 0.2);
            recobj.pulseDelay = 0.1; %sec
            set(figUIobj.pulseDelay, 'string', 0.1);
        end
        reload_recdaq;
        %check_duration2;%再チェックいる？
        
    case 1 % check pulse only/ ignore vis stim duration when E only
        sobj.duration = sobj.flipNum*sobj.m_int;
        set(figUIobj.stimDur,'string',['flips = ',num2str(floor(sobj.duration*1000)),' ms']);
        sobj.delayPTB = sobj.delayPTBflip*sobj.m_int;
        set(figUIobj.delayPTB,'string',['flips = ',num2str(floor(sobj.delayPTB*1000)),' ms']);
        
        if (recobj.pulseDelay + recobj.pulseDuration)*1000 > recobj.rect
            errordlg('Pulse duration is are longer than Recording time !!');
            recobj.pulseDuration = 0.2; %sec
            set(figUIobj.pulseDuration, 'string', 0.2);
            recobj.pulseDelay = 0.1; %sec
            set(figUIobj.pulseDelay, 'string', 0.1);
            recobj.rect = 500; %ms
            set(figUIobj.rect, 'string',500);
            reload_recdaq;
        end
end

