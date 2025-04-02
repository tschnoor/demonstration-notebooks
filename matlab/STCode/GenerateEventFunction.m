function Enew = GenerateEventFunction(N01,Npk,N02,Ndur);
%Use this one for demos in paper
%Enew = GenerateEventFunction(5,30,55,73);

if(N01>1)
    Enew(1:N01-1) = 0;
end


n = [N01:Npk];
Enew(N01:Npk) = 0.5*(1-cos(pi*(n-N01)/(Npk-N01)));

n = [Npk:N02];
Enew(Npk:N02) = 0.5*(1+cos(pi*(n-Npk)/(N02-Npk)));

if(N02 < Ndur)
    Enew(N02+1:Ndur) = 0;
end

Enew = Enew(:);
