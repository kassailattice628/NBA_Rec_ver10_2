function ch_DaqRange
global figUIobj
global InCh

i = get(figUIobj.DAQrange,'value');

Ranges = [-10,10;-1,1;-0.2,0.2;-0.1,0.1];
InCh(1).Range = Ranges(i,:);
InCh(2).Range = Ranges(i,:);
InCh(3).Range = [-10 10];

end