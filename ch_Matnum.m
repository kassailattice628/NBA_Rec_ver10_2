function ch_Matnum(varargin)
global sobj
varnum = length(varargin);
for i = 1:varnum
    handles = varargin{i};
    set(handles, 'string',['(<= ' num2str(sobj.divnum) ' x ' num2str(sobj.divnum) ' Matrix)']);
end
