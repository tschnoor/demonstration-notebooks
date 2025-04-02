function [vfmts, vhts, vbw, hall, zall, f] = calc_areafmts_bw_piri(areas,lgths,Nareas,Nfmts,Ap,Lp,N_piri);
%l = 0.396825;
tot_fmts=[];
tot_hts=[];
fmts = zeros(1,4);
hts = fmts;
N = size(areas);
flag = 0;
l = lgths;
for i = 1:N(1)  
    
    
    af = areas(i,1:Nareas);
    af(af<=0) = .00001;
    %lv = l(i)*ones(1,Nareas);
    %lv = l*ones(1,Nareas);
    
    NL = size(lgths);
    if(NL(1) == 1 || NL(2) == 1)
        lv = lgths(i)*ones(Nareas,1);
    else
        lv = lgths(i,1:Nareas);
    end
    
    [h,z,f,D,h_alt,Zrad] = VokalTraktM_piri(af,lv,50,8500,Ap,Lp,N_piri);
   
    hall(i,:) = 20*log10(abs(h))';
    zall(i,:) = z;
    
    [fmts, hts,index, BW] = formant_bw_id( hall(i,:),f,Nfmts);
    
    
    
    for kk =1:length(fmts)
        tot_fmts(i,kk) = fmts(kk);
        tot_hts(i,kk) = hts(kk);
        tot_bw(i,kk) = BW(kk);
    end;
    flag = flag + 1;
    if(flag == 10)
        i
        flag = 0;
    end;
    
    
end;

%disp('TiltSpec turned on!!')

vfmts = round(tot_fmts);
vfmts = tot_fmts;
vhts = tot_hts;
vbw = tot_bw;
% ------------------------------------------------

