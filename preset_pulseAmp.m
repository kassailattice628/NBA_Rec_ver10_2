function preset_pulseAmp
global figUIobj
global recobj

switch get(figUIobj.presetAmp,'value')
    case 1
    set(figUIobj.presetAmp,'string', '10 mV')
    set(figUIobj.pulseAmp, 'string', '10')
    recobj.pulseAmp = 10;check_AOrange;daqsetting;

    case  0
    set(figUIobj.presetAmp,'string', '1 mV')
    set(figUIobj.pulseAmp, 'string', '1')
    recobj.pulseAmp = 1;check_AOrange;daqsetting;
end
