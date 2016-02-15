function trigger_AIFVtest
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
            outputSingleScan(sTrig,[1,1]);% FV10 and AI start
            disp('go2')
        else
             outputSingleScan(sTrig,[1,1]);% FV10 and AI start
             %recobj.tRec = trigger_rec(1);
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
            disp('go')
        else
             outputSingleScan(sTrig,[1,1]);% FV10 and AI start
             %recobj.tRec = trigger_rec(1);
        end
        recobj.RecStartTimeToc = toc(recobj.STARTloop);%start timing counter
        recobj.RecStartTime = 0;
        recobj.sRecStartTime = recobj.RecStartTimeToc;
end