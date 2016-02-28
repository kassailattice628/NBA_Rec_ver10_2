function y = trigger_rec2(i)
global sTrig2
global recobj
global sobj

if i == 0 %Trigger OFf
    dtrig = 0;
elseif i == 1 % Trigger ON
    dtrig = 1;
end

if sobj.ScrNum ~= 0
    outputSingleScan(sTrig2, dtrig);
end
y = toc(recobj.STARTloop);