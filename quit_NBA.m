function quit_NBA
global sobj
global s
global sTrig

delete(s)
delete(sTrig)
daq.reset;

if sobj.ScrNum ~= 0
    Screen('Close', sobj.wPtr);
end

%clear
close all;