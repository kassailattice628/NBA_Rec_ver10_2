function ch_TTL2
global figUIobj
global recobj

if get(figUIobj.TTL2,'value') == 1
    set(figUIobj.TTL2,'string', 'FV trig')
    set(figUIobj.delayTTL2,'string',0);
    recobj.delayTTL2 = 0;
elseif get(figUIobj.TTL2, 'value') == 0
    set(figUIobj.TTL2,'string', 'TTL2(Laser)')
end
