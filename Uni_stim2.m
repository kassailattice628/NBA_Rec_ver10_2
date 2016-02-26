function Uni_stim2(i,col)
global sobj
global recobj
global figUIobj

%Direction ‚ÍŠÖŒW‚È‚¢‚Ì‚Å 0
sobj.dirNum = 0;
%[left, top, right, bottom]€”õ
x1 = sobj.pos(1,sobj.Y(i))-sobj.stimsz(1)/2;
y1 = sobj.pos(2,sobj.X(i))-sobj.stimsz(2)/2;
x2 = sobj.pos(1,sobj.Y(i))+sobj.stimsz(1)/2;
y2 = sobj.pos(2,sobj.X(i))+sobj.stimsz(2)/2;
sobj.position_cord = [x1,y1,x2,y2];


%pause(0.001)%‚È‚¢‚Æ trigger ‚Å‚«‚È‚¢Hi‚¢‚ç‚È‚¢?j
%Rec start, Rec Time;
trigger_AIFV

Screen(sobj.shape, sobj.wPtr, col, sobj.position_cord);
%PhotoSensor (left, up)     Timing Checker
if recobj.cycleNum > 0
    Screen('FillRect', sobj.wPtr, 255, [0 0 40 40]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if recobj.delayTTL2/1000 <= sobj.delayPTB
    while toc(recobj.STARTloop) - recobj.RecStartTimeToc <= recobj.delayTTL2/1000;%wait TTL2 delay (include delay TTL2 == 0)
    end
    if get(figUIobj.TTL2, 'value') == 0
        recobj.tTTL2 = trigger_rec(2) -  recobj.RecStartTimeToc;
    else %FV trigger ‚Ì‚Æ‚«‚Í TTL2 “Á‚É’@‚©‚È‚­‚Ä‚æ‚¢
        recobj.tTTL2 = 0;
    end
    [sobj.vbl_2, sobj.OnsetTime_2, sobj.FlipTimeStamp_2] = Screen(sobj.wPtr, 'Flip', sobj.vbl_1+sobj.delayPTB);% put some delay for PTB
    sobj.sFlipTimeStamp_2=toc(recobj.STARTloop);
    stim_monitor;
elseif recobj.delayTTL2/1000> sobj.delayPTB
    [sobj.vbl_2, sobj.OnsetTime_2, sobj.FlipTimeStamp_2] = Screen(sobj.wPtr, 'Flip', sobj.vbl_1+sobj.delayPTB);% put some delay for PTB
    stim_monitor;
    while toc(recobj.STARTloop) - recobj.RecStartTimeToc <= recobj.delayTTL2/1000;%wait TTL2 delay
    end
    if get(figUIobj.TTL2, 'value') == 0
        recobj.tTTL2 = trigger_rec(2) -  recobj.RecStartTimeToc;
    else %FV trigger ‚Ì‚Æ‚«‚Í TTL2 “Á‚É’@‚©‚È‚­‚Ä‚æ‚¢
        recobj.tTTL2 = 0;
    end
end

disp(['AITrig; ',sobj.pattern, ': #', num2str(recobj.cycleNum)]);


%stim_OFF
Screen('FillRect', sobj.wPtr, sobj.bgcol);
[sobj.vbl_3, sobj.OnsetTime_3, sobj.FlipTimeStamp_3] = Screen(sobj.wPtr, 'Flip', sobj.vbl_2+sobj.duration); %%% sobj.duration ŽžŠÔŒo‰ßŒã monitor stim off
sobj.sFlipTimeStamp_3=toc(recobj.STARTloop);
stim_monitor_reset;

