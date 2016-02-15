function amari = RandCycle2(cyclenum,n_cycle)
%サイクル数を割り算して，余を出力．amari == 1 のときに，ランダマイズ
%cyclenum: 現在のサイクル数
%n_cycle: サイクル一周分の数
%ランダム化したベクトルを sobj.list_order に入れる

global sobj
amari = rem(cyclenum, n_cycle);

if amari == 1% randomize
    %1 cycle 分はランダムベクトルを保存
    sobj.list_order = randperm(n_cycle);
end
if amari == 0;
    amari = n_cycle;
end