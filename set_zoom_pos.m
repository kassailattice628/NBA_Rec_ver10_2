function [y1,y2] = set_zoom_pos(mat)

 [y1,y2] = RandCycle(recobj.cycleNum, length(mat),mat);
 
 %
 
 [sobj.zoom_dist, i_rand] = RandCycle(recobj.cycleNum, length(mat),mat(2,:));
 [i_angle, i_rand] = RandCycle(recobj.cycleNum, length(mat), mat(1,:));
 sobj.zoom_angle=sobj.angle_deg(i_angle);
 