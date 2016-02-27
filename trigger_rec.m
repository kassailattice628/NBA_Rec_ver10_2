function y = trigger_rec(i)
global sTrig
global recobj
global sobj

if i == 1;
    dtrig = [1,0,0,0];%AI only
elseif i == 2
    dtrig = [0,1,0,0];%TTL only
elseif i == 3
    dtrig = [1,1,0,0];%AI and TTL
end

if sobj.ScrNum ~= 0
    outputSingleScan(sTrig, dtrig);
end
y = toc(recobj.STARTloop);