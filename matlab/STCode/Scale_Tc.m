function Tc = Scale_Tc(Tc);

threshold = 2;
%---scaling process to ensure sum of Tc never exceeds 1.0
for n=1:length(Tc)
    b = sum(Tc(n,:));
    if(b>threshold)
        c = threshold/b;
        for k=1:length(Tc(n,:));
            Tc(n,k) = c*Tc(n,k);
        end
    end
end
%------------------------------