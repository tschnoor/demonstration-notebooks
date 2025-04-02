function Enew = LinkWords(E,dT,dP)

%---amount of time to add between words---
if(isempty(dT)==1)
    dT = 6;
end

if(isempty(dP) == 1)
    dP = -0.4;
end

word = [];

Ntot = dT*(length(E)-1);
for n =1:length(E)
    Ntot = Ntot + E(n).N;
    word = [word ' ' E(n).word];
end

Enew.word = word;
Enew.cflag = E(1).cflag;
Enew.N = Ntot;
Enew.stat = E(1).stat;


enC = 1;
enG = 1;
enR = 1;
enN = 1;
enV = 1;
enF0 = 1;

Noffset = 0;
for n =1:length(E)
    
    for k=1:length(E(n).C)
        Enew.C(enC) = E(n).C(k);
        Enew.C(enC).tmi = Enew.C(enC).tmi + Noffset;
        enC = enC+1;
    end
        
    for k=1:length(E(n).V)
        Enew.V(enV) = E(n).V(k);
        Enew.V(enV).tmi = Enew.V(enV).tmi + Noffset;
        enV = enV+1;
    end
    
    for k=1:length(E(n).G)
        Enew.G(enG) = E(n).G(k);
        Enew.G(enG).tmi = Enew.G(enG).tmi + Noffset;
        enG = enG+1;
    end
    
    for k=1:length(E(n).R)
        Enew.R(enR) = E(n).R(k);
        Enew.R(enR).tmi = Enew.R(enR).tmi + Noffset;
        enR = enR+1;
    end
    %---break between words-------
    Enew.R(enR).sfPL = dP;
    Enew.R(enR).tmi = E(n).N + Noffset+ceil(dT/2);
    Enew.R(enR).gwi = dT;
    Enew.R(enR).skw = 1;
    enR = enR+ 1;
    %-----------------------------
    
    for k=1:length(E(n).Nas)
        Enew.Nas(enN) = E(n).Nas(k);
        Enew.Nas(enN).tmi = Enew.Nas(enN).tmi + Noffset;
        enN = enN+1;
    end
    
    for k=1:length(E(n).fo)
        Enew.fo(enF0) = E(n).fo(k);
        Enew.fo(enF0).tmi = Enew.fo(enF0).tmi + Noffset;
        enF0 = enF0+1;
    end
    
   
    Noffset = Noffset + E(n).N+dT;
end