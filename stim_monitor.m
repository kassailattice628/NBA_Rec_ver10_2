function stim_monitor
global figUIobj
global sobj
global recobj

if recobj.cycleNum <= 0
    set(figUIobj.StimMonitor3,'string','', 'BackGroundColor','black');
    set(figUIobj.StimMonitor2,'string','Pre Stim','ForegroundColor','white','BackGroundColor','black');
    set(figUIobj.StimMonitor1,'string','', 'BackGroundColor','black');
    drawnow;
else
    switch sobj.pattern
        case 'Uni'
            bgcol = 'm';
            stim_str3 = '';
        case 'BW'
            bgcol = 'y';
            stim_str3 = [num2str(sobj.zoom_dist), 'deg, ', num2str(sobj.zoom_ang), 'deg'];
        case 'Sin'
            bgcol = 'c';
            stim_str3 = ['Dir: ', num2str(sobj.angle), ' deg'];
        case 'Rect'
            bgcol = 'c';
            stim_str3 = ['Dir: ', num2str(sobj.angle), ' deg'];
        case 'Gabor'
            bgcol = 'c';
            stim_str3 = ['Dir: ', num2str(sobj.angle), ' deg'];
        case 'Sz_r'
            bgcol = 'm';
            size = Pix2Deg(sobj.stimsz(1), sobj.MonitorDist);
            size = round(size*10)/10;%表示用に丸め（0.5deg があるので，小数点第２位で丸める
            stim_str3 = ['Sz: ', num2str(size),' deg'];
        case 'Zoom'
            bgcol = 'm';
            stim_str3 = [num2str(sobj.zoom_dist), 'deg, ', num2str(sobj.zoom_ang), 'deg'];
        case '2stim'
            bgcol = 'g';
            stim_str3 = [num2str(sobj.zoom_dist), 'deg, ', num2str(sobj.zoom_ang), 'deg'];
        case 'Images'
            bgcol = 'y';
            stim_str3 = ['Image #: ', num2str(sobj.img_i)];
    end
    
    set(figUIobj.StimMonitor3,'string',sobj.pattern, 'BackGroundColor',bgcol);
    set(figUIobj.StimMonitor2,'string',['POS: ',num2str(sobj.position),'/',num2str(sobj.divnum^2)],'ForegroundColor','black','BackGroundColor',bgcol);
    set(figUIobj.StimMonitor1,'string',stim_str3, 'BackGroundColor',bgcol);
    drawnow;
end