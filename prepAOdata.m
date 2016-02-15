function prepAOdata

global figUIobj
global s
global recobj

%step pulse ÇÃÅ@Ç∆Ç´ÇÕÅ@loop Ç≥ÇπÇÈ
if get(figUIobj.stepf,'value') == 1
    OutData = zeros(recobj.recp,2);%[AO0; AO1];
    OutData(round(recobj.pulseDelay*s.Rate)+1:round((recobj.pulseDelay+recobj.pulseDuration)*s.Rate)+1, recobj.plot) = 1;
    
    size(OutData)
    i = rem(recobj.cycleNum+1,length(recobj.stepAmp))+1;
    recobj.pulseAmp = recobj.stepAmp(i);
    recobj.OutData = OutData * recobj.stepAmp(i)*recobj.gain(recobj.plot);
end
%%%%%
if s.ScansQueued == 0
queueOutputData(s,recobj.OutData);
end
