function stimset

global figUIobj

fstim = get(figUIobj.stim,'value');
if fstim==0
    set(figUIobj.stim,'string','Stim OFF','BackGroundColor',[0.701961 0.701961 0.701961]);
elseif fstim == 1;
    set(figUIobj.stim,'string','Stim ON','BackGroundColor','y')
end