function [h,f,aud,ug,Fs,imp] = VokalTraktM_wSound(ARvect,LTvect,F0,cutoff,maxF);


%Generate voice source signal 
%F0 = 150;
Fs = 44100;
Fsp = 200;
dur = 0.5;
correxion = 5000/Fs; 
Ns = round((dur+correxion)*Fsp);


%--Make F0 contour ------
focontour = 1;
if(focontour == 1)
    f01 = 1.4*F0; f02 = F0; N = Ns;
    A = (f01-f02)/2;
    B = (f01+f02)/2;
    fo = A*cos(2*pi*[0:N-1]/(2*N)) + B;
    source_params(:,1) = fo;
else
    source_params(:,1) = F0*ones(Ns,1);
end

source_params(:,2) = 200*ones(Ns,1);
ug = flowsource(source_params,Fsp,Fs);
rt = 0.02;
ug = fade(ug,rt,Fs);

%Calculate freq response and convert to impulse resp

[h,z,f,D,h_alt,Zrad] = VokalTraktM2048(ARvect,LTvect,cutoff);
b = xfer_to_impulse(h);

aud = convolve_vox_tract(b,ug);
aud = aud/max(abs(aud));

%-----set rms value to be equiv to -15 dB  on -1 to 1 audio file scale--------------
rms_targ = 0.1778;
rms = sqrt(mean(aud.^2));
aud = (rms_targ/rms)*aud;

rt = 0.1;
aud = fade_cos(aud,rt,Fs);

imp = b;



