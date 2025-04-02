function Enew = ReTime_Estruct(E,dT);
%Nx = the new number of samples

%=======================================

        Ns = E.N;
        tmp = dT(:);
        tmp = cumsum(dT);
        xnew = tmp;
        xnew = xnew-xnew(1)+1;
        xnew(end) = ceil(xnew(end));
        


%============================

Enew = E;

for n=1:length(E.C)
    
    Enew.C(n).tmi = round(xnew(E.C(n).tmi));
    
    tmp1 = E.C(n).tmi-E.C(n).gwi/2; tmp1(tmp1<=0) = 1;
    tmp1 = xnew(round(tmp1)); 
    tmp2 = E.C(n).tmi+E.C(n).gwi/2; tmp2(tmp2>Ns) = Ns;
    tmp2 = xnew(round(tmp2)); 
    Enew.C(n).gwi = tmp2-tmp1;
    
    if(isfield(E.C(n),'sti') == 1)
        tmp2 = E.C(n).tmi+E.C(n).sti; tmp2(tmp2>Ns) = Ns;
        tmp2 = xnew(round(tmp2))-Enew.C(n).tmi; 
        tmp2(tmp2<0) = 0;
        Enew.C(n).sti = round(tmp2);  
    end
    
    
end

for n=1:length(E.V)
    
    Enew.V(n).tmi = round(xnew(E.V(n).tmi));
    
    tmp1 = E.V(n).tmi-E.V(n).gwi/2; tmp1(tmp1<=0) = 1;
    tmp1 = xnew(round(tmp1)); 
    tmp2 = E.V(n).tmi+E.V(n).gwi/2; tmp2(tmp2>Ns) = Ns;
    tmp2 = xnew(round(tmp2)); 
    Enew.V(n).gwi = tmp2-tmp1;
    
    if(isfield(E.V(n),'sti') == 1)
        tmp2 = E.V(n).tmi+E.V(n).sti; tmp2(tmp2>Ns) = Ns;
        tmp2 = xnew(round(tmp2))-Enew.V(n).tmi; 
        tmp2(tmp2<0) = 0;
        Enew.V(n).sti = round(tmp2);  
    end
    
        
end


for n=1:length(E.G)
    
    Enew.G(n).tmi = round(xnew(E.G(n).tmi));
    
    tmp1 = E.G(n).tmi-E.G(n).gwi/2; tmp1(tmp1<=0) = 1;
    tmp1 = xnew(round(tmp1)); 
    tmp2 = E.G(n).tmi+E.G(n).gwi/2; tmp2(tmp2>Ns) = Ns;
    tmp2 = xnew(round(tmp2)); 
    Enew.G(n).gwi = tmp2-tmp1;
    
    if(isfield(E.G(n),'sti') == 1)
        tmp2 = E.G(n).tmi+E.G(n).sti; tmp2(tmp2>Ns) = Ns;
        tmp2 = xnew(round(tmp2))-Enew.G(n).tmi; 
        tmp2(tmp2<0) = 0;
        Enew.G(n).sti = round(tmp2);  
    end
    
end



for n=1:length(E.R)
    
    Enew.R(n).tmi = round(xnew(E.R(n).tmi));
    
    tmp1 = E.R(n).tmi-E.R(n).gwi/2; tmp1(tmp1<=0) = 1;
    tmp1 = xnew(round(tmp1)); 
    tmp2 = E.R(n).tmi+E.R(n).gwi/2; tmp2(tmp2>Ns) = Ns;
    tmp2 = xnew(round(tmp2)); 
    Enew.R(n).gwi = tmp2-tmp1;
    
    if(isfield(E.R(n),'sti') == 1)
        tmp2 = E.R(n).tmi+E.R(n).sti; tmp2(tmp2>Ns) = Ns;
        tmp2 = xnew(round(tmp2))-Enew.R(n).tmi; 
        tmp2(tmp2<0) = 0;
        Enew.R(n).sti = round(tmp2);  
    end
    
end

    

for n=1:length(E.Nas)
    
    Enew.Nas(n).tmi = round(xnew(E.Nas(n).tmi));
    
    tmp1 = E.Nas(n).tmi-E.Nas(n).gwi/2; tmp1(tmp1<=0) = 1;
    tmp1 = xnew(round(tmp1)); 
    tmp2 = E.Nas(n).tmi+E.Nas(n).gwi/2; tmp2(tmp2>Ns) = Ns;
    tmp2 = xnew(round(tmp2)); 
    Enew.Nas(n).gwi = tmp2-tmp1;
    
    if(isfield(E.Nas(n),'sti') == 1)
        tmp2 = E.Nas(n).tmi+E.Nas(n).sti; tmp2(tmp2>Ns) = Ns;
        tmp2 = xnew(round(tmp2))-Enew.Nas(n).tmi; 
        tmp2(tmp2<0) = 0;
        Enew.Nas(n).sti = round(tmp2);  
    end
    
end




for n=1:length(E.fo)
    
    
    Enew.fo(n).tmi = round(xnew(E.fo(n).tmi));
    
    tmp1 = E.fo(n).tmi-E.fo(n).gwi/2; tmp1(tmp1<=0) = 1;
    tmp1 = xnew(round(tmp1)) ;
    tmp2 = E.fo(n).tmi+E.fo(n).gwi/2; tmp2(tmp2>Ns) = Ns;
    tmp2 = xnew(round(tmp2)); 
    Enew.fo(n).gwi = tmp2-tmp1;
    
    if(isfield(E.fo(n),'sti') == 1)
        tmp2 = E.fo(n).tmi+E.fo(n).sti; tmp2(tmp2>Ns) = Ns;
        tmp2 = xnew(round(tmp2))-Enew.fo(n).tmi; 
        tmp2(tmp2<0) = 0;
        Enew.fo(n).sti = round(tmp2);  
    end
    
end

    
Enew.N = xnew(end);
