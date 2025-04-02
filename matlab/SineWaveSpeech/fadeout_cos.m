function b = fadeout_cos(a,rt,Fs)
%

ftme = rt;
b = a;
dt = 1/Fs;
fi = round(ftme/dt);
f01 = 1;
f02 = 0;


A = (f01-f02)/2;
B = (f01+f02)/2;

c = A*cos(2*pi*[0:fi-1]/(2*fi)) + B;

b(end-fi+1:end) = a(end-fi+1:end).*c;







