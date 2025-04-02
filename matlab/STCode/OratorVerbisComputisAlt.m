function Z = OratorVerbisComputisAlt(E);
%OratorVerbisComputisAlt.m
%B. Story
%06.28.2021
%
%

N = E.N;

%addpath ../../Advanced
%addpath ../../../Advanced %use for RDP_paper/Revision
%addpath ../../../../../../mri/vorperian/VocalTractGrowthModel2/VokalTrakt_SideBranch



q = CreateNew_q(N,4);

%---Defaults  ----

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
q.fotarg = 100;
q.FMext = 0.0;
q.jitterOVC = 0.;
q.jitter = 0;
q.nzbw = [500 2000];
q.nzbw2 = [1500 4000]; %fricative noise



if(isfield(E,'randF0') == 1)
    randF0 = E.randF0;
else
    randF0 = 0;
end


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

if(isfield(E,'To') == 1)
    q.To = E.To;
end

if(isfield(E,'PL') == 1)
    q.PL = E.PL;
end

if(isfield(E,'xib') == 1)
    q.xibl = E.xib;
    q.xibr = E.xib;
end

if(isfield(E,'x02') == 1)
    q.x02l = E.x02;
    q.x02r = E.x02;
end


if(isfield(E,'pgap') == 1)
    q.pgap = E.pgap;
end

if(isfield(E,'np') == 1)
    q.npr = E.np;
    q.npl = E.np;
end

if(isfield(E,'PL') == 1)
    q.PL = E.PL;
end

if(isfield(E,'FMext') == 1)
    q.FMext = E.FMext;
end

if(isfield(E,'jitterOVC') == 1)
    q.jitterOVC = E.jitterOVC;
end

Fs = round(35000/(2*q.dxnew));
Nsim = q.td*Fs;


q.Ltract = 1;



%===========GENERATE TIMING FUNCTIONS FOR ALL EVENTS=========================

%NOTE (06.28.18): New variable in structures called 'sti' means 'saturation
%index' and allows for sustaining a gesture over some amount of time -
%however, time is indicated by number of time samples like other parameters
%(hence the 'i' in the name).

if(isfield(E,'sti_flag') == 1)
    sti_flag = E.sti_flag;
else
    %sti_flag = 1; %---this option puts Npk in the middle of sti; use 2 for beginning
    sti_flag = 2; %---this option puts Npk in the middle of sti; use 2 for beginning
end


%-----Generate timing functions for consonants -----
for n=1:length(E.C)
    
    if(isfield(E.C(n),'sti') == 0 || isempty(E.C(n).sti) == 1)
        E.C(n).sti = 0;
    end
    
    Tc(:,n) = MovementTrajGaussianSkewHold(N,E.C(n).tmi,E.C(n).gwi,1,E.C(n).skw,E.C(n).sti,sti_flag)';
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
    
    Tv(:,n) = MovementTrajGaussianSkewHold(N,E.V(n).tmi,E.V(n).gwi,1,E.V(n).skw,E.V(n).sti,sti_flag)';
end

%-----Generate timing functions for adduction -----

for n=1:length(E.G)
    
    if(isfield(E.G(n),'sti') == 0 || isempty(E.G(n).sti) == 1)
        E.G(n).sti = 0;
    end
    Tg(:,n) = MovementTrajGaussianSkewHold(N,E.G(n).tmi,E.G(n).gwi,E.G(n).xi,E.G(n).skw,E.G(n).sti,sti_flag)';
end

q.gc = sum(Tg,2);

%-----Generate timing functions for subglottal pressure -----
for n=1:length(E.R)
    
    if(isfield(E.R(n),'sti') == 0 || isempty(E.R(n).sti) == 1)
        E.R(n).sti = 0;
    end
    Tr(:,n) = MovementTrajGaussianSkewHold(N,E.R(n).tmi,E.R(n).gwi,E.R(n).sfPL,E.R(n).skw,E.R(n).sti,sti_flag)';
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
    Tn(:,n) = MovementTrajGaussianSkewHold(N,E.Nas(n).tmi,E.Nas(n).gwi,E.Nas(n).arnas,E.Nas(n).skw,E.Nas(n).sti,sti_flag)';
