function mc = MovementTrajGaussianSkew(Ndur,Npk,Mdur,Apk,Qs)

t = [1:Ndur];
A = 2*log(4);

pflag = 1;

if(Apk < 0)
    pflag = -1;
    Apk = abs(Apk);
end



Mdur2 = Mdur/(1+Qs);
Mdur1 = Qs*Mdur/(1+Qs);

mc1 = Apk*exp((-A)*((t-Npk)/(2*Mdur1)).^2);
mc2 = Apk*exp((-A)*((t-Npk)/(2*Mdur2)).^2);

[i,xc1] = max(mc1);
[i,xc2] = max(mc2);

if(xc1 == xc2)
    c = mc1;
    c(xc2:end) = mc2(xc2:end);
    c = max(c,0);
    
else
    disp('Something is amiss! xc1~=xc2');
    c = 0*t;
end


mc =c;
mc = c*pflag;

% A = 2.7725 for width at the "half power" point, 18 for width at 3 standard deviations

