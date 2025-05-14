function b = fadein_cos(a,rt,Fs)
%

ftme = rt;
b = a;
dt = 1/Fs;
fi = round(ftme/dt);
f01 = 0;
f02 = 1;
%fade in

A = (f01-f02)/2;
B = (f01+f02)/2;

c = A*cos(2*pi*[0:fi-1]/(2*fi)) + B;

b(1:fi) = a(1:fi).*c;







