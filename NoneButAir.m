%%%%%%%%%%%%%%%%%%%%%
%%%%%     None But Air     %%%%%%
%%%%%%%%%%%%%%%%%%%%%
% visual stimlus controller and recording elechtrical data

clear;
close all;
sca;
%% Reset DAQ
daq.reset
%%
global sobj
global recobj
global figUIobj
global floop

%% parameter setting
floop=1;
parameter_set;

%% cycle number counter set 0
recobj.cycleNum = 0 - recobj.prestim; %loop cycle number

%% open Window PTB %%
[sobj.wPtr, sobj.RECT] = Screen('OpenWindow', sobj.ScrNum,sobj.bgcol);
[sobj.ScrCenterX, sobj.ScrCenterY]= RectCenter(sobj.RECT);% center positionof of stim monitor
sobj.m_int = Screen('GetFlipInterval', sobj.wPtr);
sobj.frameRate = Screen('FrameRate',sobj.ScrNum);
if sobj.frameRate ==0
    sobj.frameRate = 75;
end
sobj.duration = sobj.flipNum*sobj.m_int;% sec

%Screen('CloseAll');
figUIobj.f1 = figure('Position',[10, 20, 1000, 750], 'Name','None But Air','Menubar','none');
gui_window3; %loop ÇÕ Ç±ÇÃíÜÇ≈éQè∆ÇµÇƒÇÈ main_looping

check_duration2;