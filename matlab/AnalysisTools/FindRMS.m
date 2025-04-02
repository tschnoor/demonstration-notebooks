function [rms,t,dtn] = FindRMS(sig,dt,Fs)
%calculates rms values of signal in time period defined by dt

N = round(dt*Fs);
dtn = N/Fs;
rms = [];

j = 1;
for i = 1:N:length(sig)-N
	x = sig(i:(i-1)+N);
	x = x .^ 2;
	x = mean(x);
	x = sqrt(x);
   rms(j) = x;
   t(j) = (dtn/2) + (j-1)*dtn;
	j = j+1;
end;


