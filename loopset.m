function loopset

global figUIobj

floop = get(figUIobj.loop,'value');
fstim = get(figUIobj.stim,'value');
if floop == 0;
    set(figUIobj.ui1,'string','Loop-Out','BackGroundColor','r')
elseif floop == 1;
    set(figUIobj.ui1,'string','Looping','BackGroundColor','g')
    if fstim == 1;
        %loop_rec_stim;
        visual_stimulus;
    elseif fstim == 0
        trigger_rec_stim;
    end
end

