function Pos_cord = position_polar2(i,dir)
%sobj.zoom_dist と sobj.

%center: 極座標の中心[x, y]
%dir: 角度パラメタsobh.shiftdir（1:8, 9=Ord8, 10=Rand8, 11=Rand16);
%dist: distance form the center_stim, degree

global sobj
global recobj

%%%%% center of zooming space %%%%%%
%[left, top, right, bottom]
%stimulus
x1 = sobj.pos(1,sobj.Y(i))-sobj.stimsz(1)/2;
y1 = sobj.pos(2,sobj.X(i))-sobj.stimsz(2)/2;
x2 = sobj.pos(1,sobj.Y(i))+sobj.stimsz(1)/2;
y2 = sobj.pos(2,sobj.X(i))+sobj.stimsz(2)/2;
%とりあえず中心はここにしとくか
sobj.position_cord = [x1,y1,x2,y2];


%%%%% 2nd or zooming pos stim %%%%%%
switch sobj.pattern
    case {'Zoom','2stim'}
        %list1 = sobj.zoom_mat1;
        list8 = sobj.zoom_mat8;
        list16 = sobj.zoom_mat16;
    case 'BW'
        %list1 = sobj.BW_mat1;
        list8 = sobj.BW_mat8;
        list16 = sobj.BW_mat16;
end

if dir == 9 %order8
    list = list8;
    %reset randmize
    i_list = RandCycle2(recobj.cycleNum,length(list));%なかで sobj.list_order を作っている
    sobj.list_order = 1:size(list,2);
else % dir ~= 9
    if dir == 10
        list = list8;
    elseif dir == 11
        list = list16;
    elseif dir < 9 %dir = fixed angle
        list = list8;
    end
    %reset randmize
    i_list = RandCycle2(recobj.cycleNum,length(list));
end

%%%%%%%%%% distance from center
i_dist = list(1,sobj.list_order(i_list));
if i_dist== 0
    sobj.zoom_dist = 0;
else
    sobj.zoom_dist = sobj.zoom_dist_deg(i_dist);
end

%%%%%%%%%% anlge
i_ang = list(2,sobj.list_order(i_list));
if dir < 9 %angle 固定 または 8の場合
    i_ang = dir;
    angle_list = sobj.angle_deg;
elseif dir == 11
    angle_list = sobj.angle16_deg;
else
    angle_list = sobj.angle_deg;
end

if i_ang == 0
    sobj.zoom_ang = 0;
else
    sobj.zoom_ang = angle_list(i_ang);
end

%%%%%%%%%% white or black %%%%%%%%%%%%%%
%% Fine mapping のときは B/W の刺激を Gray background でだす．%%
if strcmp(sobj.pattern,'BW')
    i_col = list(3,sobj.list_order(i_list));%randomize した order の 1 or 2 を output
    if i_col == 1
        sobj.stimlumi = 255;
        sobj.stimcol = 255;
    elseif i_col == 2
        sobj.stimlumi = 0;
        sobj.stimcol = 0;
    end
end

%角度 radian に直す
if sobj.zoom_dist  == 0 %刺激が zoom の中心の時（dist=0) は 2nd と 1st の中心は同じ
    Pos_cord = sobj.position_cord;
else
    theta = ( i_ang-1)*pi/4; %angle
    sobj.dist_pix = Deg2Pix(sobj.zoom_dist, 300); % マウスの目の 300 mm 前にdisplay
    [X, Y] = pol2cart(theta,sobj.dist_pix);
    %中心補正(monitor の left top が[0,0]右方向，下方向なので，X方向は+, Y方向は-）
    X = sobj.pos(1,sobj.Y(1))+X;
    Y = sobj.pos(2,sobj.X(1))-Y;
    sobj.stim2_center = [X,Y];
    %%%
    switch sobj.pattern
        case {'2stim'}
            sx_half = sobj.stimsz2(1)/2;
            sy_half = sobj.stimsz2(2)/2;
        case {'BW','Zoom'}
            sx_half = sobj.stimsz(1)/2;
            sy_half = sobj.stimsz(2)/2;
    end
    Pos_cord = round([X- sx_half, Y-sy_half, X+sx_half, Y+sy_half]);
end
