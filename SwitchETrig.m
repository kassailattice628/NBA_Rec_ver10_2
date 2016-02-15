function SwitchETrig

global figUIobj
global recobj

recobj.EOf = get(figUIobj.EOf,'value');

if recobj.EOf == 0
    set(figUIobj.EOf,'BackGroundColor',[0.701961 0.701961 0.701961]);
else
    set(figUIobj.EOf,'BackGroundColor','g');
end

