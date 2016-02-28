function Grating_shader(i)
global sobj
global recobj
global figUIobj
% ProceduralGaborDemo in "PsychDemos" was modified.
%{
 ProceduralGaborDemo([benchmark=0][, nonsymmetric=0])
 By default - if the optional 'nonsymmetric' flag is not provided or set
 to zero - only symmetric circular gabors are drawn. If the flag is set to
 1 then gabors with an aspect ratio ~= 1, ie., elliptical gabors, are
 drawn as well. Restricting drawing to symmetric gabors allows for an
 additional speedup in drawing (about 15% on a MacBookPro 2nd generation),
 so this may be interesting if you are in "need for speed(TM)".
 At a default setting of benchmark==0, it just shows nicely drawn gabor.
%}

% Make sure this is running on OpenGL Psychtoolbox:
AssertOpenGL;

%stim position
%[left, top, right, bottom]準備
x1 = sobj.pos(1,sobj.Y(i))-sobj.stimsz(1)/2;
y1 = sobj.pos(2,sobj.X(i))-sobj.stimsz(2)/2;
x2 = sobj.pos(1,sobj.Y(i))+sobj.stimsz(1)/2;
y2 = sobj.pos(2,sobj.X(i))+sobj.stimsz(2)/2;
sobj.position_cord = [x1,y1,x2,y2];
%%
%%%%%%%%%% Initial stimulus params for the gabor patch %%%%%%%%%%
% Temporal Grating Frequency %
sobj.shiftSpd = round(sobj.frameRate/sobj.shiftSpd2);%端数は丸め

phase = 0; %%%%%動画の時はここかえる必要あり→while loop の中 phase の定義を参照%%%%
% Spatial Frequency
freq = sobj.gratFreq2/Deg2Pix(1,sobj.MonitorDist);
% Size %
res= sobj.stimsz; % GUI では deg, 中で pixel に変換
% Patch size of Gabor
sc = res(1)*0.15;% (1-exp(-1)); % Stim Size にあわせて動くようにしておく 0.15はだいたい
contrast = 100.0;

%background offset は 0.5 あげるとageruto 0-255 (中央 127) no sine wave がつくられる．
color_offset = 0.5 * ones(1,3);

%%
switch sobj.pattern
    case {'Sin','Rect'}
        color_stim = (sobj.stimcol + 1) /(255 + 1); % 255 で割っとくとうまくいく +1　は割り算用
    case 'Gabor'
        color_stim =[];
end

tex_id = make_grating_texture(color_offset);

% sRect, tecture から切り出し
center = zeros(1,2);
[center(1),center(2)] = RectCenter(sobj.RECT); % window の中心
%[,sourceRect]
sRect = round([center(1) - res(1)/2, center(2) - res(2)/2, center(1) + res(1)/2, center(2) + res(2)/2]);

%%
% Grating Direction Angle: sobj.angle
if sobj.shiftDir < 9 % direction angle 決める
    list= sobj.angle_deg;
    sobj.angle = list(sobj.shiftDir);
elseif sobj.shiftDir >= 9;
    switch sobj.shiftDir
        case 9 %Order8
            list= sobj.angle_deg;
            sobj.list_order = 1:8;
            i_list = rem(recobj.cycleNum,8);
            if i_list ==0
                i_list = 8;
            end
        case 10 %Rand8
            list= sobj.angle_deg;
            i_list = RandCycle2(recobj.cycleNum,length(list));%なかで sobj.list_order を作っている
        case 11 %Rand16
            list = sobj.angle16_deg;
            i_list = RandCycle2(recobj.cycleNum,length(list));
    end
    sobj.angle = list(sobj.list_order(i_list));
end

%%
% offscreen に 1枚目準備
switch sobj.pattern
    case {'Sin','Rect'}
        ang = 180 - sobj.angle;
    case 'Gabor' % Gabor のときは，SineWave, SquareWave のときは角度の定義のまわりかたが反対だったので
        ang = 180 + sobj.angle;
