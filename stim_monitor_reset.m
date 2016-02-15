function stim_monitor_reset

global figUIobj

%set(figUIobj.StimMonitor1, 'string', '', 'BackGroundColor','w')
set(figUIobj.StimMonitor1, 'BackGroundColor', 'w');
%set(figUIobj.StimMonitor2, 'string', 'OFF','BackGroundColor', 'w')
set(figUIobj.StimMonitor2, 'BackGroundColor', 'w');
%set(figUIobj.StimMonitor3, 'string', '', 'BackGroundColor','w')
set(figUIobj.StimMonitor3, 'BackGroundColor', 'w');
drawnow;