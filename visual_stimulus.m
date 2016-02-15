function visual_stimulus

global sobj
global recobj
global figUIobj

fmode = get(figUIobj.mode,'value');

% Position 決めるための i
if recobj.cycleNum <= 0 %prestimulus
    i = 1;
    sobj.position = 0;
elseif fmode == 1 || fmode == 3%Randome or Ordered
    i = rem(recobj.cycleNum, sobj.divnum^2);
    if i == 0
        i = sobj.divnum^2;
    end
elseif fmode == 2 %Fixed position
    i = 1;
end

% Luminance Random のとき変更する決める
if get(figUIobj.lumi,'value') == 2 %Random
    Random_luminance;
    sobj.stimlumi = sobj.stimlumi_rand;
end
check_stimRGB
%%%% stim %%%%%
if recobj.cycleNum > 0 %stim_on
    if i == 1 % reset, random position
        ch_position;
    end
    sobj.position = sobj.poslist(i);
    switch sobj.pattern
        case 'Uni' %サイズ一定, Lumi. Rand の時は Ruminance 変化
            Uni_stim2(i, sobj.stimcol);
            disp('Uni');
        case 'BW' % 灰色背景に，白または黒刺激（ランダム）
            Uni_stim_zoom(i,sobj.stimcol);
            disp('Fine Maping');
            disp(['Lumi:', num2str(sobj.stimcol)]);
        case {'Sin','Rect','Gabor'}
            Grating_shader(i);
        case {'Sz_r'}
            Random_size;
            Uni_stim2(i, sobj.stimcol);
            disp('Szr');
        case {'Zoom'}
            Uni_stim_zoom(i, sobj.stimcol)
            disp('Zoom');
        case {'2stim'}
            Two_stim_lag3(i, sobj.stimcol, sobj.stimcol2, sobj.delayPTB, sobj.delayPTB2)
            disp('2stim');
        case {'Images'}
            Test_RandImgs(i);
            disp('RandImages');
    end
else %prestimulus
    Uni_stim2(i, sobj.bgcol); %blank は Uni_stim で背景色をだすようにしよう
    sobj.vbl2_2 = sobj.vbl_1;
    sobj.vbl2_3 = sobj.vbl_1;
end
