%function RotaryDecoder
global sRot

daq.reset
dev = daq.getDevices;
sRot = daq.createSession(dev.Vendor.ID);
%Counter channel �� ����
RotCh = addCounterInputChannel(sRot, dev.ID, 'ctr0', 'Position');
RotCh.EncoderType='X4'; %�f�R�[�f�B���O���� X1, X2, X4 ���I�ׂ邪 X4 ����Ԋ��x�������Ȃ�̂�
addAnalogInputChannel(sRot, dev.ID, 3, 'Voltage');% AI0:2 �� Vm, Im, Photo, AI3 ���G���R�[�_��
sRot.Rate = 500;% s �Ƃ͕ʂ� sampling rate ��ݒ�ł���̂��H
sRot.DurationInSeconds = recobj.rect/1000; %ms

%Counter �́@Trigger �g���Ȃ�
% P0.0 is Trigger source, PFI0 is Trigger Destination.����œ����ɋL�^�ł���H
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

