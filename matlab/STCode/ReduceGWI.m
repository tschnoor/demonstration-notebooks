function Enew = ReduceGWI(E,sf);
Enew = E;

for n=1:length(E.C)
    
    if(E.C(n).rdp(4)>= 0.93)
        Enew.C(n).gwi = ceil(E.C(n).gwi * sf);
    else
        Enew.C(n).gwi = ceil(E.C(n).gwi*1.);
    end
    
end

for n=1:length(E.G)
    
    Enew.G(n).gwi = ceil(E.G(n).gwi * sf);
end

for n=1:length(E.R)
    Enew.R(n).gwi = ceil(E.R(n).gwi * sf);
end

for n=1:length(E.Nas)
    
    Enew.Nas(n).gwi = ceil(E.Nas(n).gwi * 1);
    
end


    
    