function Two_stim_lag3(i, col1, col2, delay1, delay2)
global sobj

sobj.position_cord2 = position_polar2(i, sobj.shiftDir);

%%%
%pause(0.01)
trigger_AIFV

%Make OffscreenTexture
%Stim1
Stim1 = Screen('OpenOffscreenWindow', sobj.ScrNum, sobj.bgcol);
Screen(sobj.shape, Stim1, col1, sobj.position_cord);
Screen('FillRect',Stim1, 180, [0 0 40 40]);%sensor for 1 stimulus

%Stim2
Stim2 = Screen('OpenOffscreenWindow', sobj.ScrNum, sobj.bgcol);
Screen(sobj.shape2, Stim2, col2, sobj.position_cord2);
Screen('FillRect',Stim2, 180, [0 0 40 40]);%sensor for 1 stimulus

%Stim1+2
Stim3 = Screen('OpenOffscreenWindow', sobj.ScrNum, sobj.bgcol);
Screen(sobj.shape, Stim3, col1, sobj.position_cord);
Screen(sobj.shape2, Stim3, col2, sobj.position_cord2);
Screen('FillRect',Stim3, 255, [0 0 40 40]);%sensor for 2 stimuli

%%%%%%%
%ScreenFlip%
%%%%%%%
if delay1 == delay2
    Screen('DrawTexture', sobj.wPtr, Stim3)
    [sobj.vbl_2, sobj.OnsetTime_2, sobj.FlipTimeStamp_2] = Screen('Flip', sobj.wPtr, sobj.vbl_1 + delay1);
    sobj.vbl2_2 = sobj.vbl_2;
    sobj.OnsetTime2_2 = sobj.OnsetTime_2;
    sobj.FlipTimeStamp2_2 = sobj.FlipTimeStamp_2;
elseif delay1 < delay2
    Screen('DrawTexture', sobj.wPtr, Stim1)
    [sobj.vbl_2, sobj.OnsetTime_2, sobj.FlipTimeStamp_2] = Screen('Flip', sobj.wPtr, sobj.vbl_1 + delay1);
    Screen('DrawTexture', sobj.wPtr, Stim3)
    [sobj.vbl2_2, sobj.OnsetTime2_2, sobj.FlipTimeStamp2_2] = Screen('Flip', sobj.wPtr, sobj.vbl_1 + delay2);
elseif delay1 > delay2
    Screen('DrawTexture', sobj.wPtr, Stim2)
    [sobj.vbl2_2, sobj.OnsetTime2_2, sobj.FlipTimeStamp2_2] = Screen('Flip', sobj.wPtr, sobj.vbl_1 + delay2);
    Screen('DrawTexture', sobj.wPtr, Stim3)
    [sobj.vbl_2, sobj.OnsetTime_2, sobj.FlipTimeStamp_2] = Screen('Flip', sobj.wPtr, sobj.vbl_1 + delay1);
end
stim_monitor;

dur1 = delay1+sobj.duration;
dur2 = delay2+sobj.duration2;

if dur1 == dur2
    Screen('FillRect', sobj.wPtr, sobj.bgcol);
    [sobj.vbl_3, sobj.OnsetTime_3, sobj.FlipTimeStamp_3] = Screen('Flip', sobj.wPtr, sobj.vbl_1+dur1);
    sobj.vbl2_3 = sobj.vbl_3;
    sobj.OnsetTime2_3 = sobj.OnsetTime_3;
    sobj.FlipTimeStamp2_3 = sobj.FlipTimeStamp_3;
elseif dur1 < dur2
    Screen('DrawTexture', sobj.wPtr, Stim2);
    [sobj.vbl_3, sobj.OnsetTime_3, sobj.FlipTimeStamp_3] = Screen('Flip', sobj.wPtr, sobj.vbl_1+dur1);
    Screen('FillRect', sobj.wPtr, sobj.bgcol);
    [sobj.vbl2_3, sobj.OnsetTime2_3, sobj.FlipTimeStamp2_3] = Screen('Flip', sobj.wPtr, sobj.vbl_1+dur2);
elseif dur1 > dur2
    Screen('DrawTexture', sobj.wPtr, Stim1);
    [sobj.vbl2_3, sobj.OnsetTime2_3, sobj.FlipTimeStamp2_3] = Screen('Flip', sobj.wPtr, sobj.vbl_1+dur2);
    Screen('FillRect', sobj.wPtr, sobj.bgcol);
    [sobj.vbl_3, sobj.OnsetTime_3, sobj.FlipTimeStamp_3] = Screen('Flip', sobj.wPtr, sobj.vbl_1+dur1);
end
%sobj.sFlipTimeStamp_3 = toc(recobj.STARTloop);
Screen(Stim1, 'Close');
Screen(Stim2, 'Close');
Screen(Stim3, 'Close');
stim_monitor_reset;

