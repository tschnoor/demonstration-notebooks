function R = Write_RDP_Table(E);

tmc = [];
for n=1:length(E.C)
    tmc(n) = E.C(n).tmi;
    Dc(:,n) = E.C(n).rdp(end:-1:1);
end

tmg = [];
for n=1:length(E.G)
    tmg(n) = E.G(n).tmi;
    Dg(n) = E.G(n).xi;
end

tmn = [];
for n=1:length(E.Nas)
    tmn(n) = E.Nas(n).tmi;
    Dn(n) = E.Nas(n).arnas;
end

tmf = [];
for n=1:length(E.fo)
    tmf(n) = E.fo(n).tmi;
    Df(n) = E.fo(n).sffo;
end

tm = union(union(union(tmc,tmg),tmn),tmf);

R = zeros(7,length(tm));

c = 1;
g = 1;
nx = 1;
f = 1;

for n = 1:length(tm)
    
    if(c<=length(tmc))
        if(tmc(c)==tm(n))
            R(1:4,n) = Dc(:,c);
            c = c+1;
        end
    end
    
    if(g<=length(tmg))
        if(tmg(g)==tm(n))
            R(5,n) = Dg(g);
            g = g+1;
        end
    end
    
    if(nx<=length(tmn))
        if(tmn(nx)==tm(n))
            R(6,n) = Dn(nx);
            nx = nx+1;
        end
    end
    
    if(f<=length(tmf))
        if(tmf(f)==tm(n))
            R(7,n) = Df(f);
            f = f+1;
        end
    end
    
end

R(8,:) = tm;
R(9,:) = round(tm*6.866);

writematrix(R,'R.txt','Delimiter','tab');
writematrix(R,'R.xls','AutoFitWidth',1,'PreserveFormat',false)

