function savedata

global recobj
global sobj
global save_data
global figUIobj
global Eheader
global PTBheader


% Headerは予備もふくめて50個確保
% 49個以上使いきったら， SelectOpen.m のheader 確保を増やす
HEADER = zeros(50,1);

Eheader = [recobj.rect;recobj.sampt;recobj.plot;recobj.cycleNum];%1 ~ 4
HEADER(1:4,1) = Eheader;

PTBheader = [get(figUIobj.stim,'value');sobj.stimsz'; sobj.divnum; sobj.position;get(figUIobj.shape,'value');get(figUIobj.pattern,'value'); sobj.duration; sobj.stimlumi; sobj.bgcol];%5~14
HEADER(5:14,1) = PTBheader;

Delayheader = [recobj.tTTL2; sobj.tPTBon; sobj.tPTBoff; recobj.tRec];%15~18
HEADER(15:18,1) = Delayheader;

Gratheader =[sobj.shiftDir; sobj.angle; sobj.gratFreq2; sobj.shiftSpd2];%19 ~ 22
HEADER(19:22,1) = Gratheader;

HEADER(23:26,1) = sobj.position_cord';

HEADER(27,1) = get(figUIobj.savech,'value');

%BW, Zoom の時は刺激の中心．2stim の時は，2nd stim の中心
HEADER(28:29,1) = sobj.stim2_center';

switch sobj.pattern
    case {'Uni','Sin','Rect','Gabor','Sz_r'}
        HEADER(30,1) = 0;
        HEADER(31,1) = 0;
        HEADER(40,1) = 0; %presented image num
    case {'BW','Zoom','2stim'}
        HEADER(30,1) = sobj.zoom_dist;
        HEADER(31,1) = sobj.zoom_ang;
        HEADER(40,1) = 0;
    case 'Images'
        HEADER(40,1) = sobj.img_i; %presented image num
end

HEADER(32,1) = get(figUIobj.shape2,'value');
HEADER(33,1) = sobj.stimlumi2;
HEADER(34:35,1) = [sobj.tPTBon2; sobj.tPTBoff2];
HEADER(36:37,1) = sobj.stimsz2';
HEADER(38,1) = sobj.MonitorDist; %distance from an eye to the dispaly.
HEADER(39,1) = get(figUIobj.stimRGB,'value');
%HEADER(40,1)　は Image #上で設定

%%%%%%
%AO pulse info
HEADER(41,1) = recobj.pulseDuration;%pulse duration (ms)
HEADER(42,1) = recobj.pulseDelay;%pulse delay (ms)
HEADER(43,1) = recobj.pulseAmp;%step start (nA or mV)

%%%%%%
% NBA version
HEADER(50,1) = recobj.NBAver;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     save data 作成
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
savetype = get(figUIobj.savech,'value');
if savetype ==1%save header& Elech & Photo data
    %save_data = [HEADER;recobj.dataall(:,recobj.plot);recobj.dataall(:,3)];
    save_data = [HEADER;recobj.dataall(:,1);recobj.dataall(:,2);recobj.dataall(:,3)];% V-I + photo 保存(stim pulse も確認できる）
elseif savetype ==2%save header only
    HEADER(2) = 0;
    save_data = HEADER;
elseif savetype ==3%save header and Photo
    save_data = [HEADER;recobj.dataall(:,3)];
end

if get(figUIobj.save,'value') == 1
    if recobj.cycleNum ==  1- recobj.prestim
        recobj.fopenflag = 1;
        recobj.fid = fopen([recobj.dirname,recobj.fname], 'a'); % Open or Create file(fname) as an 'append' mode.
        fwrite(recobj.fid,save_data,'single');
    else
        fwrite(recobj.fid,save_data,'single');
    end
end
