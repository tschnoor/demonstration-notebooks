function [M,G,Nas] = DisplayEventMatrix(E)

fsa = 146;
mxG = 1;
mxNas = 1;

for n = 1:length(E.G)
    G(1,n) = E.G(n).tmi/E.N;
    G(2,n) = E.G(n).xi/mxG;
    
end

for n = 1:length(E.Nas)
    Nas(1,n) = E.Nas(n).tmi/E.N;
    Nas(2,n) = E.Nas(n).arnas/mxNas;
   
end

for n = 1:length(E.C)
    
    M(1,n) = E.C(n).tmi/E.N;
    M(2:5,n) = E.C(n).rdp(end:-1:1)';   
    
end

for n = 1:size(G,2)
    [i,j] = min(abs(G(1,n)-M(1,:)));
    G(3,n) = j;
    M(6,j) = G(2,n);
end

for n = 1:size(Nas,2)
    [i,j] = min(abs(Nas(1,n)-M(1,:)));
    Nas(3,n) = j;
    M(7,j) = Nas(2,n);
end
