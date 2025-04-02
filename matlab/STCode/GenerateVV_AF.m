function [A,nqf] = GenerateVV_AF(stat,v1,v2,N,tmi,gw,amp,compress);

%load static_params_bhs96.mat stat
% load temp.mat
% stat = Znopiri(4).statnewc;
% 
% tmi = [10 60  ];
% gw = [50 60  ];
% amp = [1 0.9];
% 
% N = 73;

for n=1:length(gw)
    E(:,n) = MovementTrajGaussian(N,tmi(n),gw(n),amp(n))';
end

c = [stat.coeff(1,v1) stat.coeff(2,v1); stat.coeff(1,v2) stat.coeff(2,v2)];

for n=1:length(E(:,1))
    nqf(n,1) = E(n,1)*c(1,1) + E(n,2)*c(2,1);
    nqf(n,2) = E(n,1)*c(1,2) + E(n,2)*c(2,2);
end


if(compress == 0)
    breakpoint = 25;
    hrsh = .7;
    n = 1;
    for k=1:length(nqf)
        P(k,:) = nqf(k,1)*stat.phi(:,1)' + nqf(k,2)*stat.phi(:,2)';
        %     H(k,:) = GetConstraintFunctionX(P(k,:),breakpoint,hrsh(n));
        %     A(k,:) = (pi/4)*( stat.ne(:)' + P(k,:).*H(n,:)).^2;
        A(k,:) = (pi/4)*( stat.ne(:)' + P(k,:)).^2;
    end
    
else
    
    %----With compression------%
    a = 1.75;
    b = 2.8;
    for k=1:length(nqf)
        V = nqf(k,1)*stat.phi(:,1)' + nqf(k,2)*stat.phi(:,2)';
        V = (V+stat.ne(:)');
        V = V + ( (1/b)*exp(-a*V ).*cgauss([1:44],1.1,1,10) );
        V = (pi/4)*V.^2;
        A(k,:) = V;
    end
    
end