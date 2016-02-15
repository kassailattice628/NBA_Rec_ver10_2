%match_stim2cond

%Stim.Shape2
set(figUIobj.shape2,'value', get(figUIobj.shape,'value'));
sobj.shape2 = sobj.shapelist{get(figUIobj.shape2,'value'),1};

%Stim.Lumi2
set(figUIobj.stimlumi2,'string',get(figUIobj.stimlumi,'string'));
sobj.stimlumi2 = re_write(figUIobj.stimlumi2);
check_lumi2;

%Stim.Duration2
set(figUIobj.flipNum2,'string',get(figUIobj.flipNum,'string'));
sobj.flipNum2 = re_write(figUIobj.flipNum2);


%PTB delay2
set(figUIobj.delayPTBflip2,'string', get(figUIobj.delayPTBflip,'string'));
sobj.delayPTBflip2 = re_write(figUIobj.delayPTBflip2);

sobj.delayPTB2 = sobj.delayPTBflip2*sobj.m_int; 

check_duration2;

%Stim.Size2
set(figUIobj.size2,'string', get(figUIobj.size,'string'));
sobj.stimsz2 = sobj.stimsz;
