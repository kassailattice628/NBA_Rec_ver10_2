function RotarySet
global sRot
global figUIobj
global recobj

switch get(figUIobj.RotCtr,'value')
    case 0% OFF
        set(figUIobj.RotCtr,'string','Rotary OFF','BackGroundColor',[0.701961 0.701961 0.701961])
        if ishandle(figUIobj.f2)
            close(figUIobj.f2)
        end
    case 1% ON
        set(figUIobj.RotCtr,'string','Rotary ON','BackGroundColor','g');
        sRot.DurationInSeconds = recobj.rect/1000; %ms
        if isfield(figUIobj,'f2')
            if ishandle(figUIobj.f2)==1
                figure(figUIobj.f2)
            else
                FigRot
            end
        else
            FigRot
        end
end
    function FigRot
        figUIobj.f2 = figure('Position',[400, 500, 500, 200], 'Name','RotoryEncoder','Menubar','none');
        figUIobj.yRot = zeros(sRot.Rate*sRot.DurationInSeconds,1);
        figUIobj.tRot = 0:1/sRot.Rate:sRot.DurationInSeconds-1/sRot.Rate;
        figUIobj.pRot = plot(figUIobj.tRot,figUIobj.yRot, 'XdataSource','figUIobj.tRot','YDataSource','figUIobj.yRot');
        title('Rotary Encoder');
        xlabel('Time (s)');
        ylabel('Anagle pos.(deg)');
    end
end


