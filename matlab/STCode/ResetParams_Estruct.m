function Enew = ResetParams_Estruct(E)

Enew = E;

for n = 1:length(E.C)
    
    Enew.C(n).skw = 1;
    Enew.C(n).rdp(4) = Enew.C(n).rdp(4)*0.95;
    
end
