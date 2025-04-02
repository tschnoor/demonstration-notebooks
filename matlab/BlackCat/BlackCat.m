function  [audn,ugn,t,r,tv,areas,lgths,fo,p,vareas,Csim,tractindex,c,pA,cA,tA,NsimA,audp] = BlackCat(q);
%BlackCat.m; Version 1.0
%B. Story
%12.03.2013
%BlackCat.m is the most complete and up to date version of the TubeTalker
%Operating System (TOS)

%------------------------------------------------------------------------
Td = q.td;
dxnew = q.dxnew;
vow1 = q.vow1;
vow2 = q.vow2;
fotarg = q.fotarg;
nareas = q.areas;
Tsvt = 0.006866;

if(isempty(q.nqf) == 0)
    nc = q.nqf;
else
    nc = [];
end

if(isfield(q,'fo') == 1)
    if(isempty(q.fo) == 0)
        fo = q.fo;
    else
        fo = [];
    end
else
    fo = [];
end

mod_m = q.mod_m;
amp = [];

%load static_params_bhs.mat;
%load static_params_bhs9602.mat;
%load CF1_vowels_modes.mat
load static_params_bhs9602X.mat;
%load static_params_mrm1.mat
%load static_params_mrmx.mat;
%load static_params_dm_norm.mat
%load static_params_dm_sing.mat
%load static_params_mrf3.mat
%load d:/users/brad/mri/ua/SM/sm123_meandata.mat
%load static_params_lssing.mat

if(isfield(q,'stat') == 1)
    if(isempty(q.stat)==0)
        stat = q.stat;
    end
end

% if(isempty(q.nqf)==0)
%     Td = (length(q.nqf)-2)*Tsvt;
% end

N = round(Td * 1/Tsvt);

mc = q.mc(1:N,:);
lc = q.lc(1:N,:);
ac = q.ac(1:N,:);
rc = q.rc(1:N,:);
sc = q.sc(1:N,:);
np = q.np(1:N,:);
pc = q.pc(1:N,:);
gc = q.gc(1:N,:);

if(isempty(mod_m) == 0)
    stat.ne = stat.ne.*mod_m;
end

if(isfield(q,'arnew') == 1)
    if(isempty(q.arnew)==0)
        stat.ne = sqrt((4/pi)*q.arnew(:));
        
    end
end

%--------Determine new sampling freq.-----------------
if(dxnew == 0.396825)
    Fs = 44100;
else
    Fs = round(35000/(2*dxnew));
end
Fs


if(isempty(nc) ==1)
    
    %  q1 = MovementTraj([1 round(.4*N)  round(.75*N)  N],[stat.coeff(1,vow1) stat.coeff(1,vow1)  stat.coeff(1,vow2) stat.coeff(1,vow2) ]);
    %  q2 = MovementTraj([1 round(.4*N)  round(.75*N)   N],[stat.coeff(2,vow1) stat.coeff(2,vow1) stat.coeff(2,vow2) stat.coeff(2,vow2) ]);
    
    if(vow1 > 0 && vow2 > 0)
        q1 = 1*MovementTraj([1 round(.2*N)  round(.8*N)   N],[stat.coeff(1,vow1) stat.coeff(1,vow1) 1*stat.coeff(1,vow2)  1*stat.coeff(1,vow2) ]);
        q2 = 1*MovementTraj([1 round(.2*N)  round(.8*N)   N],[stat.coeff(2,vow1) stat.coeff(2,vow1) stat.coeff(2,vow2)  stat.coeff(2,vow2) ]);
        
    elseif(vow1 > 0 && vow2 > 0 && q.areaflag == 'bvb---')
        
        q1 = 1*MovementTraj([1 round(.3*N) round(.5*N)  round(.75*N)  round(.85*N) N],[0.5*stat.coeff(1,vow1) stat.coeff(1,vow1) stat.coeff(1,vow1) 1*stat.coeff(1,vow2)  1*stat.coeff(1,vow2) 0.5*stat.coeff(2,vow1) ]);
        q2 = 1*MovementTraj([1 round(.3*N) round(.5*N)  round(.75*N)  round(.85*N) N],[0.5*stat.coeff(2,vow1) stat.coeff(2,vow1) stat.coeff(2,vow1) stat.coeff(2,vow2)  stat.coeff(2,vow2) 0.5*stat.coeff(2,vow1)]);
        
        
    elseif(vow1 > 0 && vow2 ==0)
        %q1 = 1*MovementTraj([1 round(.4*N)  round(.75*N)   N],[stat.coeff(1,vow1) stat.coeff(1,vow1) 0  0 ]);
        %q2 = 1*MovementTraj([1 round(.4*N)  round(.75*N)   N],[stat.coeff(2,vow1) stat.coeff(2,vow1) 0  0 ]);
        q1 = 1*MovementTraj([1   round(.85*N)   N],[stat.coeff(1,vow1) stat.coeff(1,vow1)   0 ]);
        q2 = 1*MovementTraj([1   round(.85*N)   N],[stat.coeff(2,vow1) stat.coeff(2,vow1)   0 ]);
    elseif(vow1 == 0 && vow2 > 0)
        q1 = 1*MovementTraj([1 round(.4*N)  round(.75*N)   N],[0 0 1*stat.coeff(1,vow2)  1*stat.coeff(1,vow2) ]);
        q2 = 1*MovementTraj([1 round(.4*N)  round(.75*N)   N],[0 0 stat.coeff(2,vow2)  stat.coeff(2,vow2) ]);
    elseif(vow1 == 0 && vow2 == 0)
        q1 = zeros(N,1);
        q2 = zeros(N,1);
    elseif(vow1 == vow2 && vow1 > 0)
        q1 = 1*MovementTraj([1 round(.75*N)  round(.90*N)   N],[stat.coeff(1,vow1) stat.coeff(1,vow1) 1*stat.coeff(1,vow2)  0.75*stat.coeff(1,vow2) ]);
        q2 = 1*MovementTraj([1 round(.75*N)  round(.90*N)   N],[stat.coeff(2,vow1) stat.coeff(2,vow1) stat.coeff(2,vow2)  0.75*stat.coeff(2,vow2) ]);
    end
    
    
