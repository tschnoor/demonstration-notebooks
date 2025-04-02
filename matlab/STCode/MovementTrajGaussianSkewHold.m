function mc = MovementTrajGaussianSkewHold(Ndur,Npk,Mdur,Apk,Qs,Nhold,Nholdflag)

t = [1:Ndur];
A = 2*log(4);

pflag = 1;

if(Apk < 0)
    pflag = -1;
    Apk = abs(Apk);
end



Mdur2 = Mdur/(1+Qs);
Mdur1 = Qs*Mdur/(1+Qs);


if(Nholdflag == 1)
    %---This places the Npk in the middle of the Nhold----
    R1 = Npk-Nhold/2;
    R1(R1<1) = 1;
    R2 = Npk+Nhold/2;
    R2(R2<1) = 1;
    %-------------------------------------------------------
    
else
    %---This places the Npk at the beginning of the Nhold----
    R1 = Npk;
    R1(R1<1) = 1;
    R2 = Npk+Nhold;
    R2(R2<1) = 1;
    %------------------------------------------------------
end


mc1 = Apk*exp((-A)*((t-R1)/(2*Mdur1)).^2);
mc2 = Apk*exp((-A)*((t-R2)/(2*Mdur2)).^2);


[i,xc1] = max(mc1);
[i,xc2] = max(mc2);

c = mc1;
c(xc1:xc2) = Apk;
if(xc2 < Ndur)
    c(xc2:end) = mc2(xc2:end);
end

c = max(c,0);



mc =c;
mc = c*pflag;

% A = 2.7725 for width at the "half power" point, 18 for width at 3 standard deviations

