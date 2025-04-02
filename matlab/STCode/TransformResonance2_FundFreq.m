function fonew = TransformResonance2_FundFreq(F,tm)

fs_res = 146;
fs_fo = 2000;

tmn = [0:1/fs_fo:tm(end)];

fonew = interp1(tm,F,tmn,'pchip');

