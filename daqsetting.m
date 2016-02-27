function daqsetting
% sampling freq
% recording time
% pulse Duration
% pulse Delay
% pulse Amp
% pulse stepAmp
% DAQ Range

global sTrig
global s
global recobj
global lh

outputSingleScan(sTrig,[0,0,0,0]); %reset trigger signals at Low

%% for AI/AO
s.Rate = recobj.sampf;
recobj.sampt = round(10^6/recobj.sampf);
recobj.recp = recobj.sampf*recobj.rect/1000;

s.DurationInSeconds = recobj.rect/1000;%sec %outputchannel Ç¢ÇÍÇÈÇ∆é©ìÆÇ≈s.scansqued/s.rate Ç…ê›íËÇ≥ÇÍÇÈÅD


%% AO
%{
OutData = zeros(recobj.recp,2);

fout = get(figUIobj.pulse,'value');
if fout == 1
    OutData(round(recobj.pulseDelay*s.Rate)+1:round((recobj.pulseDelay+recobj.pulseDuration)*s.Rate)+1, recobj.plot) = 1;
elseif fout == 0
    OutData = zeros(recobj.recp,2);
end
%}
%% step pulse ÇÃÅ@Ç∆Ç´ÇÕÅ@loop Ç≥ÇπÇÈ
%{
if get(figUIobj.stepf,'value') == 0 %step pulse off
    recobj.OutData = OutData * recobj.pulseAmp * recobj.gain(recobj.plot);
else %step pulse on
    recobj.OutData = OutData * recobj.stepAmp(1) * recobj.gain(recobj.plot);
end
if s.ScansQueued == 0
queueOutputData(s,recobj.OutData);
s.NotifyWhenDataAvailableExceeds = recobj.recp;
end
%}
s.NotifyWhenDataAvailableExceeds = recobj.recp;
%% generate event listener for Background recording

delete(lh)
lh = addlistener(s, 'DataAvailable', @RecPlotData2);

%}
%% for sRot
%sRot.DurationInSeconds = recobj.rect/sRot.Rate; % ç°ÇÃÇ∆Ç±ÇÎÇÕ sRot.Rate ÇÕ å≈íË