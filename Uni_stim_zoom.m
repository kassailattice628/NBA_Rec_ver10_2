function Uni_stim_zoom(i,col)
%For lateral inhibition (2 point stim) or Zoom (1point stim)
%中心地点と position_polerで，極座標で決めた位置に刺激を出す

global sobj
global recobj
global figUIobj

%%%%%%%%%%%%%%%%
% stim position (and luminace for BW fine mapping) 
sobj.position_cord2 = position_polar2(i,sobj.shiftDir);
% header 保存用に 刺激位置を stim1 のものとして保存
sobj.position_cord = sobj.position_cord2;

%%%%%%%%%%%%%%%%
%pause(0.001)%ないと trigger できない？（いらない）
%Rec start, Rec Time;
trigger_AIFV
%%%%%%%%%%%%%%%
Screen(sobj.shape, sobj.wPtr, col, sobj.position_cord2);
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
    else %FV trigger のときは TTL2 特に叩かなくてよい
        recobj.tTTL2 = 0;
    end
    [sobj.vbl_2, sobj.OnsetTime_2, sobj.FlipTimeStamp_2] = Screen(sobj.wPtr, 'Flip', sobj.vbl_1+sobj.delayPTB);% put some delay for PTB
    sobj.sFlipTimeStamp_2=toc(recobj.STARTloop);
    outputSingleScan(sTrig,[0,0,1,0]);% DO for visual stimulus start
    stim_monitor;
elseif recobj.delayTTL2/1000> sobj.delayPTB
    [sobj.vbl_2, sobj.OnsetTime_2, sobj.FlipTimeStamp_2] = Screen(sobj.wPtr, 'Flip', sobj.vbl_1+sobj.delayPTB);% put some delay for PTB
    outputSingleScan(sTrig,[0,0,1,0]);% DO for visual stimulus start
    stim_monitor;
    while toc(recobj.STARTloop) - recobj.RecStartTimeToc <= recobj.delayTTL2/1000;%wait TTL2 delay
    end
    if get(figUIobj.TTL2, 'value') == 0
        recobj.tTTL2 = trigger_rec(2) -  recobj.RecStartTimeToc;
    else %FV trigger のときは TTL2 特に叩かなくてよい
        recobj.tTTL2 = 0;
    end
end

disp(['AITrig; ',sobj.pattern, ': #', num2str(recobj.cycleNum)]);
%stim_OFF
Screen('FillRect', sobj.wPtr, sobj.bgcol);
[sobj.vbl_3, sobj.OnsetTime_3, sobj.FlipTimeStamp_3] = Screen(sobj.wPtr, 'Flip', sobj.vbl_2+sobj.duration); %%% sobj.duration 時間経過後 monitor stim off
outputSingleScan(sTrig,[0,0,0,0]);% DO resrt (stim off)
sobj.sFlipTimeStamp_3=toc(recobj.STARTloop);
stim_monitor_reset;

