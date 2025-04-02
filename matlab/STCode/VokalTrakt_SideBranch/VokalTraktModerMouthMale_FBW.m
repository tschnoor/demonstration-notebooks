function  [f,wtrfall,afmts,ahts,abw,wtrfallm,t,wtrfalln,z] = VokalTraktModerMouthMale_FBW(areas,dxnew,apiri);
%03.05.15
%VokalTraktModerMouthMale.m
%Calculates frequency response of each area function in the matrix "areas"
%and finds formants

%piriform coupling area

%--------Determine sampling freq.-----------------
if(dxnew == 0.396825)
    Fs = 44100;
else
    Fs = round(35000/(2*dxnew));
end



Nsim = 4096;
%Number of area function frames needed to generate a 4096 pt output
N = 15;

init_modermouthnoise
%init_modermouthnoise_lp
tractindex = h;

t.Fs = Fs;
Fs


%For impulse response----
t.VS = 3;
t.vox = zeros(Nsim,1);
t.vox(500) = 100;

% mc = MovementTrajGaussian(Nsim,500,5,100);
% t.vox = mc(:);

%--Remove trachea---
t.Ltract = 0;

% ----New on 10.07.16----------
if(isempty(apiri) == 0)
    t.ar(tractindex.ipiri) = apiri;
else
    t.ar(tractindex.ipiri) = 0;
end

disp(['Piriform entry = ' num2str(t.ar(tractindex.ipiri)) ' cm2']);



Na = size(areas);

if(Na(2) == 44)
    areas(:,45) = 0;
end

%---Remove losses if desirable----
t.visc = 0;
t.yw = 0;
t.att_trct = 0.000837;
t.att_trch = 0.000837;
%--------------------------

% %----Aramat hypothesis-------
%t.ar(h.inose+2:h.jnose) = 0.15;
% t.ar(h.inose1b-6:h.jnose1b) = 0.25*t.ar(h.inose1b-6:h.jnose1b);
% t.ar(h.inose2b-6:h.jnose2b) = 0.25*t.ar(h.inose2b-6:h.jnose2b);
% %t.ar(h.imaxll1:h.jmaxll1) = 0.0;
% %t.ar(h.imaxll2:h.jmaxll2) = 0.0;
% disp('Aramat settings ON');

% ----New on 09.20.11----------
% --If the nasal port opens, this function linearly interpolates the
% velopharyx and removes some area from the oral portion of the area
% function; NasalCorrection.m resides in TubeTalker2 folder
[areasN,nose0areas] = NasalCorrection(areas,tractindex.nnose,tractindex.jphrx);
%Note: areasN is a dummy here because BlackCat has already modified the
%main VT areas. What is necessary here is to make the change to the default
%nasal tract areas
for k=1:size(areas,1)
    Xareas(k,1:50) = [areas(k,1:44) nose0areas(k,1:6)];
end

Xareas(1,45);


for i=1:Na(1);
    i
    for j=1:N
        t.ar_tm(j,1:50) = Xareas(i,1:50);
    end
     
    %----------Calculate overall freq response (mouth + nose1 +nose2)----
    p.PL = 0;
    t.PL_tm = 0;
    t.yw = 1;
    t.visc = 1;
    [p, r, t] = ModerMouthNoise(p,c,t,Nsim);
    %[p, r, t] = ModerMouthNoiseLongPiri(p,c,t,Nsim);
    
    r.pout(1:499) = 0;
    r.foo(1:499) = 0;
    
    
    
    %----May need ----
    %    [ii,jj] = find(t.ar_tm(1,1:44)==0);
    %    if(isempty(ii) == 0)
    %        r.pout(1:end) = 0;
    %        r.foo(1:end) = 0;
    %    end
    %------------
    
    %aud = r.pout + 0.1*r.foo;
    
    skinp = CalcSkinRadPressure(r,Fs);
    aud = r.pout + skinp;
    %aud = r.pout;
    [hout,f] = ZeroPaddedSpectrum(aud(1:4096),4096,Fs);
    %[fmts,hts] = formantid(20*log10(abs(hout(10:end))),f(10:end),4);
    
    [fmts, hts,index, BW] = formant_bw_id( 20*log10(abs(hout(10:end))),f(10:end),4 );
    
    if(isempty(fmts)==0)
        for k=1:length(fmts)
            afmts(i,k) = fmts(k);
            ahts(i,k) = hts(k);
            abw(i,k) = BW(k);
        end
    else
        afmts(i,1:3) = 0;
    end
    houtmn = hout(1:466*2);
    wtrfall(i,:) = 20*log10(abs(houtmn));
    
    %     %-------Calculate freq response mouth only---
    r.fa(1:499) = 0;
    %aud = r.fa;
    aud = r.fa+skinp;
    [hout,f] = ZeroPaddedSpectrum(aud(1:4096),4096,Fs);
    houtm = hout(1:466*2);
    wtrfallm(i,:) = 20*log10(abs(houtm));
    %
    %     %-------Calculate freq response nose only---
        
        r.sig1(1:499) = 0;
        aud = r.sig1;
        [hout,f] = ZeroPaddedSpectrum(aud(1:4096),4096,Fs);
        houtn = hout(1:466*2);
        wtrfalln(i,:) = 20*log10(abs(houtn));
        
        
        
        %-------Calculate VT input impedance---
    aud = r.f+r.b;
    [z1,f] = ZeroPaddedSpectrum(aud(1:4096),4096,Fs);
    aud = r.ug;
    %aud = (t.ar_tm(j,1)/39.9)*(r.f-r.b);
    [z2,f] = ZeroPaddedSpectrum(aud(1:4096),4096,Fs);
    z = z1./z2;
    z = z1(1:466);
    
end

rx = r;
f = f(1:466*2);
z = 0;

