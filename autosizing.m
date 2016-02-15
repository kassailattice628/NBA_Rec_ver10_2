function autosizing(dist)
%Auto-On の時に，刺激サイズを 分割した画面サイズにあわせる
global sobj
global figUIobj

if get(figUIobj.auto_size, 'value')==1
    set(figUIobj.auto_size,'string','Auto FILL');
    Rx = floor((sobj.ScreenSize(1)/sobj.divnum));
    Ry = floor((sobj.ScreenSize(2)/sobj.divnum));
    sobj.stimsz = [Rx,Ry];
    szdeg = round(Pix2Deg([sobj.stimsz], dist));
    set(figUIobj.size,'string',[num2str(szdeg(1)), ' x ', num2str(szdeg(2))]);
    
elseif get(figUIobj.auto_size,'value')==0
    set(figUIobj.auto_size,'string','Auto OFF');
    sobj.stimsz = round(ones(1,2)*Deg2Pix(str2double(get(figUIobj.size,'string')), dist));
end
