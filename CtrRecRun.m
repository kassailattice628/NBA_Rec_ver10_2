function CtrRecRun


global dev
global s
global sTrig
global recobj
global InCh
global figUIobj

stop(s)
outputSingleScan(sTrig,[0,0]); %reset trigger signals at Low
%%
s = daq.createSession(dev.Vendor.ID);
s.Rate = recobj.sampf;% sampling rate
s.DurationInSeconds = 10;%sec %outputchannel いれると なくなる．
s.NotifyWhenDataAvailableExceeds = recobj.recp;

%% AI
InCh = addAnalogInputChannel(s, dev.ID, 0:2, 'voltage');
InCh(1).TerminalConfig = 'SingleEnded';
InCh(2).TerminalConfig = 'SingleEnded';
InCh(3).TerminalConfig = 'Differential';%Photo Sensor
ch_DaqRange;

%% AO
addAnalogOutputChannel(s, dev.ID, 0,'Voltage');
%for rectangular pulse stimulation
OutData = zeros(s.Rate*recobj.rect/1000,1);
fout = get(figUIobj.pulse,'value');
if fout == 1
    OutData(round(recobj.pulseDelay*s.Rate)+1:round((recobj.pulseDelay+recobj.pulseDuration)*s.Rate)+1) = 1;
elseif fout == 0
    OutData = zeros(s.Rate*recobj.rect/1000,1);
end

%step pulse の　ときは　loop させる
if get(figUIobj.stepf,'value') == 0
    recobj.OutData = OutData * recobj.pulseAmp/1000;
else %step pulse
    i = rem(recobj.cycleNum+2,length(recobj.stepAmp))+1;
    recobj.OutData = OutData * recobj.stepAmp(i)/1000;
end

%% P0.0 is Trigger source, PFI0 is Trigger Destination.
%
addTriggerConnection(s,'External',[dev.ID,'/PFI0'],'StartTrigger');
s.Connections(1).TriggerCondition = 'RisingEdge';

%% ctr0 から カウンターパルスを作成
CtrCh = addCounterOutputChannel(s, dev.ID, 'ctr0','Pulsegeneration');
CtrCh.Frequency= 1/(recobj.rect/1000 + recobj.interval);
CtrCh.DutyCycle= 0.1;

%% listener
addlistener(s, 'DataAvailable', @RecPlotData);

%%
for i = 1:10
    disp(i)
    queueOutputData(s,recobj.OutData)
    
    startBackground(s);
    if i == 1
        outputSingleScan(sTrig,[1,0]); %reset trigger signals at Low
        outputSingleScan(sTrig,[0,0]); %reset trigger signals at Low
    end
    pause(recobj.rect/1000)
    
end