else
    
    
    if( isempty(q.dT) == 0)
        Ns = length(nc);
        tmp = ones(1,Ns).*q.dT';
        tmp = cumsum(tmp);
        xold = tmp;
        %xold = [1:Ns].*dT';
        xold = xold-xold(1);
        xnew = [0:xold(end)/(Ns-1):xold(end)]';
        nc(:,1) = spline(xold,nc(:,1),xnew);
        nc(:,2) = spline(xold,nc(:,2),xnew);
        
        for i=1:size(q.mc,2);
            q.mc(:,i) = interp1(xold,q.mc(:,i),xnew)';
            q.ac(:,i) = interp1(xold,q.ac(:,i),xnew)';
            q.lc(:,i) = interp1(xold,q.lc(:,i),xnew)';
            q.rc(:,i) = interp1(xold,q.rc(:,i),xnew)';
            q.sc(:,i) = interp1(xold,q.sc(:,i),xnew)';
        end
        
        %---------interp for adduction time course --------------
        if(isfield(q,'gc')==1)
            q.gc(:,1) = interp1(xold,q.gc(:,1),xnew)';
        else
            q.gc = [];
        end
        %--------------------------------------------------------------
        
        %---------interp for Resp pressure time course --------------
        if(isfield(q,'pc')==1)
            q.pc(:,1) = interp1(xold,q.pc(:,1),xnew)';
        else
            q.pc = [];
        end
        %--------------------------------------------------------------
        
        %---------interp for nasal port time course --------------
        if(isfield(q,'np')==1)
            q.np(:,1) = interp1(xold,q.np(:,1),xnew)';
        else
            q.np = [];
        end
        %--------------------------------------------------------------
        
    end
        
        Ntmp = length(nc);
        tm = [0:1:Ntmp-1];
        tmn = [0:(Ntmp)/N:Ntmp-1];
        q1 = interp1(tm,nc(:,1),tmn)';
        q2 = interp1(tm,nc(:,2),tmn)';
        
        for i=1:size(q.mc,2);
            mc(:,i) = interp1(tm,q.mc(:,i),tmn)';
            ac(:,i) = interp1(tm,q.ac(:,i),tmn)';
            lc(:,i) = interp1(tm,q.lc(:,i),tmn)';
            rc(:,i) = interp1(tm,q.rc(:,i),tmn)';
            sc(:,i) = interp1(tm,q.sc(:,i),tmn)';
            
        end
        
        %---------interp for adduction time course --------------
        if(isfield(q,'gc')==1)
            gc(:,1) = interp1(tm,q.gc(:,1),tmn)';
        else
            gc = [];
        end
        %--------------------------------------------------------------
        
        %---------interp for Resp pressure time course --------------
        if(isfield(q,'pc')==1)
            pc(:,1) = interp1(tm,q.pc(:,1),tmn)';
        else
            pc = [];
        end
        %--------------------------------------------------------------
        
        %---------interp for nasal port time course --------------
        if(isfield(q,'np')==1)
            np(:,1) = interp1(tm,q.np(:,1),tmn)';
        else
            np = [];
        end
        %--------------------------------------------------------------
    
    
    
    N = length(q1);
    
end

%------boundaries ----------------
% q1( q1 < min(stat.coeff(1,:)) ) = min(stat.coeff(1,:));
% q1( q1 > max(stat.coeff(1,:)) ) = max(stat.coeff(1,:));
% q2( q2 < min(stat.coeff(2,:)) ) = min(stat.coeff(2,:));
% q2( q2 > max(stat.coeff(2,:)) ) = max(stat.coeff(2,:));
%------------------------------------


if(isempty(q.dL) == 0)
    disp('Altering VT length vector...');
    Ns = length(stat.ne);
    xold = make_lengthv(q.dL);
    xold = xold-xold(1);
    xnew = [0:xold(end)/(Ns-1):xold(end)]';
    stat.ne = spline(xold,stat.ne,xnew);
    for i=1:size(stat.phi,2)
        stat.phi(:,i) = spline(xold,stat.phi(:,i),xnew);
    end    
