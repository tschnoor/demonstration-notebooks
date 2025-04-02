function mc = MovementTrajGaussian(Ndur,Npk,Mdur,Apk)

t = [1:Ndur];
A = 2*log(4);
%A = 18;
mc = Apk*exp((-A)*((t-Npk)/Mdur).^2);

% A = 2.7725 for width at the "half power" point, 18 for width at 3 standard deviations