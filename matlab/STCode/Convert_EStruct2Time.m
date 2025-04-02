function Ems = Convert_EStruct2Time(E,fs)

Ems = E;
sf = 1000/fs;

for n=1:length(Ems)
    Ems(n).N = E(n).N * sf;
    
    for k=1:length(E(n).C)
        Ems(n).C(k).tmi = round( (E(n).C(k).tmi-1) * sf);
        Ems(n).C(k).gwi = round(E(n).C(k).gwi * sf);
        if(isfield(E(n).C(k),'sti'));
            Ems(n).C(k).sti = round(E(n).C(k).sti * sf);
        end
    end
    
    for k=1:length(E(n).V)
        Ems(n).V(k).tmi = round((E(n).V(k).tmi-1) * sf);
        Ems(n).V(k).gwi = round(E(n).V(k).gwi * sf);
        if(isfield(E(n).V(k),'sti'));
            Ems(n).V(k).sti = round(E(n).V(k).sti * sf);
        end
    end
    
    for k=1:length(E(n).G)
        Ems(n).G(k).tmi = round((E(n).G(k).tmi-1) * sf);
        Ems(n).G(k).gwi = round(E(n).G(k).gwi * sf);
        if(isfield(E(n).G(k),'sti'));
            Ems(n).G(k).sti = round(E(n).G(k).sti * sf);
        end
    end
    
    for k=1:length(E(n).R)
        Ems(n).R(k).tmi = round((E(n).R(k).tmi-1) * sf);
        Ems(n).R(k).gwi = round(E(n).R(k).gwi * sf);
        if(isfield(E(n).R(k),'sti'));
            Ems(n).R(k).sti = round(E(n).R(k).sti * sf);
        end
    end
    
    for k=1:length(E(n).Nas)
        Ems(n).Nas(k).tmi = round((E(n).Nas(k).tmi-1) * sf);
        Ems(n).Nas(k).gwi = round(E(n).Nas(k).gwi * sf);
        if(isfield(E(n).Nas(k),'sti'));
            Ems(n).Nas(k).sti = round(E(n).Nas(k).sti * sf);
        end
    end
    
    for k=1:length(E(n).fo)
        Ems(n).fo(k).tmi = round((E(n).fo(k).tmi-1) * sf);
        Ems(n).fo(k).gwi = round(E(n).fo(k).gwi * sf);
        if(isfield(E(n).fo(k),'sti'));
            Ems(n).fo(k).sti = round(E(n).fo(k).sti * sf);
        end
    end
    
end
