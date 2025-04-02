function mc = MovementTrajGaussianHold_test(Ndur,Npk,Nw,Apk,Nh);

t = [1:Ndur];
A = 2*log(4);

pflag = 1;

if(Apk < 0)
    pflag = -1;
    Apk = abs(Apk);
end

for n=1:Ndur
    if(n <= Npk-Nh/2-1)
        mc(n) = Apk*exp((-A)*((n-(Npk-Nh/2))/Nw).^2);
    elseif(n>=Npk-Nh/2 & n<=Npk+Nh/2)
        mc(n) = 1;
    else
        mc(n) = Apk*exp((-A)*((n-(Npk+Nh/2))/Nw).^2);
    end
end


mc = mc*pflag;

% A = 2.7725 for width at the "half power" point, 18 for width at 3 standard deviations