end


if(isfield(q,'dM') == 1)
    if(isempty(q.dM)==0)
        disp('Altering mode amplitudes...');
        stat.phi(:,1) = stat.phi(:,1).*q.dM(:);
        stat.phi(:,2) = stat.phi(:,2).*q.dM(:);
    end
end


%----------Standard setup--------------------- 
ac1 = q.aepi;
ac2 = 0.0;
ac3 = 0.1;
lc1 = q.lepi;
lc2 = 44;
lc3 = 32;
rc1 = 6;
rc2 = 5;
rc3 = 4;
mc1 = 1;  % sc in new format
mc2 = 1;
mc3 = 0;
sc1 = 1; %mc in new format
sc2 = 1;
sc3 = 1;
pm = 0;



ZN = zeros(N,1);
ON = ones(N,1);


tv = tvStructGenerator(N);

tv.q = [q1 q2];
tv.np= ZN;
tv.lg= ZN;
tv.lm= 44*ON;
tv.pg= ZN;
tv.rg= ON;
tv.pm= pm*ON;
tv.rm= ON;
tv.Fo = 120*ON;
tv.Vamp = 200*ON;
tv.Fsp = 80;
tv.N = N;



%================Test run==============================


tv.mc = mc;
tv.lc = lc;
tv.ac = ac;
tv.rc = rc;
tv.sc = sc;

%Modulation of the pharynx ----------------------------------
if(isfield(q,'lphrx') == 1)
    if(isempty(q.lphrx) == 0)
        if(q.lphrx ==0)
            mc2 = 0;
        end
        mcp = MovementTraj([1  N],[mc2 mc2 ]);
        if(mc2 > 0)
            mcp = modulate_fo2(mcp,1/Tsvt,q.PhrxModExt,q.PhrxModFreq)-1;
        end
        
        n = size(tv.mc,2);
        if(q.lphrx > 0)
            tv.mc(:,n+1) = mcp;
            tv.ac(:,n+1) = 0;
            tv.lc(:,n+1) = q.lphrx;
            tv.rc(:,n+1) = 5;
            tv.sc(:,n+1) = 1;
        end
    end
end

%======================================================================

%Time function for nasal port

if(isfield(q,'np') == 1)
    tv.np(:,1) = np;
else
    tv.np(:,1) = 0;
end

%======================================================================

pm = MovementTraj([1  N],[0  pm  ]);
tv.pm(:,1) = pm;

n = size(tv.mc,2);
if(q.lepi > 0)
    tv.mc(:,n+1) = 1;
    tv.ac(:,n+1) = q.aepi;
    tv.lc(:,n+1) = q.lepi;
    tv.rc(:,n+1) = 6;
    tv.sc(:,n+1) = 1;   
end

%=================================================================

%[areas,lgths] = TractBuilder(stat,tv);
[areas,lgths,vareas,Csim] = TractBuilderReturnCons(stat,tv);

if(isfield(q,'cfuncn') == 1)
    vareas(:,1:8) = areas(:,1:8);
    clear areas
    vareas = sqrt((4/pi)*vareas);
    %q.mctx(q.mctx>1) = 1;
    %q.mctx(q.mctx<0) = 0;
    for i=1:length(q.mctx);
        tmp = ((q.cfuncn-1)*q.mctx(i)+1).*vareas(i,1:44);
        tmp(tmp<0) = 0;
        areas(i,1:44) =(pi/4)*tmp.^2;
        areas(i,45) = q.np(i);
    end
    vareas = (pi/4)*vareas.^2;
end


tmp = isempty(nareas)
if(tmp == 0)
    foo = size(nareas);
    if(foo(1) == 1)
        for i=1:N
            areas(i,:) = nareas;
        end
    else
        areas = nareas;
    end
end


%Nfo = ceil((N/80) * 2000);
Nfo = ceil((N*0.006866) * 2000);

