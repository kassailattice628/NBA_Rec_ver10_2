function positionDataDeg = RotOn
global sRot

positionData = startForeground(sRot);

% read counter data
signedThreshold = 2^(32-1);
signedData = positionData(:,1);
signedData(signedData > signedThreshold) = signedData(signedData > signedThreshold) - 2^32;

% contert counter data into angular position of the rotary disc
positionDataDeg = signedData * 360/1000/4;