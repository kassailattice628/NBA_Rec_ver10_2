function ch_plot
global recobj
global figUIobj

switch recobj.plot
    case 1%V-plot
        set(figUIobj.plot,'string','V-plot','BackgroundColor','B');
        %plot
        set(get(figUIobj.s2, 'Title'), 'string','V-DATA');
        set(get(figUIobj.s2, 'Ylabel'), 'string','mV');
        set(figUIobj.p2, 'Color','b');
        %C-pulse
        set(figUIobj.ampunit,'string','nA');
        
    case 2%C-plot
        set(figUIobj.plot,'string','I-plot','BackgroundColor','R');
        %plot
        set(get(figUIobj.s2, 'Title'), 'string','I-DATA');
        set(get(figUIobj.s2, 'Ylabel'), 'string','nA');
        set(figUIobj.p2, 'Color','r');
        %V-pulse
        set(figUIobj.ampunit,'string','mV');
        
end

%軸の更新も必要か
switch recobj.yaxis
    case 0
        set(figUIobj.yaxis,'string','Auto')
        set(figUIobj.s2,'YlimMode','Auto');
        set(figUIobj.VYmax,'BackGroundColor','w')
        set(figUIobj.VYmin,'BackGroundColor','w')
        set(figUIobj.CYmax,'BackGroundColor','w')
        set(figUIobj.CYmin,'BackGroundColor','w')
    case 1
        set(figUIobj.yaxis,'string','Fix')
        set(figUIobj.s2,'YlimMode','Manual');
        set(figUIobj.s2,'Ylim',[recobj.yrange(recobj.plot*2-1),recobj.yrange(recobj.plot*2)]);
        switch recobj.plot
            case 1
                set(figUIobj.VYmax,'BackGroundColor','g')
                set(figUIobj.VYmin,'BackGroundColor','g')
                set(figUIobj.CYmax,'BackGroundColor','w')
                set(figUIobj.CYmin,'BackGroundColor','w')
            case 2
                set(figUIobj.VYmax,'BackGroundColor','w')
                set(figUIobj.VYmin,'BackGroundColor','w')
                set(figUIobj.CYmax,'BackGroundColor','g')
                set(figUIobj.CYmin,'BackGroundColor','g')
        end
end

%%
%recobj.rectaxis = (0:recobj.sampt/1000:(recobj.recp-1)/recobj.sampf*1000)';%time axis (ms)
recobj.rectaxis = (0:recobj.recp-1)';
figUIobj.t = recobj.rectaxis/recobj.rect;

recobj.dataall = zeros(recobj.recp,3);%AI channel ３つ分
figUIobj.y2 = recobj.dataall(:,recobj.plot);

figUIobj.y3 = recobj.dataall(:,3);
%
%refreshdata(figUIobj.s2)
refreshdata(figUIobj.p2)
%refreshdata(figUIobj.s3)
refreshdata(figUIobj.p3)
drawnow;
%}
steppulse;
