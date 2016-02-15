function Random_size
global sobj
global recobj

sobj.size_list = [0.5, 1, 3, 5, 10]; % degree
k = rem(recobj.cycleNum,length(sobj.size_list));
if k == 0
    k = length(sobj.size_list);
elseif k == 1
    sobj.i_size = randperm(length(sobj.size_list));
end
l = sobj.size_list(sobj.i_size(k));
sobj.stimsz = round(ones(1,2)*Deg2Pix(l, sobj.MonitorDist));