if(isempty(fo) == 1)
    i = 1;

    if(q.F0contour == 1)
        fo = MovementTraj([1 round(.4*Nfo)  Nfo],[.85*fotarg(i) 1.2*fotarg(i)  .70*fotarg(i)]);
    elseif(q.F0contour == 2)
       fo = MovementTraj([1 round(.4*Nfo)  Nfo],[.9*fotarg(i) 1.1*fotarg(i)  .80*fotarg(i)]);
    elseif(q.F0contour == 3)
        
        load blackcat_fo.mat fofilt1
        fox = fofilt1;
        fot = [1];
        foy = [fox(1,2)*fotarg(i)];

        for j=2:length(fox)
            fot = [fot; round(fox(j,1)*Nfo)];
            foy = [foy; (fox(j,2)*fotarg(i))];
        end

        %This works but makes the f0 contour a bit jerky
        %fo = MovementTraj(fot,foy);
        
        %Spline creates a smoother F0 contour
        fot = fot -1;
        tmn = [0:1:fot(end)];
        fo = spline(fot,foy,tmn)';

    elseif(q.F0contour == 4)
        
        load blackcat_fo.mat fofilt2
        fox = fofilt2;
        fot = [1];
        foy = [fox(1,2)*fotarg(i)];

        for j=2:length(fox)
            fot = [fot; round(fox(j,1)*Nfo)];
            foy = [foy; (fox(j,2)*fotarg(i))];
        end

        %This works but makes the f0 contour a bit jerky
        %fo = MovementTraj(fot,foy);
        
        %Spline creates a smoother F0 contour
        fot = fot -1;
        tmn = [0:1:fot(end)];
        fo = spline(fot,foy,tmn)';
       
    elseif(q.F0contour == 5)
        
        load blackcat_fo.mat fofilt3
        fox = fofilt3;
        fot = [1];
        foy = [fox(1,2)*fotarg(i)];

        for j=2:length(fox)
            fot = [fot; round(fox(j,1)*Nfo)];
            foy = [foy; (fox(j,2)*fotarg(i))];
        end

        %This works but makes the f0 contour a bit jerky
        %fo = MovementTraj(fot,foy);
        
        %Spline creates a smoother F0 contour
        fot = fot -1;
        tmn = [0:1:fot(end)];
        fo = spline(fot,foy,tmn)';
        
    elseif(q.F0contour == 6)
        fo = MovementTraj(round([1 Nfo*[ 0.3    0.45  ] Nfo]),fotarg(i)*[1.08    1.04    1.15    0.85]);
    elseif(q.F0contour == 7)
        fo = MovementTraj(round([1  Nfo*[ 0.1 0.4  ] Nfo]),fotarg(i)*[0.8 1.2   1.1  .8]);
    elseif(q.F0contour == 8)
        fo = MovementTraj([1 round(.35*Nfo)  Nfo],[.85*fotarg(i) 1.2*fotarg(i) .70*fotarg(i)]);
    elseif(q.F0contour == 9)
        fo = MovementTraj(round([1 Nfo*[ 0.5  ] Nfo]),fotarg(i)*[.9   1.4  .7]);  
    elseif(q.F0contour == 10)
        fo = MovementTrajCos([1  round(.5*Nfo)  round(.7*Nfo) Nfo],[1.*fotarg(i)  .9*fotarg(i) 1.35*fotarg(i)  .85*fotarg(i)]);
    elseif(q.F0contour == 11)
        fo = MovementTraj([1 round(.4*Nfo)  Nfo],[.9*fotarg(i) 1.*fotarg(i)  .8*fotarg(i)]);
    elseif(q.F0contour == 12)
         fo = MovementTraj([1 round(.4*Nfo)  Nfo],[.9*fotarg(i) 1.*fotarg(i)  .75*fotarg(i)]);
    elseif(q.F0contour == 13)
        fo = MovementTraj(round([1 Nfo*[ 0.5 0.95  ] Nfo]),fotarg(i)*[1  .85   1.4  1.2]); %question
    elseif(q.F0contour == 14)
        load eatpeas_fox.mat fox3
        fox = fox3;
        fo = MovementTraj(round([1 Nfo*[ fox(:,1)' ] Nfo]),fotarg(i)*[1  fox(:,2)'  1.]);
        clear fox3 fox
        
    elseif(q.F0contour==15)
        fo = MovementTraj(round([1 Nfo*[ 0.42 .48  ] Nfo]),fotarg(i)*[1   1  2^(6/12) 2^(6/12)]);
        
    elseif(q.F0contour==16)
        if(isfield(q,'mctx')==1)
            [ii,jj] = max(q.mctx);
            tmp = jj/length(q.mctx);
            fo = MovementTraj(round( [1 Nfo*tmp  Nfo] ),fotarg(i)*[0.9 1.25 0.7]);
        else
            fo = 100*ones(Nfo,1);
        end
        
        elseif(q.F0contour==17)
        if(isfield(q,'mctx')==1)
            [ii,jj] = max(q.mctx);
            tmp = jj/length(q.mctx);
            fo = MovementTraj(round( [1 Nfo*tmp  Nfo] ),fotarg(i)*[0.9 1. 1.4]);
        else
            fo = 100*ones(Nfo,1);
        end
     
      
        
     elseif(q.F0contour == 18)
        fo = MovementTraj(round([1 Nfo*[ .3  ] Nfo]),fotarg(i)*[0.95 1.15 .75]);   
        
     elseif(q.F0contour == 19)
        fo = MovementTrajCos(round([1 Nfo*[  0.25 0.5 0.85 ] Nfo]),fotarg(i)*[.8  1.1 .9 .95  .7]);        
        
     elseif(q.F0contour == 20)
        fo = MovementTrajCos(round([1 Nfo*[ .05 0.1 .15 0.25 0.5 0.85 ] Nfo]),fotarg(i)*[.8 .9 .2 .9  1.1 .9 .95  .7]);   
        
     elseif(q.F0contour == 21)
        fo = MovementTrajCos(round([1 Nfo*[  0.25 0.5 0.75 ] Nfo]),fotarg(i)*[.8  1 .9 .95  .7]);         
        
     elseif(q.F0contour == 22)
        fo = MovementTrajCos(round([1 Nfo*[  .15   .35  .65 ] Nfo]),fotarg(i)*[.9    1.2  .8 1.05  .7]);
        %fo = MovementTrajCos(round([1 Nfo*[  .15   .35 .65 .75] Nfo]),fotarg(i)*[.8  1.15  1.0  0.8 0.95 0.7]);
        
     elseif(q.F0contour == 23)
         %Best for abracadabra
         fo = MovementTrajCos(round([1 Nfo*[  .1   .35  .65 ] Nfo]),fotarg(i)*[.9    1.36  .8 1.05  .7]);      
     elseif(q.F0contour == 24)
          fo = MovementTraj([1 round(.5*Nfo)  Nfo],[0.9*fotarg(i)  1.0*fotarg(i) 0.7*fotarg(i)]);    
     elseif(q.F0contour == 25)
        %--Specifically for "abracadabra" -------------------------------
        load abracadabra_fo_test.mat 
        fo  = MovementTrajCos([1 y(:,1)'*Nfo ],fotarg(i)*[y(1,2) y(:,2)' ]);
     elseif(q.F0contour == 26)

        %--Specifically for "he had a rabbit and a boat" -------------------------------

        load ../../BeamSplitter/KBBS02_BSectScripts/hehadrabbitandboat_fo.mat fofilt2 fofilt3 fofilt2_andah
        fox = fofilt2_andah;
        
        %load C:\userz\brad\matlab\btools\BeamSplitter\KBBS02_BSectScripts\rabbitjoker.mat fofilt7
        %fox = fofilt7;

        fot = [1];
        foy = [fox(1,2)*fotarg(i)];

        for j=2:length(fox)
            fot = [fot; round(fox(j,1)*Nfo)];
            foy = [foy; (fox(j,2)*fotarg(i))];
        end

        %This works but makes the f0 contour a bit jerky
        %fo = MovementTraj(fot,foy);
        
        %Spline creates a smoother F0 contour
        fot = fot -1;
        tmn = [0:1:fot(end)];
        fo = spline(fot,foy,tmn)';
        
    else
        fo = MovementTraj([1 round(.4*Nfo) round(.6*Nfo)  Nfo],[1.*fotarg(i) 1.*fotarg(i) 1*fotarg(i) 1*fotarg(i)]);
    end



    if(q.FMext > 0)
        fo = modulate_fo2(fo,2000,q.FMext,q.FMfreq);
        %fo = modulate_fo2_randphase(fo,2000,q.FMext,q.FMfreq);
        %fo = modulate_fo2_fadein(fo,2000,q.FMext,q.FMfreq)
        
%         fo = modulate_fo_follow_randphase(fo,2000,q.FMext,q.FMfreq);
%         disp('Using F0 following modulation -  NOT TREMOR/VIBRATO (see line 550)');
        
%         fo = modulate_fo_median_mod(fo,2000,q.FMext,q.FMfreq);
%         disp('Using F0 median modulation -  NOT TREMOR/VIBRATO (see line 550)');
    end

end


    
% %------------Add jitter to F0 contour before resampling------------------
% if(isfield(q,'jitter'));
%     %fo = fo + fo.*(.2*(rand(length(fo),1)-.5));
%     %fo = fo + fo.*(.01*randn(length(fo),1));
%     tmp = rand(length(fo),1)-.5;
%     tmp = fade_cos(tmp,.001,Fs);
%     %[b,a] = butter(2,300/(2000/2));
%     [b,a] = butter(2,[min(fo)/1.5 max(fo)/1.5]/(2000/2));
%     tmp = filtfilt(b,a,tmp);
%     tmp = tmp/max(abs(tmp));
%     fo = fo + fo.*(q.jitter*tmp);
%     disp([num2str(q.jitter) ' jitter added to F0 contour']);
% end
%------------------------------------------------


%------------Add jitter to F0 contour before resampling - based on ColoredNoise------------------
if(isfield(q,'jitter'));
    %tmp = rednoise(length(fo));
    %tmp = pinknoise(length(fo));
    %tmp = bluenoise(length(fo));
    tmp = bluenoise(length(fo)) + .5*pinknoise(length(fo));
    tmp = tmp(:);
    tmp = tmp/max(abs(tmp));
    fo = fo + fo.*(q.jitter*tmp);
    disp([num2str(q.jitter) ' jitter added to F0 contour']);
end
%------------------------------------------------



tm = [0:1/2000:(length(fo)-1)/2000];
tmn = [0:1/Fs:tm(end)];
F0 = interp1(tm,fo,tmn);

%------------Add jitter to F0 contour after resampling ------------------
% if(isfield(q,'jitter'));
%     %fo = fo + fo.*(.2*(rand(length(fo),1)-.5));
%     %fo = fo + fo.*(.01*randn(length(fo),1));
%     tmp = rand(length(F0),1)-.5;
%     [b,a] = butter(2,250/(Fs/2));
%     tmp = filtfilt(b,a,tmp);
%     tmp = tmp/max(abs(tmp));
%     F0 = F0(:) + F0(:).*(q.jitter*tmp(:));
%     disp([num2str(q.jitter) ' jitter added to F0 contour']);
% end
%------------------------------------------------
F0 = F0(:)';


if(isfield(q,'vox') == 1)
    if(isempty(q.vox) == 1)
        Nsim = length(F0)
    else
        Nsim = length(q.vox)
        clear F0
        F0(1:Nsim) = q.fotarg*ones(Nsim,1);
    end
else
    Nsim = length(F0)
end


init_modermouthnoise
%init_modermouth_asym
tractindex = h;

%Modify trachea, piriform, and nasal cavities if VTL is less than 0.396825
%cm

%-Trachea--Added on 11.30.21----
if(q.dxnew < 0.396825)
%     t.ar(tractindex.itrch:tractindex.jtrch) = trach7;
%     disp('Trachea scaled to be female');
    
    sx = (q.dxnew/0.396825).^2; 
    t.ar(tractindex.itrch:tractindex.jtrch) = sx*t.ar(tractindex.itrch:tractindex.jtrch);
    disp('Tracheal areas scaled based on shorter VTL');
end

%-Piriform--Added on 11.30.21----
if(q.dxnew < 0.396825)
    
    sx = (q.dxnew/0.396825).^2; 
    t.ar(tractindex.ipiri:tractindex.jpiri) = sx*t.ar(tractindex.ipiri:tractindex.jpiri);
    disp('Piriform sinus areas scaled based on shorter VTL');
end


%-Nasal--Added on 11.30.21----Was NOT used for male, female, and child
%stimuli in Feb 2022
%
% if(q.dxnew < 0.396825)
%     
%     sx = (q.dxnew/0.396825).^2; 
%     t.ar(tractindex.inose:tractindex.jmaxll2) = sx*t.ar(tractindex.inose:tractindex.jmaxll2);
%     disp('Nasal passages and sinus areas scaled based on shorter VTL');
% end

%-----Design 2nd order Butterworth filter for noise generator---

%---default noise bandwidth for glottis-------
[b,a] = butter(2,[300 3000]/(Fs/2));
%---variable noise bandwidth----
if(isfield(q,'nzbw') == 1)
    if(isempty(q.nzbw) == 0)
        [b,a] = butter(2,[q.nzbw(1) q.nzbw(2)]/(Fs/2));
    end
end
%---assign butterworth coeffs to "t" structure---
t.ca = a(1:5)';
t.cb = b(1:5)';
%----------------------------------------------


%---default noise bandwidth for fricatives-------
[b,a] = butter(2,[1500 4000]/(Fs/2));
%---variable noise bandwidth----
if(isfield(q,'nzbw2') == 1)
    if(isempty(q.nzbw2) == 0)
        [b,a] = butter(2,[q.nzbw2(1) q.nzbw2(2)]/(Fs/2));
    end
end
%---assign butterworth coeffs to "t" structure---
t.cca = a(1:5)';
t.ccb = b(1:5)';
%----------------------------------------------




p.PL = q.PL;
pl = p.PL*ones(Nsim,1);
tmp = round(.01*Nsim);
tmp2 = round(.01*Nsim);
pl(1:tmp) = focontour_cos(10000,p.PL,tmp)';
pl(end-tmp2+1:end) = focontour_cos(p.PL,100,tmp2)';

pl = MovementTraj([1  round(.95*Nsim) Nsim],[ p.PL  p.PL p.PL*.3]);

%----Alter PL based on pc -------------------------------

if(isempty(pc) == 0)
    tmo = [0:.006866:(length(pc(:,1))-1)*.006866];
    tmn = [0:1/Fs:tmo(end)];
    
    tmp = interp1(tmo,pc,tmn);
    %tmp = 5000*tmp + p.PL;
    tmp = tmp + p.PL;
    
    pl = tmp';
    
end


if(length(pl)>Nsim)
    pl = pl(1:Nsim);
elseif(length(pl) < Nsim)
    pl(end+1:Nsim) = pl(end);
end




if(q.AMext > 0)
    pl = modulate_fo2(pl,Fs,q.AMext,q.AMfreq);
end


% Time-varying adduction ------------------

tmp = round(.1*Nsim);
tmp2 = round(.1*Nsim);

x02 = q.x02r;
if(q.areaflag == 'ohio--');
    x02tm= MovementTraj([1 round(.2*Nsim) round(.35*Nsim) round(.5*Nsim) Nsim],[x02  x02 3*x02 x02 x02]);
elseif(q.areaflag == 'hawaii');
    x02tm= MovementTraj([1 round(.1*Nsim) round(.35*Nsim) round(.5*Nsim) Nsim],[3*x02  x02 x02 x02 x02]);
else
    x02tm= MovementTraj([1 round(.1*Nsim) round(.35*Nsim) round(.5*Nsim) Nsim],[x02  x02 x02 x02 x02]);
end

%----Alter x02 based on gc -------------------------------

if(isempty(gc) == 0)
    tmo = [0:.006866:(length(gc(:,1))-1)*.006866];
    tmn = [0:1/Fs:tmo(end)];
    
    
     if(max(abs(gc(:,1)))>0)
        %          disp('Adduction IS normalized');
        %         gc =  1*gc(:,1)/max(gc(:,1));
        %         tmp = interp1(tmo,gc,tmn);
        %         tmp = 0.5*tmp/max(tmp) + x02;
        %tmp = 0.05*tmp/max(tmp) + x02;
        
        disp('Adduction NOT normalized');
        tmp = interp1(tmo,gc,tmn);
        tmp = tmp + x02;
        %tmp(tmp<0) = 0;
        
    else
        tmp = x02*ones(length(tmn),1);
    end
    
    x02tm = tmp';
    
end

%----------------------------------------------------------

if(length(x02tm)>Nsim)
    x02tm = x02tm(1:Nsim);
elseif(length(x02tm) < Nsim)
    x02tm(end+1:Nsim) = x02tm(end);
end


 if(q.AdductModExt > 0)
     x02tm = modulate_fo2(x02tm(:),Fs,q.AdductModExt,q.AdductModFreq);
 end


%-----------------------------------------

%----Modulate F0 contour based on PL--------- at X Hz/cmH20

F0 = F0 + (q.HzpercmH20/980)*(pl'-p.PL);
%F0

%-----------------------------------------------------%


%---------Assign some new values to initscript structures-----

if(isfield(q,'Lo') == 1 && isfield(q,'To') == 1)
    if(isempty(q.Lo)==0 && isempty(q.To) == 0)
        c.Lo = q.Lo;
        c.To = q.To;
    end
end



p.x02R = q.x02r;
p.x02L = q.x02l;
c.xibR = q.xibr;
c.xibL = q.xibr;
c.asym = q.asym;
c.phi0R = q.phi0R;
c.phi0L = q.phi0L;
%c.R = q.npr;
c.npR = q.npr;
c.npL = q.npl;
c.pgap = q.pgap;
%t.vox = vox;
t.PL_tm = pl';
t.Fo_tm = F0';
%t.FoR_tm = F0' * q.fotargR/q.fotarg;

if(size(x02tm,2) == 1)
    t.x02_tm = x02tm';
else
    t.x02_tm = x02tm;
end
%t.Fo_tm = 128*ones(Nsim,1);

%------------AREA ASSIGNMENT-------------------------------
%---Original area assignment---- 
%t.ar_tm = areas(:,1:45);
%----New on 09.20.11----------
%--If the nasal port opens, this function linearly interpolates the
%velopharyx and removes some area from the oral portion of the area
%function; NasalCorrection.m resides in TubeTalker2 folder
[areas,nose0areas] = NasalCorrection(areas,tractindex.nnose,tractindex.jphrx);
for k=1:size(areas,1)
    Xareas(k,1:50) = [areas(k,1:44) nose0areas(k,1:6)];
end

Xareas(end+1,1:50) = Xareas(end,1:50); % needed to prevent numerical blowup at the end of sim
t.ar_tm = Xareas(:,1:50);
%-------------------------------------------------------------------

t.Fs = Fs;
t.VS = 4;




%------Sine wave source if xamp is a field and not empty------------
%  Sine wave source if desired 
xamptm = [];
if(isfield(q,'xamp')==1)
    if(isempty(q.xamp) == 0)
        for n=1:Nsim
            if(n==1)
                theta = 0;
            else
                theta = theta + pi*(F0(n) + F0(n-1))*(1/Fs);
            end
            if(theta >= 2*pi)
                theta = theta-2*pi;
            end
            if(isempty(xamptm) == 1)
                vox(n) = (q.xamp)*( (sin(theta-pi/2)+1)/2 )^q.beta + x02tm(n);
            else
                vox(n) = (xamptm(n))*( (sin(theta-pi/2)+1)/2 )^q.beta + x02tm(n);
            end
            
            %need high amplitude to get large interaction
        end
        vox(vox<0) = 0;
        vox = vox';
        q.vox = vox;
    end
end
%------------------------------------------
if(isfield(q,'vox')==1)
    if(isempty(q.vox)==0)
        t.vox = q.vox;
        if(max(t.vox) > 5)
            t.VS = 3;
        else
            t.VS = 2;
        end
    end
end

%----only for three mass----
% c.Lo = 0.6;
% t.VS = 1;
 %t.x02_tm = t.x02_tm-0.15;
%t.x02_tm = t.x02_tm-min(t.x02_tm);
%-------------------------------
%t.yw = 0;
%[p, r, t] = ModerMouth(p,c,t,Nsim);


if(isfield(q,'Lo') == 1 && isfield(q,'To') == 1)
    if(isempty(q.Lo)==0 && isempty(q.To) == 0)
        c.Lo = q.Lo;
        c.To = q.To;
    end
end

%=====THREE MASS STUFF - need to clean up========
if(isfield(q,'act')==1 && isfield(q,'ata')==1)
    if(isempty(q.act)==0 && isempty(q.ata)==0)
        t.act_tm = q.act;
        t.ata_tm = q.ata;
        t.Fs = Fs; 
        t.VS = 1;
        
        if(isfield(q,'Lo') == 1)
            c.Lo = q.Lo;
        else
            c.Lo = 1.6;
        end
        
        if(isfield(q,'To') == 1)
            c.To = q.To;
        else
            c.To = 0.3;
        end
       
        p.x02 = t.x02_tm(1);
        p.x01 = p.x02*1.0;
        
    end
end

%-----Assign area to piriform entry ------------------------
if(isfield(q,'piri') == 1)
    if(length(q.piri)==1)
        t.ar(tractindex.ipiri) = q.piri;
    else
        t.ar(tractindex.ipiri:tractindex.jpiri) = q.piri;
    end
else
    t.ar(tractindex.ipiri) = 0;
end
disp(['Piriform entry = ' num2str(t.ar(tractindex.ipiri)) ' cm2']);
%-----------------------------------------------------------------

% %-----Assign area to piriform entry ------------------------
% if(isfield(q,'piri') == 1)
%     t.ar(tractindex.ipiri) = q.piri;
% else
%     t.ar(tractindex.ipiri) = 0;
% end
% disp(['Piriform entry = ' num2str(t.ar(tractindex.ipiri)) ' cm2']);
% %-----------------------------------------------------------------

%----Take out trachea- if desired----
if(isfield(q,'Ltract') ==1)
    if(isempty(q.Ltract)==0)
        t.Ltract = q.Ltract;
    else
        t.Ltract = 1;
    end
    if(t.Ltract == 0)
        disp('NO trachea currently used');
    end
else
    t.Ltract = 1;
end

%---------

%----Take out supraglottal system- if desired----
if(isfield(q,'Utract') ==1)
    if(isempty(q.Utract)==0)
        t.Utract = q.Utract;
    else
        t.Utract = 1;
    end
    if(t.Utract == 0)
        disp('NO supraglottal currently used');
    end
else
    t.Utract = 1;
end

%----Take out yielding walls- if desired----
if(isfield(q,'yw') ==1)
    if(isempty(q.yw)==0)
        t.yw = q.yw;
    else
        t.yw= 1;
    end
    if(t.yw == 0)
        disp('NO yielding walls currently used');
    end
else
    t.yw = 1;
end

%---------

%----Take out viscous losses- if desired----
if(isfield(q,'visc') ==1)
    if(isempty(q.visc)==0)
        t.visc = q.visc;
    else
        t.visc= 1;
    end
    if(t.visc == 0)
        disp('NO viscous losses currently used');
    end
else
    t.visc = 1;
end

%---------



%--------Run the simulation by calling Mex file--------------------

pA = p; cA = c; tA = t; NsimA = Nsim;

%c.H = 0.4;
[p, r, t] = ModerMouthNoise(p,c,t,Nsim);
disp('Noise generator in tract turned ON');

r.ga = r.ad;

%[b,a] = butter(4,[40 400]/(t.Fs/2));
%r.foo = filtfilt(b,a,r.foo);
% 
% [i,j] = find(r.ga>0.16);
% if(isempty(j) == 0)
%     r.foo(j) = 0;
% end

%three ways to add the skin radiation
%aud = r.pout + r.foo*0.1;

%aud = r.pout + diff([r.foo 0])*2;
%disp('Skin radiation differentiated');


 [b,a] = butter(4,80/(Fs/2),'high');
 i = isinf(r.foo);
 j = isnan(r.foo);
 sum(i)
 sum(j)
%  [ix,jx] = find(i(:)==1);
%  [iy,jy] = find(j(:)==1);
%  r.foo(jx) = 0;
%  r.foo(jy) = 0;

 skin = filtfilt(b,a,r.foo);
 [rms,tx,dtn] = FindRMS(skin(1:3500),.01,Fs);
 rms_skin = max(rms);
 [rms,tx,dtn] = FindRMS(r.pout,.01,Fs);
 rms_pout = max(rms);
 sf = (rms_pout *.1)/rms_skin
 
 aud = r.pout + 0.05*skin;
 r.skin = 0.05*skin;
 disp('Skin radiation filtered');
 


%--------Resample if dxnew was not equal to 0.396825 cm-------------
%-----and Low pass filter to anti-alias and to account for plane wave approximation---

%Fc = 8000;
Fc = 5000;
b = fir1(440,Fc/(Fs/2),kaiser(441,5)); %anti-alias filter
aud = filtfilt(b,1,aud);
ug = filtfilt(b,1,r.ug);

    
if(Fs ~= 44100)
      
    told = [0:1/Fs:(length(aud)-1)/Fs];
    tnew = [0:1/44100:told(end)];
    audn = spline(told,aud,tnew);
    ugn = spline(told,ug,tnew);
    
else
    audn = aud;
    ugn = r.ug;
    
end;

%-----normalize---

audp = audn;

% d = fir1(500,Fc/(44100/2));
% audn = filtfilt(d,1,audn);
audn = fade(audn,.005,44100);
audn = .7*audn/max(abs(audn));

%ugn = filtfilt(d,1,ugn);
ugn = fade(ugn,.005,44100);
ugn = .7*ugn/max(abs(ugn));


%-----Create length matrix for external use -------

lgths = dxnew*lgths;
