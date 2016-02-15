function steppulse

global figUIobj
global recobj

stepf = get(figUIobj.stepf,'value');

if stepf==0
    set(figUIobj.stepf,'BackGroundColor',[0.701961 0.701961 0.701961]);
    set(figUIobj.Vstart,'BackGroundColor','w')
    set(figUIobj.Vend,'BackGroundColor','w')
    set(figUIobj.Vstep,'BackGroundColor','w')
    set(figUIobj.Cstart,'BackGroundColor','w')
    set(figUIobj.Cend,'BackGroundColor','w')
    set(figUIobj.Cstep,'BackGroundColor','w')
    
elseif stepf == 1;
    set(figUIobj.stepf,'BackGroundColor','g');
    switch recobj.plot
        case 1
            set(figUIobj.Vstart,'BackGroundColor','w')
            set(figUIobj.Vend,'BackGroundColor','w')
            set(figUIobj.Vstep,'BackGroundColor','w')
            set(figUIobj.Cstart,'BackGroundColor','g')
            set(figUIobj.Cend,'BackGroundColor','g')
            set(figUIobj.Cstep,'BackGroundColor','g')
        case 2
            set(figUIobj.Vstart,'BackGroundColor','g')
            set(figUIobj.Vend,'BackGroundColor','g')
            set(figUIobj.Vstep,'BackGroundColor','g')
            set(figUIobj.Cstart,'BackGroundColor','w')
            set(figUIobj.Cend,'BackGroundColor','w')
            set(figUIobj.Cstep,'BackGroundColor','w')
    end
end

ch_Estep;