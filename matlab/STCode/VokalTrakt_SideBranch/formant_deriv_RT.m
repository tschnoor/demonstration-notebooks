function [fmts, hts, index] = formantid_deriv_RT(spectra, freq, numformants);
%spectra = a  spectrum from which peaks will be found - usually LPC based
%freq = frequency vector that coincides with spectra
%numformants = is the number of formants to be found

fmts = [];
hts = [];
index = [];

%df is the frequency interval
df = freq(2)-freq(1);
ospectra = spectra; %copy original for later use

%Calculate the derivative of the spectrum and normalize; 
tmp = gradient(spectra)*40;
tmp = tmp-max(tmp) +max(spectra)/2;
spectra = tmp;

%=================================
%The concept is that in the derivative spectrum each formant frequency lies
%between a peak and a valley - kind of looks like an impedance curve. So
%we'll first find the peaks, then the valleys and find the frequency that
%is halfway between them.
%================================

%---First find all of the peaks in the derivative spectrum----
ipeak = [] ;
peak = [];
Aup = [];
for i = 2:length(spectra)-1
    if( (spectra(i-1) < spectra(i)) & ...
            (spectra(i+1) < spectra(i) ) )
        fprm = (spectra(i+1) - spectra(i-1))/(2*df);
        fprm2 = (spectra(i+1) - 2*spectra(i)+spectra(i-1))/(df^2);
        corr = -fprm/fprm2;
        peak = 	[peak  freq(i)+corr ] ;
        Aup  =  [Aup   spectra(i)] ;
        ipeak = [ipeak i];
    end ;
end ;

%---Second,  find all the valleys in the derivative spectrum------
ivalley = [] ;
valley = [];
Adown = [];
ind = 1;
for i = 2:length(spectra)-1
    if( (spectra(i) < spectra(i-1)) & ...
            (spectra(i) < spectra(i+1) ) )
        fprm = (spectra(i+1) - spectra(i-1))/(2*df);
        fprm2 = (spectra(i+1) - 2*spectra(i)+spectra(i-1))/(df^2);
        corr = -fprm/fprm2;
        if(i>ipeak(ind))
            valley = 	[valley  freq(i)+corr ] ;
            Adown  =  [Adown   spectra(i)] ;
            ivalley = [ivalley i];
            ind = ind +1;
        end
    end ;
end ;

if(length(peak) > length(valley))
     peak = peak(1:length(valley));
     Aup = Aup(1:length(valley));
     ipeak = ipeak(1:length(valley));
elseif(length(peak) < length(valley))
    valley = valley(1:length(peak));
    Adown = Adown(1:length(peak));
    ivalley = ivalley(1:length(peak));
end


if(isempty(Aup) == 0 && isempty(Adown)==0)
    pts = (Aup-Adown)/2 ;  %half height points
else
    pts = 0;
end

% %----Eliminate points that are suspicious---
vthresh = 2;
n = find(abs(pts)>vthresh);
if(isempty(n)==0)
    pts = pts(n);
    Aup = Aup(n);
    Adown = Adown(n);
    peak = peak(n);
    valley = valley(n);
    ipeak = ipeak(n);
    ivalley = ivalley(n);
end
pts = pts+Adown;

clear n 

%---Now determine the formant frequencies



for n=1:length(pts)
    ftmp = freq(ipeak(n):ivalley(n)) - freq(ipeak(n));
    stmp = ospectra(ipeak(n):ivalley(n));
    fnew = [ftmp(1):1:ftmp(end)];
    snew = interp1(ftmp,stmp,fnew,'spline');
    
    fpk = -10000;
    for k=2:length(snew)-1
        if(snew(k-1)<snew(k) && snew(k+1)<snew(k))
            fpk = fnew(k);
            ipk = k;
        end
    end
    
    if(fpk > -10000)
        fmts(n) =  fpk + freq(ipeak(n));
        hts(n) = snew(ipk);
    elseif(fpk == -10000)
    
        atmp = spectra(ipeak(n):ivalley(n));
        anew = interp1(ftmp,atmp,fnew,'spline');
        [i,j] = min(abs(anew-pts(n)));
        fmts(n) = fnew(j) + freq(ipeak(n));
        [i,j] = min(abs(freq-fmts(n)));
        hts(n) = ospectra(j);
        
    end
    
end
    

% %----Now determine the formant frequencies
% fmts = peak + (valley-peak)/2;
% 
% %----Now find hts in original spectra
% for n=1:length(fmts)
%     [i,j] = min(abs(freq-fmts(n)));
%     hts(n) = ospectra(j);
% end

if(isempty(fmts)==1)
    fmts = zeros(1,numformants);
    hts = fmts;
    index = fmts;
end

[i,j] = find(fmts>300);
fmts = fmts(j);
hts = hts(j);

if (length(fmts) > numformants)
   fmts = fmts(1:numformants);
   hts = hts(1:numformants);
end;

for n=1:length(fmts)
     [i,j] = min(abs(freq-fmts(n)));
     index(n) = j;
end

if(isempty(index) == 1)
    index = 0;
end


    


