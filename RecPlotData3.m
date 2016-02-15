function RecPlotData3(src,event)

global figUIobj
global recobj
global sobj

%recobj.dataall = [event.Data]*1000; %mV
recobj.dataall(:,1) = event.Data(:,1)*100; %(mV), Axoclamp2B からの出力は 10*Vm なので *1000(mV)/10(gain)
recobj.dataall(:,2) = event.Data(:,2)*10; %(nA), V->I への変換必要 10 /(*0.1) mV/nA = 100 mV/nA: 1V で 10 nA
recobj.dataall(:,3) = event.Data(:,3)*1000; %(mV), phot sensor の出力は V なので mV に変換

%%
set(figUIobj.s2,'title',text('string', ['V-DATA', '  # = ', num2str(recobj.cycleNum)]));
figUIobj.y2 = recobj.dataall(:,recobj.plot);
figUIobj.y3 = recobj.dataall(:,3);
figUIobj.t = event.TimeStamps;

refreshdata(figUIobj.p2)
refreshdata(figUIobj.p3)

%%
%plot PTB timing
fstim = get(figUIobj.stim,'value');
if  fstim == 1
    set(figUIobj.flash2,'xdata',[sobj.tPTBon, sobj.tPTBon],'ydata',[min(recobj.dataall(:,recobj.plot)),max(recobj.dataall(:,recobj.plot))]);
    set(figUIobj.flash3, 'xdata',[0,0], 'ydata',[recobj.dataall(1, recobj.plot), recobj.dataall(1, recobj.plot)]);
    if strcmp(sobj.pattern, '2stim') == 1
        set(figUIobj.flash3, 'xdata',[sobj.tPTBon2, sobj.tPTBon2], 'ydata',[min(recobj.dataall(:,recobj.plot)),max(recobj.dataall(:,recobj.plot))]);
    end
elseif fstim == 0
    set(figUIobj.flash2,'xdata',[0,0],'ydata',[recobj.dataall(1, recobj.plot), recobj.dataall(1, recobj.plot)]);
    set(figUIobj.flash3,'xdata',[0,0],'ydata',[recobj.dataall(1, recobj.plot), recobj.dataall(1, recobj.plot)]);
end
refreshdata(figUIobj.flash2)
refreshdata(figUIobj.flash3)