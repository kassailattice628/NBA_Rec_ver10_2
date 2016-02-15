function randompos(varargin)
%Random Mode の時，divnum にあった刺激場所を randomizeして 1 loop 分の場所ベクトル作成
global sobj
global figUIobj

if get(figUIobj.mode,'value')==1
    if isempty(varargin)
    else
        handles = varargin{1};
        set(handles,'BackGroundColor','w');
    end
    %stim_midpoint = [0:sobj.ScreenSize(3)/(sobj.divnum+1):sobj.ScreenSize(3);0:sobj.ScreenSize(4)/(sobj.divnum+1):sobj.ScreenSize(4)];%分割した X,Y の中央点
    %stim_midpoint = floor(stim_midpoint(:,2:end-1));
    sizeX = sobj.ScreenSize(1)/sobj.divnum;
    sizeY = sobj.ScreenSize(2)/sobj.divnum;
    sobj.pos = floor([sizeX/2:sizeX:(sobj.ScreenSize(1)-sizeX/2);sizeY/2:sizeY:(sobj.ScreenSize(2)-sizeY/2)]);
    %randamize
    stimset=1:sobj.divnum^2;
    stimset = reshape(stimset,sobj.divnum,sobj.divnum);
    stimset_rand = randperm(sobj.divnum^2);
    stimset_x = zeros(1,sobj.divnum^2);
    stimset_y = stimset_x;
    for m = 1:length(stimset_rand)
        [stimset_x(m),stimset_y(m)] = find(stimset == stimset_rand(m));
    end
    sobj.X = stimset_x;
    sobj.Y = stimset_y;
end
