function RotarySet
global sRot
global figUIobj
global recobj

switch get(figUIobj.RotCtr,'value')
    case 0% OFF
        set(figUIobj.RotCtr,'string','Rotary OFF','BackGroundColor',[0.701961 0.701961 0.701961]);
    case 1% ON
        set(figUIobj.RotCtr,'string','Rotary ON','BackGroundColor','g');
        sRot.DurationInSeconds = recobj.rect/1000; %ms     
end
