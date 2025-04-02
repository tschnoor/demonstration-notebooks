function Z = OratorVerbisComputisInertial(E);
%OratorVerbisComputis.m
%B. Story
%10.03.2018
%
%

N = E.N;
fsartic = 146;
omegaC = 80;
omegaV = 40;
omegaG = 60;
omegaR = 60;
omegaNas = 30;
omegaF0 = 15;

addpath ../../Advanced
%addpath ../../../Advanced %use for RDP_paper/Revision
%addpath ../../../../../../mri/vorperian/VocalTractGrowthModel2/VokalTrakt_SideBranch

if(isfield(E,'randF0') == 1)
    randF0 = E.randF0;
else
    randF0 = 0;
end

q = CreateNew_q(N,4);


if(isfield(E,'dxnew') == 1)
    q.dxnew = E.dxnew;
else
    q.dxnew = 0.396825;
    %q.dxnew = 0.42;
end

if(isfield(E,'piri') == 1)
    if(length(E.piri) == 1)
        q.piri = [E.piri 0.8000    0.7000    0.4000];
    else
        q.piri = E.piri;
    end
else
    q.piri = 0;
end


% q.fotarg = 135;
% q.Lo = 1.;
% q.To = .3;

% q.fotarg = 100;
% q.Lo = 1.1;
% q.To = .3;

% q.fotarg = 100;
% q.Lo = 1.35;
% q.To = .3;

% q.fotarg = 85;
% q.Lo = 1.1;
% q.To = .3;

%--This one used for RDP perc exp
% q.fotarg = 100;
% q.Lo = 1.4;
% q.To = .3;

% q.fotarg = 85;
% q.Lo = 1.4;
% q.To = .3;

q.fotarg = 85;
q.Lo = 1.6;
q.To = .3;

% q.fotarg = 85;
% q.Lo = 1.3;
% q.To = .3;

% q.fotarg = 80;
% q.Lo = 1.5;
% q.To = .3;

if(isfield(E,'fotarg') == 1)
    q.fotarg = E.fotarg;
end

%---Standard ----
% q.x02l = .065;
% q.x02r = .065;
q.x02l = .06;
q.x02r = .06;
q.npr = 0.9;
q.npl = 0.9;
q.xibr = 0.06;
q.xibl = 0.06;
q.pgap = 0.004;
q.PL = 8000;
%---Alternative 1 ----
% q.x02l = .06;
% q.x02r = .06;
% q.npr = 0.9;
% q.npl = 0.9;
% q.xibr = 0.07;
% q.xibl = 0.07;
% q.pgap = 0.005;
% q.PL = 8000;
%----Alternative 2----
% q.x02l = .02;
% q.x02r = .02;
% q.npr = 0.3;
% q.npl = 0.3;
% q.xibr = 0.1;
% q.xibl = 0.1;
% q.pgap = 0.00;
% q.PL = 8000;

%---Arizona  ----

q.x02l = .065;
q.x02r = .065;
q.npr = 0.9;
q.npl = 0.9;
q.xibr = 0.05;
q.xibl = 0.05;
q.pgap = 0.00;
q.PL = 8000;
q.Lo = 1.5;
q.To = .3;


if(E.stat.dx < 0.36 && E.stat.dx > 0.3 )
    
    q.x02l = .07;
    q.x02r = .07;
    q.npr = 0.75;
    q.npl = 0.75;
    q.xibr = 0.05;
    q.xibl = 0.05;
    q.pgap = 0.001;
    q.PL = 10000;
    q.Lo = 1.1;
    q.To = .3;
    
end

if(E.stat.dx <= 0.3)
    
    q.x02l = .06;
    q.x02r = .06;
    q.npr = 0.75;
    q.npl = 0.75;
    q.xibr = 0.05;
    q.xibl = 0.05;
    q.pgap = 0.002;
    q.PL = 14000;
    q.Lo = 0.6;
    q.To = .2;
    
end

    


