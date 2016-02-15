%function RotaryDecoder
global sRot

[positionData, timestamps] = startForeground(sRot);

%%
signedThreshold = 2^(32-1);
signedData = positionData(:,1);
signedData(signedData > signedThreshold) = signedData(signedData > signedThreshold) - 2^32;

positionDataDeg = signedData * 360/1000/4;

figure; plot(timestamps, positionDataDeg);
xlabel('Time(s)');
ylabel('Anagular position (deg)');