end
draw_tex(tex_id, sRect, ang, color_stim, phase, freq, sc, contrast);
%%
%photo sensor 用
Screen('FillRect', sobj.wPtr, 255, [0 0 40 40]);
trigger_AIFV;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if recobj.delayTTL2/1000 <= sobj.delayPTB + sobj.duration %TTL ON is before Visual Stimlu OFF
    
    
    if recobj.delayTTL2/1000 <= sobj.delayPTB %TTL2 の後 stim
        while toc(recobj.STARTloop) - recobj.RecStartTimeToc <= recobj.delayTTL2/1000;%wait TTL2 delay (include delay TTL2 == 0)
        end
        if get(figUIobj.TTL2, 'value') ==0 % for Laser
            recobj.tTTL2 = trigger_rec2(1) -  recobj.RecStartTimeToc;
        else
            recobj.tTTL2 = 0;
        end
        % onscreen に １枚目提示してタイマースタート
        [sobj.vbl_2, sobj.OnsetTime_2, sobj.FlipTimeStamp_2] = Screen(sobj.wPtr, 'Flip', sobj.vbl_1+sobj.delayPTB);% put some delay for PTB
        sobj.sFlipTimeStamp_2=toc(recobj.STARTloop);
        outputSingleScan(sTrig,[0,0,1]);% DO for visual stimulus start
        stim_monitor;
    elseif recobj.delayTTL2/1000 > sobj.delayPTB %grating の途中で TTL2出せない気がする．．
        disp('ERROR!!');
        recobj.delayTTL2 = 0;
        sobj.delayPTB = 0;
        %{
        %刺激中にTTL2出すならこんなかんじのをしたに書く？
        if toc(recobj.STARTloop) - recobj.RecStartTimeToc <= recobj.delayTTL2/1000;%wait TTL2 delay (include delay TTL2 == 0)
            if get(figUIobj.TTL2, 'value') == 0
                recobj.tTTL2 = trigger_rec2(1) -  recobj.RecStartTimeToc;%TTL2 ON
            else %FV trigger のときは TTL2 特に叩かなくてよい
                recobj.tTTL2 = 0;
            end
        end
        %}
    end
    
    % 刺激時間は，sobj.flipNumで定義しているので
    for count = 1:sobj.flipNum
        phase = count/sobj.shiftSpd*360;
        draw_tex(tex_id,sRect,ang, color_stim, phase, freq, sc, contrast);
        Screen('FillRect', sobj.wPtr, 255, [0 0 40 40]);
        Screen('Flip', sobj.wPtr);
    end
    
    disp(['AITrig; ', sobj.pattern, ': #', num2str(recobj.cycleNum)]);
    %stim_OFF
    Screen('FillRect', sobj.wPtr, sobj.bgcol);
    [sobj.vbl_3, sobj.OnsetTime_3, sobj.FlipTimeStamp_3] = Screen(sobj.wPtr, 'Flip', sobj.vbl_2+sobj.duration);
    outputSingleScan(sTrig,[0,0,0]);% DO resrt (stim off)
    outputSingleScan(sTrig2,0); % TTL2 OFF
    sobj.sFlipTimeStamp_3=toc(recobj.STARTloop);
    stim_monitor_reset;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
elseif recobj.delayTTL2/1000 > sobj.delayPTB + sobj.duration %TTL ON is after Visual Stimlu OFF
    %Stim_ON
    % onscreen に １枚目提示してタイマースタート
    [sobj.vbl_2, sobj.OnsetTime_2, sobj.FlipTimeStamp_2] = Screen(sobj.wPtr, 'Flip', sobj.vbl_1+sobj.delayPTB);% put some delay for PTB
    sobj.sFlipTimeStamp_2=toc(recobj.STARTloop);
    outputSingleScan(sTrig,[0,0,1]);% DO for visual stimulus start
    stim_monitor;
    % 刺激時間は，sobj.flipNumで定義しているので
    for count = 1:sobj.flipNum
        phase = count/sobj.shiftSpd*360;
        draw_tex(tex_id,sRect,ang, color_stim, phase, freq, sc, contrast);
        Screen('FillRect', sobj.wPtr, 255, [0 0 40 40]);
        Screen('Flip', sobj.wPtr);
    end
    
    disp(['AITrig; ', sobj.pattern, ': #', num2str(recobj.cycleNum)]);
    
    %stim_OFF
    Screen('FillRect', sobj.wPtr, sobj.bgcol);
    [sobj.vbl_3, sobj.OnsetTime_3, sobj.FlipTimeStamp_3] = Screen(sobj.wPtr, 'Flip', sobj.vbl_2+sobj.duration);
    outputSingleScan(sTrig,[0,0,0]);% DO resrt (stim off)
    outputSingleScan(sTrig2,0); % TTL2 OFF
    sobj.sFlipTimeStamp_3=toc(recobj.STARTloop);
    stim_monitor_reset;
    
    %TTL2_ON
    while toc(recobj.STARTloop) - recobj.RecStartTimeToc <= recobj.delayTTL2/1000;%wait TTL2 delay (include delay TTL2 == 0)
    end
    if get(figUIobj.TTL2, 'value') == 0
        recobj.tTTL2 = trigger_rec2(1) -  recobj.RecStartTimeToc;%TTL2 ON
    else %FV trigger のときは TTL2 特に叩かなくてよい
        recobj.tTTL2 = 0;
    end
    
    %when complex TTL pattern will be used, the code will be here.
    %No TTL2 OFF is  rec OFF timing
end