%--standard values----
    %--used for all RDP perc samples--
q.FMext = 0.00;
q.jitterOVC = 0.00;
q.jitter = 0;

 %--used for all glottal animation samples--
% q.FMext = 0.00;
% q.jitterOVC = 0.00;
% q.jitter = 0;


%--rough voice values---
    %---adductor spasmodic dysphonia?---
% q.FMext = 0.05;
% q.jitter = 0.025;
% q.AdductModExt = .3;
% q.AdductModFreq = 5;
%-----------------------

%q.nzbw = [750 2500];
%q.nzbw = [300 1500];
%q.nzbw = [500 1500]; %used this for all RDP perc

q.nzbw = [500 2000];
q.nzbw2 = [1500 4000]; %fricative noise

if(isfield(E,'nzbw') == 1)
    q.nzbw = E.nzbw;
end

if(isfield(E,'nzbw2') == 1)
    q.nzbw2 = E.nzbw2;
end

if(isfield(E,'fotarg') == 1)
    q.fotarg = E.fotarg;
end

if(isfield(E,'Lo') == 1)
    q.Lo = E.Lo;
end

Fs = round(35000/(2*q.dxnew));
Nsim = q.td*Fs;


q.Ltract = 1;

%c = 2-cgauss([1:44],.3,44,20);
%E.stat.ne = E.stat.ne.*c(:);
%E.stat.ne = E.stat.ne*1.4;
% c = 2-cgauss([1:44],.2,1,10);
% E.stat.ne = E.stat.ne.*c(:);
%E.stat.dx = q.dxnew;

% c = 2-cgauss([1:44],.4,36,20);
% d = cgauss([1:44],.4,18,20);
% z = d.*c;
% E.stat.ne = E.stat.ne.*z(:);


% c = cgauss([1:44],.4,36,20);
% d = 2-cgauss([1:44],.4,18,20);
% z = d.*c;
% E.stat.ne = E.stat.ne.*z(:);

%===========GENERATE TIMING FUNCTIONS FOR ALL EVENTS=========================

%NOTE (06.28.18): New variable in structures called 'sti' means 'saturation
%index' and allows for sustaining a gesture over some amount of time -
%however, time is indicated by number of time samples like other parameters
%(hence the 'i' in the name).

%sti_flag = 1; %---this option puts Npk in the middle of sti; use 2 for beginning
sti_flag = 2; %---this option puts Npk in the middle of sti; use 2 for beginning

%-----Generate timing functions for consonants -----
for n=1:length(E.C)
    
    if(isfield(E.C(n),'sti') == 0 || isempty(E.C(n).sti) == 1)
        E.C(n).sti = 0;
    end
    
    if(E.C(n).rdp(4) > 0.93)
        Tc(:,n) = MovementTrajInertial3(N,E.C(n).tmi, E.C(n).gwi, 1, E.C(n).sti, omegaC, 1/fsartic);
    else
        Tc(:,n) = MovementTrajInertial3(N,E.C(n).tmi, E.C(n).gwi, 1, E.C(n).sti, omegaV, 1/fsartic);
    end
    
    P(:,n) = E.C(n).rdp(:);
    
    if(isfield(E.C(n),'cflag') == 1)
        cflag(n) = E.C(n).cflag;
    else
        cflag(n) = E.cflag;
    end 
    
end

%-----Generate timing functions for vowels -----
for n=1:length(E.V)
    
    if(isfield(E.V(n),'sti') == 0 || isempty(E.V(n).sti) == 1)
        E.V(n).sti = 0;
    end
    
    Tv(:,n) = MovementTrajInertial3(N,E.V(n).tmi, E.V(n).gwi, 1, E.V(n).sti, omegaV, 1/fsartic);
end

%-----Generate timing functions for adduction -----

