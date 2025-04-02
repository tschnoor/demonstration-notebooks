function b = fade(a,rt,Fs)
%
%ftme = 0.050; % 50 ms fade in and out
ftme = rt;
b = a;
dt = 1/Fs;
fi = round(ftme/dt);
%fade in
for i=1:fi
  b(i) = (1/fi)*(i-1)*a(i);
end;

%fade out
for i=length(a)-fi:length(a)
  b(i) = ((length(a)-i)/fi)*a(i);
end;
