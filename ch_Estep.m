function ch_Estep

global figUIobj
global recobj

recobj.stepCV(1,1) = re_write(figUIobj.Cstart);
recobj.stepCV(1,2) = re_write(figUIobj.Cend);
recobj.stepCV(1,3) = re_write(figUIobj.Cstep);

recobj.stepCV(2,1) = re_write(figUIobj.Vstart);
recobj.stepCV(2,2) = re_write(figUIobj.Vend);
recobj.stepCV(2,3) = re_write(figUIobj.Vstep);

recobj.stepAmp = recobj.stepCV(recobj.plot,1):recobj.stepCV(recobj.plot,3):recobj.stepCV(recobj.plot,2);


check_AOrange;
daqsetting