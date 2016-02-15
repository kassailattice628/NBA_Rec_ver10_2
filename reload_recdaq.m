function reload_recdaq
global recobj


recobj.sampt = round(10^6/recobj.sampf);
daqsetting;

ch_plot;




