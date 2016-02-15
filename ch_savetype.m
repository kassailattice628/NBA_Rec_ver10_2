function ch_savetype
global figUIobj

if get(figUIobj.savech,'value')==1
    set(figUIobj.savech,'string','header Ony');
elseif get(figUIobj.savech,'value')==0
    set(figUIobj.savech,'string','header&data');
end
