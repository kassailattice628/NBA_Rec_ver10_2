function Test_RandImgs(i)
%Imgs Folder 内の画像（256 種類）のうち sobj.ImageNum 個の画像（128*128）
%ランダムに提示する（画像の fixed pos に適当に傾かせて提示
global sobj
global recobj
global figUIobj
AssertOpenGL;

%Select Image
if recobj.cycleNum == 1 %はじめに使う画像セットを選ぶ
    sobj.list_img = randperm(256);
    sobj.set_list_img = zeros(2,sobj.ImageNum);
    sobj.set_list_img(1,:) = sobj.list_img(1:sobj.ImageNum);%使う画像前から順番に選んで，このリストをブロックごとにランダムして使おう
    a = sobj.ImageNum/8;
    amari = rem(sobj.ImageNum,8);
    dirlist = 0:45:315;
    sobj.set_list_img(2,:) = [repmat(dirlist,1,fix(a)), dirlist(1:amari)];
    %写真の画像は傾けない
    sobj.set_list_img(2,sobj.set_list_img(1,:) >= 241) = 0;
end
i_list = RandCycle2(recobj.cycleNum, sobj.ImageNum);

sobj.img_i = sobj.set_list_img(1,sobj.list_order(i_list));%使う画像の番号
%各画像について，適当に傾けて使う（文字は縦横の構造がおおいので，randamize したほうがいいかな
sobj.angle = sobj.set_list_img(2,sobj.list_order(i_list));

%画像ファイル名の取得
imgFolder = ['Imgs',filesep];
imgFileList = dir([imgFolder 'Im*.tif']);
imgFileName = char(imgFileList(sobj.img_i).name); % 画像のファイル名（フォルダ情報なし）
imgFileName2 = [imgFolder imgFileName];
%画像読み込み
imgdata = imread(imgFileName2, 'TIFF');
%テクスチャに
imgtex = Screen('MakeTexture',sobj.wPtr,imgdata);

%Position: [left, top, right, bottom]準備
x1 = sobj.pos(1,sobj.Y(i))-size(imgdata,1)/2;
y1 = sobj.pos(2,sobj.X(i))-size(imgdata,2)/2;
x2 = sobj.pos(1,sobj.Y(i))+size(imgdata,1)/2;
y2 = sobj.pos(2,sobj.X(i))+size(imgdata,2)/2;
sobj.position_cord = [x1,y1,x2,y2];

%%%%%%%%%%%%%%%%
%pause(0.001)%ないと trigger できない？（いらない）
%Rec start, Rec Time;
trigger_AIFV
%%%%%%%%%%%%%%%

%ここに画像出力↓↓
Screen('DrawTexture', sobj.wPtr, imgtex, [], sobj.position_cord,sobj.angle);%拡大および縮小はどうしようか？

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
    stim_monitor;
elseif recobj.delayTTL2/1000> sobj.delayPTB
    [sobj.vbl_2, sobj.OnsetTime_2, sobj.FlipTimeStamp_2] = Screen(sobj.wPtr, 'Flip', sobj.vbl_1+sobj.delayPTB);% put some delay for PTB
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
sobj.sFlipTimeStamp_3=toc(recobj.STARTloop);
stim_monitor_reset;