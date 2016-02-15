function RecPlotData(src,event)
global figUIobj
global recobj

recobj.dataall(:,1) = event.Data(:,1)*100; %(mV), Axoclamp2B からの出力は 10*Vm なので *1000(mV)/10(gain)
recobj.dataall(:,2) = event.Data(:,2)*1000; %(pA), I -> V の変換必要
recobj.dataall(:,3) = event.Data(:,3)*1000; %(mV), phot sensor の出力はそのまま．

%ai0 or ai1 の プロット
%%
subplot(figUIobj.s2);
if recobj.plot == 1%plot V data
    %figUIobj.p2 = plot(event.TimeStamps, event.Data(:,1),'b-');
elseif recobj.plot ==2%plot I data
    figUIobj.p2 = plot(event.TimeStamps, event.Data(:,2),'r-');
end
set(gca,'title',text('string', ['V-DATA', '  # = ', num2str(recobj.cycleNum)]));
%set(figUIobj.s2,'YLim', [-0.1,0.3]);

%%
%ai channel 3 のプロット（photo sensor)
subplot(figUIobj.s3);
figUIobj.p3 = plot(event.TimeStamps, event.Data(:,3));
%set(figUIobj.s3,'YLim', [-0.1,0.3]);
