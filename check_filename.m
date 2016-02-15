function check_filename
global recobj
    if isfield(recobj,'fname')==0 || recobj.fname == 0
         SelectSaveFile;
    end