for n=1:length(E.G)
    
    if(isfield(E.G(n),'sti') == 0 || isempty(E.G(n).sti) == 1)
        E.G(n).sti = 0;
    end
    Tg(:,n) = MovementTrajInertial3(N,E.G(n).tmi, E.G(n).gwi, 1, E.G(n).sti, omegaG, 1/fsartic);
    Tg(:,n) = Tg(:,n) * E.G(n).xi;
    
end

q.gc = sum(Tg,2);

%-----Generate timing functions for subglottal pressure -----
for n=1:length(E.R)
    
    if(isfield(E.R(n),'sti') == 0 || isempty(E.R(n).sti) == 1)
        E.R(n).sti = 0;
    end
   
    Tr(:,n) = MovementTrajInertial3(N,E.R(n).tmi, E.R(n).gwi, 1, E.R(n).sti,omegaR, 1/fsartic);
    Tr(:,n) = Tr(:,n) * E.R(n).sfPL;
    %Tr(:,n) = MovementTrajGaussianSkewHold(N,E.R(n).tmi,E.R(n).gwi,E.R(n).sfPL,E.R(n).skw,E.R(n).sti,sti_flag)';
end

if(isfield(E,'PSdir') == 1)
    if(E.PSdir < 0)
        q.pc = sum(Tr,2)*q.PL;
        q.pc(q.pc<-q.PL) = -q.PL;
        q.pc = smooth(q.pc,5);
    else
        q.pc = sum(Tr,2)*q.PL;
        q.pc(q.pc<-q.PL) = -q.PL;
        q.pc = smooth(q.pc,5) - q.PL;
    end
else
    q.pc = sum(Tr,2)*q.PL;
    q.pc(q.pc<-q.PL) = -q.PL;
    q.pc = smooth(q.pc,5);
end


%-----Generate timing functions for nasal coupling -----
for n=1:length(E.Nas)
    
    if(isfield(E.Nas(n),'sti') == 0 || isempty(E.Nas(n).sti) == 1)
        E.Nas(n).sti = 0;
    end
    
    Tn(:,n) = MovementTrajInertial3(N,E.Nas(n).tmi, E.Nas(n).gwi, 1, E.Nas(n).sti, omegaNas, 1/fsartic);
    Tn(:,n) = Tn(:,n)*E.Nas(n).arnas;
end

q.np = sum(Tn,2);

%-----Generate timing functions for fo -----
for n=1:length(E.fo)
    
    if(isfield(E.fo(n),'sti') == 0 || isempty(E.fo(n).sti) == 1)
        E.fo(n).sti = 0;
    end
   
    %Tf(:,n) = MovementTrajGaussianSkewHold(N,E.fo(n).tmi,E.fo(n).gwi,E.fo(n).sffo,E.fo(n).skw,E.fo(n).sti,sti_flag)';
    Tf(:,n) = MovementTrajInertial3(N,E.fo(n).tmi, E.fo(n).gwi, E.fo(n).sffo, E.fo(n).sti, omegaF0, 1/fsartic);
end

fo = sum(Tf,2);

fogc = 1-fo;
%fogc = fo;
fogc = fogc-min(fogc);
fogc = 0.02*fogc/max((fogc));


fo = fo + 1;
tmo = [0:0.006866:(length(fo)-1)*.006866];
tmn = [0:1/2000:tmo(end)+.006866];
F0 = interp1(tmo,fo,tmn,'spline'); %---resample to fs = 2000 Hz

q.fo = F0(:)*q.fotarg;

if(randF0 == 0)
    %---impose fo variation on fo contour-----
    fsfo = 2000;
    tm = [0:1/fsfo:(length(q.fo)-1)/fsfo];
    
    %     cn = dsp.ColoredNoise('Color','pink','SamplesPerFrame',length(q.fo));
    %     y = cn();
    
    y = pinknoise(length(q.fo));
    [b,a] = butter(2,20/(2000/2),'high');
    y = filtfilt(b,a,y);
    y = y/max(abs(y));
    s = 1+ q.FMext*sin(2*pi*5*tm(:)) + q.jitterOVC*y(:);
    q.fo = s(:).*q.fo(:);
