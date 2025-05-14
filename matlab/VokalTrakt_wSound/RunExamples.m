



load('STH96_origvowels.mat')
lv = 0.4*ones(44,1);
F0 = 120;
cutoff = 50;
maxF = 5000;

% Male /a/
[h,f,aud,ug,Fs,imp] = VokalTraktM_wSound(aa,lv,F0,cutoff,maxF);
%the first sound played is the speech sample, the second is the raw impulse
%response of the vocal tract 
soundsc(aud,Fs); pause(1); soundsc(imp,Fs);

pause(1)

% Male /i/
[h,f,aud,ug,Fs,imp] = VokalTraktM_wSound(ii,lv,F0,cutoff,maxF);
soundsc(aud,Fs); pause(1); soundsc(imp,Fs);

pause(1)

% Male /i/
[h,f,aud,ug,Fs,imp] = VokalTraktM_wSound(uu,lv,F0,cutoff,maxF);
soundsc(aud,Fs); pause(1); soundsc(imp,Fs);

pause(1)

% Female-like /a/
lv = 0.34*ones(44,1);
F0 = 220;
[h,f,aud,ug,Fs,imp] = VokalTraktM_wSound(aa,lv,F0,cutoff,maxF);
soundsc(aud,Fs); pause(1); soundsc(imp,Fs);

pause(1)

% Female-like /i/
lv = 0.34*ones(44,1);
F0 = 220;
[h,f,aud,ug,Fs,imp] = VokalTraktM_wSound(ii,lv,F0,cutoff,maxF);
soundsc(aud,Fs); pause(1); soundsc(imp,Fs);

pause(1)

% Female-like /u/
lv = 0.34*ones(44,1);
F0 = 220;
[h,f,aud,ug,Fs,imp] = VokalTraktM_wSound(uu,lv,F0,cutoff,maxF);
soundsc(aud,Fs); pause(1); soundsc(imp,Fs);

