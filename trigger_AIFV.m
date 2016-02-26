function trigger_AIFV
global sTrig
global recobj
global sobj

switch recobj.EOf
    case 0
        %%%%%% get FV time of recording start timing%%%%%%%
        Screen('FillRect', sobj.wPtr, sobj.bgcol);
        %%%%%% absolute timer start %%%%%%
        [sobj.vbl_1,sobj.OnsetTime_1, sobj.FlipTimeStamp_1] = Screen(sobj.wPtr, 'Flip');
        
        if recobj.cycleNum == - recobj.prestim+1
            recobj.STARTloop= tic;
            outputSingleScan(sTrig,[1,1,0,0]);% FV10 and AI start
        else
            if sobj.ScrNum~=0
                recobj.tRec = trigger_rec(1);
                outputSingleScan(sTrig,[1,0]);% FV10 and AI start
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
            outputSingleScan(sTrig,[1,1]);% FV10 and AI start
        else
            outputSingleScan(sTrig,[1,0]);% FV10 and AI start
        end
        recobj.RecStartTimeToc = toc(recobj.STARTloop);%start timing counter
        recobj.RecStartTime = 0;
        recobj.sRecStartTime = recobj.RecStartTimeToc;
end