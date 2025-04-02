function b = fadeout(a,rt,Fs)
%
ftme = rt; %  fade in and out
b = a;
dt = 1/Fs;
fi = round(ftme/dt);

%fade out
for i=length(a)-fi:length(a)
  b(i) = ((length(a)-i)/fi)*a(i);
end;