end

q.np = sum(Tn,2);

%-----Generate timing functions for fo -----
for n=1:length(E.fo)
    
    if(isfield(E.fo(n),'sti') == 0 || isempty(E.fo(n).sti) == 1)
        E.fo(n).sti = 0;
    end
    Tf(:,n) = MovementTrajGaussianSkewHold(N,E.fo(n).tmi,E.fo(n).gwi,E.fo(n).sffo,E.fo(n).skw,E.fo(n).sti,sti_flag)';
    omegaF0 = 20;
    fsartic = 146;
    %Tf(:,n) = MovementTrajInertial3(N,E.fo(n).tmi, E.fo(n).gwi, E.fo(n).sffo, E.fo(n).sti, omegaF0, 1/fsartic);
end

fo = sum(Tf,2);

%----use for child-----
% gcoffset = 0.0; 
% fogc = 1-fo;
% fogc = gcoffset*fogc/max((fogc));
%-------------------


%----use for adult male-----
gcoffset = 0.01; %for adult male
fogc = (1+fo).^2;
fogc = fogc-min(fogc);
fogc = gcoffset*fogc;
%-------------------

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
    [b,a] = butter(2,10/(2000/2),'high');
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


% pcoffset = -0.1*q.PL;
% %fogc = 1-fo;
% fopc = (1+fo).^2;
% fopc = fopc-min(fopc);
% %fogc = gcoffset*fogc/max((fogc));
% %fogc = fo/max(abs(fo));
% fopc = pcoffset*fopc;
% 
% q.pc = fopc(:) + q.pc;

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
% [areas, M, qnew] = SensitiveTalker_Norm_SBranch_AltCalc(vareas,Tc,P(1:4,:),q.dxnew,q,cflag);
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

%-------only for CV study
% q2.fo = [];
% q2.fotarg = 108;
% q2.F0contour = 12;
%--------

sx = (q2.dxnew/0.396825).^2; 
q2.piri = sx*q2.piri;

[aud2,ugn,t,r,tv,areas,lgths,fo,p,vareasX,Csim,tractindex,c,pA,cA,tA,NsimA,audp] = BlackCat(q2);

% if(q2.dxnew >= 0.36)
%     [aud2,ugn,t,r,tv,areas,lgths,fo,p,vareasX,Csim,tractindex,c,pA,cA,tA,NsimA,audp] = BlackCat(q2);
% elseif(q2.dxnew < 0.36 && q2.dxnew > 0.3 )
%     [aud2,ugn,t,r,tv,areas,lgths,fo,p,vareasX,Csim,tractindex,c,pA,cA,tA,NsimA,audp] = BlackCatFemale(q2);
% elseif(q2.dxnew <= 0.3 )
%     [aud2,ugn,t,r,tv,areas,lgths,fo,p,vareasX,Csim,tractindex,c,pA,cA,tA,NsimA,audp] = BlackCatChild(q2);
% end
%    
    
[b,a] = butter(4,90/(44100/2),'high');
aud2f = filtfilt(b,a,aud2);

%[fmts] = calc_areafmts(areas(:,1:44),lgths,44,3);
Loc_piri = 6;
[fmts, hts, bw, wtrfall, zall, fx] = calc_areafmts_bw_piri(areas(:,1:44),lgths(:,1:44),44,4,q2.piri+.0000001,q2.dxnew*ones(1,4),Loc_piri);

%fmts = 0;
%bw = 0;

%[rms,t,dtn] = FindRMS(r.pout,.01,t.Fs);

Z.word = E.word;
Z.aud = aud2;
Z.audf = aud2f;
Z.audp = audp;
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
% Z.rms = rms;
% Z.trms = t;




