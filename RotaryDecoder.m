%function RotaryDecoder
global sRot

daq.reset
dev = daq.getDevices;
sRot = daq.createSession(dev.Vendor.ID);
%Counter channel の 生成
RotCh = addCounterInputChannel(sRot, dev.ID, 'ctr0', 'Position');
RotCh.EncoderType='X4'; %デコーディング方式 X1, X2, X4 が選べるが X4 が一番感度が高くなるので
addAnalogInputChannel(sRot, dev.ID, 3, 'Voltage');% AI0:2 は Vm, Im, Photo, AI3 をエンコーダに
sRot.Rate = 500;% s とは別に sampling rate を設定できるのか？
sRot.DurationInSeconds = recobj.rect/1000; %ms

%Counter は　Trigger 使えない
% P0.0 is Trigger source, PFI0 is Trigger Destination.これで同時に記録できる？
%addTriggerConnection(sRot,'External',[dev.ID,'/PFI0'],'StartTrigger');
%sRot.Connections(1).TriggerCondition = 'RisingEdge';

%% record
[positionData, timestamps] = startForeground(sRot);

% decode plot
signedThreshold = 2^(32-1);
signedData = positionData(:,1);
signedData(signedData > signedThreshold) = signedData(signedData > signedThreshold) - 2^32;

positionDataDeg = signedData * 360/1000/4;

figure; plot(timestamps, positionDataDeg);
xlabel('Time(s)');
ylabel('Anagular position (deg)');