else
    
    %----Random fo--------
    fsfo = 2000;
    [b,a] = butter(2,3/(fsfo/2));
    y = rednoise(length(q.fo));
    y = filtfilt(b,a,y);
    y = y/max(abs(y));
    q.fo = ((y(:)*.2+1).*q.fotarg);
    y = pinknoise(length(q.fo));
    [b,a] = butter(2,20/(2000/2),'high');
    y = filtfilt(b,a,y);
    y = q.fotarg*q.jitterOVC*y/max(abs(y));
    q.fo = q.fo+y(:);
end

%Modify the TV adduction based on fo change 
q.gc = fogc(:) +q.gc;

%-----Generate vowel substrate --------------------
%vareas = MakeVowelSubstrate_Tv(Tv,E.V,E.stat);
vareas = MakeVowelSubstrate_Tv_scaled(Tv,E.V,E.stat);
%Add epilaryngeal modulation as function of F0 here!!!
%vareas = ModulationEpiLarynx(vareas,1.5,8);
%--------------------------------------------------

%-----Generate area matrix-------------------------
%[areas, M, qnew] = SensitiveTalker(vareas,Tc,P(1:4,:),q.dxnew,q,cflag);
%[areas, M, qnew] = SensitiveTalker_Norm(vareas,Tc,P(1:4,:),q.dxnew,q,cflag);
%disp('using SensitiveTalker_Norm');
% [areas, M, qnew] = SensitiveTalker_Norm_SBranch(vareas,Tc,P(1:4,:),q.dxnew,q,cflag);
% disp('using SensitiveTalker_Norm_SBranch');
[areas, M, qnew] = SensitiveTalker_Norm_SBranch_AltCalc(vareas,Tc,P(1:4,:),q.dxnew,q,cflag);
disp('using SensitiveTalker_Norm_SBranch_AltCalc');
%--------------------------------------------------
%surf(areas(:,1:44)');

qnew.areas(:,45) = q.np(:);

save temp.mat qnew vareas Tc Tn Tg Tr

%=====Make act and ata=================
% Fs = round(35000/(2*q.dxnew));
% Nsim = q.td*Fs;
% tmfopk = 35;
% qnew.x02l = 0.01;
% qnew.x02r = 0.01;
% qnew.Lo = 1.8;
% qnew.act = MovementTrajCos([1 round(Fs*tmfopk/146) Nsim],[.1 .5 .05])';
% qnew.ata = MovementTrajCos([1 round(1.1*Fs*tmfopk/146) Nsim],[.1 .2 .05])';


%=============Run simulation=======================
q2 = qnew;
[aud2,ugn,t,r,tv,areas,lgths,fo,p,vareasX,Csim,tractindex] = BlackCat(q2);

[b,a] = butter(4,90/(44100/2),'high');
aud2f = filtfilt(b,a,aud2);

%[fmts] = calc_areafmts(areas(:,1:44),lgths,44,3);
Loc_piri = 6;
[fmts, hts, bw, wtrfall, zall, fx] = calc_areafmts_bw_piri(areas(:,1:44),lgths(:,1:44),44,4,q2.piri+.0000001,q2.dxnew*ones(1,4),Loc_piri);

%fmts = 0;
%bw = 0;

Z.word = E.word;
Z.aud = aud2;
Z.audf = aud2f;
Z.q = q2;
Z.r = r;
Z.areas = areas;
Z.vareas = vareas;
Z.Tc = Tc;
Z.Tv = Tv;
Z.Tg = Tg;
Z.Tr = Tr;
Z.Tn = Tn;
Z.Tf = Tf;
Z.F = fmts;
Z.H = hts;
Z.BW = bw;
Z.tmf = 0.006866*[0:length(fmts)-1];
Z.x = q.dxnew*[1:44];
Z.wtrfall = wtrfall;
Z.fx = fx;
Z.P = P;
Z.fo = fo;
Z.M = M;




