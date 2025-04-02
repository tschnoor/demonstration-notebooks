function q = CreateNew_q(N,nc);
%N =number of time samples (Fs = 146)
%nc = number of cons constriction

q.x02r = 0.07;
q.x02l = 0.07;
q.xibr = 0.01;
q.xibl = 0.01;
q.npr = 0.85;
q.npl = 0.85;
q.aepi = 0.5;
q.lepi = 0;
q.pgap = 0;
q.asym = 0;
q.phi0R = 0;
q.phi0L = 0;
q.areaflag = 'null--';
q.areas = [];
q.mod_m=[];
q.td = N*0.006866;
q.PL = 8000;
q.F0contour = 1;
q.FMext = 0;
q.FMfreq = 5;
q.AMext = 0;
q.AMfreq = 5;
q.AdductModExt = 0;
q.AdductModFreq = 5;
q.HzpercmH20 = 0;
q.AudFileName= '';
q.vow1=7;
q.vow2=7;
q.dxnew= 0.3968;
q.fotarg= 100;
q.dL=[];
q.dT=[];
q.vox= [];
q.fo= [];
q.stat =[];
q.nqf = [];
q.areas = [];
q.Lo = 1.5;
q.To = 0.3;



for n=1:nc
    q.mc(:,n) = zeros(N,1);
    q.lc(:,n) = ones(N,1);
    q.ac(:,n) = zeros(N,1);
    q.rc(:,n) = ones(N,1);
    q.sc(:,n) = ones(N,1);
end

    q.gc = zeros(N,1);
    q.pc = zeros(N,1);
    q.np = zeros(N,1);


