function Enew = GenerateEventFunctionExt(N01,Npk,N02,Ndur);
%Use this one for demos in paper
%Enew = GenerateEventFunction(5,30,55,73);

if(N01>1)
    Enew(1:N01-1) = 0;
end


na = [N01:Npk];
Enew(1:length(na)) = 0.5*(1-cos(pi*(na-N01)/(Npk-N01)));

nb = [Npk:N02];
Enew(length(na)+1:length(na)+length(nb)) = 0.5*(1+cos(pi*(nb-Npk)/(N02-Npk)));

if(length(Enew) < Ndur)
    Enew(length(Enew)+1:Ndur) = 0;
end

Enew = Enew(:);
