function check_AOrange
global figUIobj
global recobj

i = get(figUIobj.DAQrange,'value');
Ranges = [10, 1, 0.2, 0.1];
%NI DAQ は± 10 V まで．DAQ range の設定により Ranges(i) が 出せる出力 (V) の最大値

switch get(figUIobj.stepf,'value')
    case 0%step なし
        if recobj.pulseAmp * recobj.gain(recobj.plot) > Ranges(i)
            errordlg('pulseAmp exceeds DAQ range!!');
            recobj.pulseAmp = 0.1;
            set(figUIobj.pulseAmp, 'string','0.1');
        end
        
    case 1%step
        if recobj.stepCV(recobj.plot,1) * recobj.gain(recobj.plot) < -Ranges(i) || recobj.stepCV(recobj.plot,2) * recobj.gain(recobj.plot) > Range(i)
            errordlg('pulseAmp exxeds DAQ range!!');
            recobj.stepCV = [0,0.5,0.1;0,100,10];
            recobj.stepAmp = recobj.stepCV(recobj.plot,1):recobj.stepCV(recobj.plot,3):recobj.stepCV(recobj.plot,2);
            
            set(figUIobj.Cstart,'string',recobj.stepCV(1,1));
            set(figUIobj.Cend,'string',recobj.stepCV(1,2));
            set(figUIobj.Cstep,'string',recobj.stepCV(1,3));
            
            set(figUIobj.Vstart,'string',recobj.stepCV(2,1));
            set(figUIobj.Vend,'string',recobj.stepCV(2,2));
            set(figUIobj.Vstep,'string',recobj.stepCV(2,3));
        end
end

