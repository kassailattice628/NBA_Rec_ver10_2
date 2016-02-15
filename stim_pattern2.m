function stim_pattern2
global sobj
global figUIobj
%{'Uni'},{'BW'},{'Sin'},{'Rect'},{'Gabor'},{'Sz_r'},{'Zoom'},{'2Stim'}
switch get(figUIobj.pattern, 'value');
    case 1%'Uni'
        sobj.pattern = 'Uni';
        set(figUIobj.shiftDir,'BackGroundColor','k');
        set(figUIobj.shiftSpd,'BackGroundColor','k');
        set(figUIobj.gratFreq,'BackGroundColor','k');
        set(figUIobj.dist,'BackGroundColor','k');
        set(figUIobj.div_zoom,'BackGroundColor','k');
        set(figUIobj.ImageNum,'BackGroundColor','k');
        
        set(figUIobj.shape2,'BackGroundColor','k');
        set(figUIobj.stimlumi2,'BackGroundColor','k');
        set(figUIobj.flipNum2,'BackGroundColor','k');
        set(figUIobj.delayPTBflip2,'BackGroundColor','k');
        set(figUIobj.size2,'BackGroundColor','k');
        sobj.stimlumi = re_write(figUIobj.stimlumi);
        sobj.bgcol = re_write(figUIobj.bgcol);check_lumi2
        sobj.angle = 0;
        ch_position
    case 2%'BW'
        sobj.pattern = 'BW';
        sobj.bgcol = 127;
        set(figUIobj.shiftDir, 'BackGroundColor','g');
        set(figUIobj.shiftSpd,'BackGroundColor','k');
        set(figUIobj.gratFreq,'BackGroundColor','k');
        set(figUIobj.dist,'BackGroundColor','g');
        set(figUIobj.div_zoom,'BackGroundColor','g');
        set(figUIobj.mode,'value',2);
        set(figUIobj.stimRGB,'value',1);
        check_stimRGB;
        set(figUIobj.ImageNum,'BackGroundColor','k');
        sobj.angle = 0;
        set(figUIobj.shape2,'BackGroundColor','k');
        set(figUIobj.stimlumi2,'BackGroundColor','k');
        set(figUIobj.flipNum2,'BackGroundColor','k');
        set(figUIobj.delayPTBflip2,'BackGroundColor','k');
        set(figUIobj.size2,'BackGroundColor','k');
        ch_position
    case {3,4,5} %'Sin', 'Rect', 'Gabor'
        set(figUIobj.shiftDir,'BackGroundColor','g');
        set(figUIobj.shiftSpd,'BackGroundColor','g');
        set(figUIobj.gratFreq,'BackGroundColor','g');
        set(figUIobj.dist,'BackGroundColor','k');
        set(figUIobj.shape,'value',1);
        sobj.shape = sobj.shapelist{get(figUIobj.shape,'value'),1};
        set(figUIobj.div_zoom,'BackGroundColor','k');
        set(figUIobj.ImageNum,'BackGroundColor','k');
        
        set(figUIobj.shape2,'BackGroundColor','k');
        set(figUIobj.stimlumi2,'BackGroundColor','k');
        set(figUIobj.flipNum2,'BackGroundColor','k');
        set(figUIobj.delayPTBflip2,'BackGroundColor','k');
        set(figUIobj.size2,'BackGroundColor','k');
        sobj.stimlumi = re_write(figUIobj.stimlumi);
        sobj.bgcol = re_write(figUIobj.bgcol);check_lumi2
        if get(figUIobj.pattern, 'value') == 3
            sobj.pattern = 'Sin';
        elseif get(figUIobj.pattern, 'value') == 4
            sobj.pattern = 'Rect';
        elseif get(figUIobj.pattern, 'value') == 5
            sobj.pattern = 'Gabor';
            sobj.bgcol = 127;check_lumi2
        end
        ch_position
    case 6 %'Sz_r'
        sobj.pattern = 'Sz_r';
        set(figUIobj.shiftDir,'BackGroundColor','k');
        set(figUIobj.shiftSpd,'BackGroundColor','k');
        set(figUIobj.gratFreq,'BackGroundColor','k');
        set(figUIobj.dist,'BackGroundColor','k');
        set(figUIobj.div_zoom,'BackGroundColor','k');
        set(figUIobj.mode,'value',2);
        set(figUIobj.ImageNum,'BackGroundColor','k');
        
        set(figUIobj.shape2,'BackGroundColor','k');
        set(figUIobj.stimlumi2,'BackGroundColor','k');
        set(figUIobj.flipNum2,'BackGroundColor','k');
        set(figUIobj.delayPTBflip2,'BackGroundColor','k');
        set(figUIobj.size2,'BackGroundColor','k');
        sobj.stimlumi = re_write(figUIobj.stimlumi);
        sobj.bgcol = re_write(figUIobj.bgcol);check_lumi2
        ch_position
        sobj.angle = 0;
    case 7 %'Zoom'
        sobj.pattern = 'Zoom';
        set(figUIobj.shiftDir, 'BackGroundColor','g');
        set(figUIobj.shiftSpd,'BackGroundColor','k');
        set(figUIobj.gratFreq,'BackGroundColor','k');
        set(figUIobj.dist,'BackGroundColor','g');
        set(figUIobj.div_zoom,'BackGroundColor','g');
        set(figUIobj.mode,'value',2);
        set(figUIobj.ImageNum,'BackGroundColor','k');
        
        set(figUIobj.shape2,'BackGroundColor','k');
        set(figUIobj.stimlumi2,'BackGroundColor','k');
        set(figUIobj.flipNum2,'BackGroundColor','k');
        set(figUIobj.delayPTBflip2,'BackGroundColor','k');
        set(figUIobj.size2,'BackGroundColor','k');
        sobj.stimlumi = re_write(figUIobj.stimlumi);
        sobj.bgcol = re_write(figUIobj.bgcol);check_lumi2
        ch_position;
        sobj.angle = 0;
        
    case 8 %'2stim'
        sobj.pattern = '2stim';
        set(figUIobj.shiftDir, 'BackGroundColor','g');
        set(figUIobj.shiftSpd,'BackGroundColor','k');
        set(figUIobj.gratFreq,'BackGroundColor','k');
        set(figUIobj.dist,'BackGroundColor','g');
        set(figUIobj.div_zoom,'BackGroundColor','g');
        set(figUIobj.mode,'value',2);
        set(figUIobj.ImageNum,'BackGroundColor','k');
        
        set(figUIobj.shape2,'BackGroundColor','g');
        set(figUIobj.stimlumi2,'BackGroundColor','g');
        set(figUIobj.flipNum2,'BackGroundColor','g');
        set(figUIobj.delayPTBflip2,'BackGroundColor','g');
        set(figUIobj.size2,'BackGroundColor','g');
        sobj.stimlumi = re_write(figUIobj.stimlumi);
        sobj.bgcol = re_write(figUIobj.bgcol);check_lumi2
        ch_position;
        sobj.angle = 0;
        
    case 9 % 'Image presentation'
        sobj.pattern = 'Images';
        set(figUIobj.shiftDir, 'BackGroundColor','k');
        set(figUIobj.shiftSpd,'BackGroundColor','k');
        set(figUIobj.gratFreq,'BackGroundColor','k');
        set(figUIobj.dist,'BackGroundColor','k');
        set(figUIobj.div_zoom,'BackGroundColor','k');
        set(figUIobj.mode,'value',2);%Fixed position
        set(figUIobj.ImageNum,'BackGroundColor','g');
        
        set(figUIobj.shape2,'BackGroundColor','k');
        set(figUIobj.stimlumi2,'BackGroundColor','k');
        set(figUIobj.flipNum2,'BackGroundColor','k');
        set(figUIobj.delayPTBflip2,'BackGroundColor','k');
        set(figUIobj.size2,'BackGroundColor','k');
        
        sobj.stimlumi = re_write(figUIobj.stimlumi);
        sobj.bgcol = re_write(figUIobj.bgcol);check_lumi2
        ch_position;
end