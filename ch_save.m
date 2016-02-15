function ch_save
global figUIobj
global recobj


if get(figUIobj.save,'value')==1
    set(figUIobj.save,'string','Save','BackGroundColor','g','Horizontalalignment','center');
    if isfield(recobj,'fname')==1 && ischar(recobj.fname)
    else
         SelectSaveFile;
    end
else
    set(figUIobj.save,'string','Unsave', 'BackGroundColor','w','Horizontalalignment','center')

    if recobj.fopenflag == 1
    fclose(recobj.fid);
    %fclose(recobj.fid2);
    recobj.fopenflag = 0;
    end

end
