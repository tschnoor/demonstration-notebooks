function fon = modulate_fo_evenintv(fo,modExt,modF,Fs)
%Assumes that 'fo' is a vector of fos such that they have an equal sampling
%interval
%Fs = sampling frequency e.g. 2000 Hz
%cum time

tme = [];
tme(1) = 0;


for i=2:length(fo)
   tme(i) = tme(i-1) + 1/fo(i);
end;

tme = [0:1/Fs;(length(fo)-1)/Fs];

for i=1:length(fo)
   
  %modFp = modF + rand-.5;  
  modFp = modF;  
  M = modExt*fo(i)*sin(2*pi*modFp*tme(i));
  %R = 2*(rand - .5);
  R = 1;
  %F = hzf*fo(i)/100; 
  fon(i) = R*M + fo(i); 
end;

