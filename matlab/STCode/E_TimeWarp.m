function Enew = E_TimeWarp(E,tvect);


a = cumsum(tvect);
r = length(a)/a(end);

tvectX = cumsum(tvect*r);
tvectX = round(tvectX);

for n=1:length(E.C)
    E.C(n).tmi = tvectX(E.C(n).tmi);   
end

for n=1:length(E.V)
    E.V(n).tmi = tvectX(E.V(n).tmi);  
end

for n=1:length(E.G)
    E.G(n).tmi = tvectX(E.G(n).tmi)
end

for n=1:length(E.R)
    E.R(n).tmi = tvectX(E.R(n).tmi)
end

for n=1:length(E.Nas)
    E.Nas(n).tmi = tvectX(E.Nas(n).tmi)
end

for n=1:length(E.fo)
    E.fo(n).tmi = tvectX(E.fo(n).tmi)
end

Enew = E;
