function AcqBindData(src,event)

global figUIobj
global recobj
global sobj

%100 ms ���Ƃ� data acquisition �ł���H
%recobj.dataall = [event.Data]*1000; %mV
recobj.dataall = zeors(recobj.recp, 3);
n = round(recobj.rect/100);
n2 = round(recobj.recp/n);

dataall = zeros(n2,3);
for i = 1:n
    dataall(:,1) = event.Data(:,1)*100; %(mV), Axoclamp2B ����̏o�͂� 10*Vm �Ȃ̂� *1000(mV)/10(gain)
    dataall(:,2) = event.Data(:,2)*10; %(nA), V->I �ւ̕ϊ��K�v 10 /(*0.1) mV/nA = 100 mV/nA: 1V �� 10 nA
    dataall(:,3) = event.Data(:,3)*1000; %(mV), phot sensor �̏o�͂� V �Ȃ̂� mV �ɕϊ�
    recobj.dataall(n2,:) = dataall;
end
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