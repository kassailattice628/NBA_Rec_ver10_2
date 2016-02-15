function pulseset

global figUIobj

fpulse = get(figUIobj.pulse,'value');
if fpulse==0
    set(figUIobj.pulse,'string','Pulse OFF','BackGroundColor',[0.701961 0.701961 0.701961]);
elseif fpulse == 1;
    set(figUIobj.pulse,'string','Pulse ON','BackGroundColor','g')
end

daqsetting;
