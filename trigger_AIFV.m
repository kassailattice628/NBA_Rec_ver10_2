function trigger_AIFV
global dio
global recobj
global sobj
global figUIobj

switch recobj.EOf
    case 0
        %%%%%% get FV time of recording start timing%%%%%%%
        Screen('FillRect', sobj.wPtr, sobj.bgcol);
        %%%%%% absolute timer start %%%%%%
        [sobj.vbl_1,sobj.OnsetTime_1, sobj.FlipTimeStamp_1] = Screen(sobj.wPtr, 'Flip');
        
        if recobj.cycleNum == - recobj.prestim+1
            recobj.STARTloop= tic;
            startTrig
        else
            if sobj.ScrNum~=0
                outputSingleScan(dio.TrigAI,1)% start AI
                recobj.tRec = toc(recobj.STARTloop);
            end
        end
        
        recobj.RecStartTimeToc = toc(recobj.STARTloop);%start timing counter
        
        if recobj.cycleNum == - recobj.prestim+1
            recobj.RecStartTime = sobj.vbl_1;
            recobj.sRecStartTime = recobj.RecStartTimeToc;
        end
        
    case 1
        if recobj.cycleNum == - recobj.prestim+1
            recobj.STARTloop= tic;
            startTrig;
        else
            outputSingleScan(dio.TrigAI,1)% start AI
        end
        recobj.RecStartTimeToc = toc(recobj.STARTloop);%start timing counter
        recobj.RecStartTime = 0;
        recobj.sRecStartTime = recobj.RecStartTimeToc;
        
end
%% nested function
    function startTrig
        outputSingleScan(dio.TrigAI,1)% start AI
        outputSingleScan(dio.TrigFV,1)% start FV
        if get(figUIobj.RotCtr,'value') == 1
                figUIobj.yRot = RotOn;
        end
    end
end
