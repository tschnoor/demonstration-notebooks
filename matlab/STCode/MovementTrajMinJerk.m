function mc = MovementTrajMinJerk(Ndur,Npk,Mdur,Apk);

M_halfw = floor(Mdur/2);

a = jerkinterpN(0,Apk,M_halfw);
b = jerkinterpN(Apk,0,M_halfw);

mc = zeros(Ndur,1);

mc(Npk-M_halfw:Npk+M_halfw-1) = [a(:);b(:)];



