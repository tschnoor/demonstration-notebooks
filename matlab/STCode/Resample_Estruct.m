function Enew = Resample_Estruct(E,Nx,xisc,plsc,fosc);
%Nx = the new number of samples


sf = Nx/E.N;

for n=1:length(E.C)
    E.C(n).tmi = round(E.C(n).tmi * sf);
    E.C(n).gwi = round(E.C(n).gwi * sf);
    
    if(isfield(E.C(n),'sti') == 1)
        E.C(n).sti = round(E.C(n).sti * sf);
    end
    
    %----rdp scaling (may not want this)-----
    if(E.C(n).rdp(4) >= 1 & sf < 1)
        tmp = (sf^1.5)*E.C(n).rdp(4);
        tmp(tmp<1) = 1;
        E.C(n).rdp(4) = tmp;
    elseif(E.C(n).rdp(4) < 0.94)
        tmp = (sf.^1.5)*E.C(n).rdp(4);
        tmp(tmp>0.94) = 0.94;
        E.C(n).rdp(4) = tmp;
    end
    
    disp('RDP scaling is ON');
    %---------------------------------
end

for n=1:length(E.V)
    E.V(n).tmi = round(E.V(n).tmi * sf);
    E.V(n).gwi = round(E.V(n).gwi * sf);
    
    if(isfield(E.V(n),'sti') == 1)
        E.V(n).sti = round(E.V(n).sti * sf);
    end
end

for n=1:length(E.G)
    E.G(n).tmi = round(E.G(n).tmi * sf);
    E.G(n).gwi = round(E.G(n).gwi * sf);
    
    if(isfield(E.G(n),'sti') == 1)
        E.G(n).sti = round(E.G(n).sti * sf);
    end
    
    if(xisc == 1)
    %----adduction scaling (may not want this)-----
    
        E.G(n).xi = sqrt(sf)*E.G(n).xi;
    
    %---------------------------------
    end
    
end

for n=1:length(E.R)
    E.R(n).tmi = round(E.R(n).tmi * sf);
    E.R(n).gwi = round(E.R(n).gwi * sf);
    
    if(isfield(E.R(n),'sti') == 1)
        E.R(n).sti = round(E.R(n).sti * sf);
    end
    
    if(plsc == 1)
    %----Pressure scaling (may not want this)-----
    
        E.R(n).sfPL = sqrt(sf)*E.R(n).sfPL;
    
    %---------------------------------
    end
    
end

    

for n=1:length(E.Nas)
    E.Nas(n).tmi = round(E.Nas(n).tmi * sf);
    E.Nas(n).gwi = round(E.Nas(n).gwi * sf);
    
    if(isfield(E.Nas(n),'sti') == 1)
        E.Nas(n).sti = round(E.Nas(n).sti * sf);
    end
end

for n=1:length(E.fo)
    E.fo(n).tmi = round(E.fo(n).tmi * sf);
    E.fo(n).gwi = round(E.fo(n).gwi * sf);
    
    if(isfield(E.fo(1),'sti') == 1)
        E.fo(n).sti = round(E.fo(n).sti * sf);
    end
    
    if(fosc == 1)
    %----F0 scaling (may not want this)-----
    
        E.fo(n).sffo = sqrt(sf)*E.fo(n).sffo;
    
    %---------------------------------
    end
    
end

    

Enew = E;
Enew.N = Nx;
