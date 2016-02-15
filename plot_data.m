function plot_data

global figUIobj
global recobj
global sobj

%ai channel 1 or 2 のプロット（V or I);
subplot(figUIobj.s2);
set(figUIobj.p2, 'Ydata', recobj.dataall(:,recobj.plot));
set(gca,'title',text('string', ['V-DATA', '  # = ', num2str(recobj.cycleNum)]));
set(figUIobj.s2,'XLim', [0, recobj.rect]);

if recobj.yaxis == 1
    Vmin = min(recobj.dataall(:,recobj.plot));
    Vmax = max(recobj.dataall(:,recobj.plot));
elseif recobj.yaxis == 2
    Vmin = -90;
    Vmax = 50;
end

if recobj.plot == 1%plot V data
    set(figUIobj.p2, 'Color', 'b', 'Ydata', recobj.dataall(:,recobj.plot));
elseif recobj.plot ==2%plot I data
    set(figUIobj.p2, 'Color', 'r', 'Ydata', recobj.dataall(:,recobj.plot));%<-  gain の変換を入れたい
end
set(figUIobj.s2,'YLim', [Vmin Vmax]);

%plot PTB timing
fstim = get(figUIobj.stim,'value');
if  fstim == 1
    set(figUIobj.flash2,'xdata',[sobj.tPTBon, sobj.tPTBon]*1000,'ydata',[Vmin Vmax]);
    set(figUIobj.flash3, 'xdata',[0,0], 'ydata',[min(recobj.dataall(:, recobj.plot)), min(recobj.dataall(:, recobj.plot))]);
    if strcmp(sobj.pattern, '2stim') == 1
        set(figUIobj.flash3, 'xdata',[sobj.tPTBon2, sobj.tPTBon2]*1000, 'ydata',[Vmin, Vmax]);
    end
elseif fstim == 0
    set(figUIobj.flash2,'xdata',[0 0],'ydata',[min(recobj.dataall(:,recobj.plot)),min(recobj.dataall(:,recobj.plot))]);
    set(figUIobj.flash3,'xdata',[0,0],'ydata',[min(recobj.dataall(:,recobj.plot)),min(recobj.dataall(:,recobj.plot))]);
end

%ai channel 3 のプロット（photo sensor)
set(figUIobj.p3, 'Ydata', recobj.dataall(:,3));
set(figUIobj.s3,'XLim', [0, recobj.rect]);
set(figUIobj.s3,'YLim', [min(recobj.dataall(:,3)), max(recobj.dataall(:,3))]);

drawnow;
