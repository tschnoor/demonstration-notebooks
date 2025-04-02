function vareas = MakeVowelSubstrate_Tv_scaled(Tv,V,stat);


%---scaling process to ensure sum of Tv never exceeds 1.0
for n=1:length(Tv)
    b = sum(Tv(n,:));
    if(b>1)
        c = 1/b;
        for k=1:length(Tv(n,:));
            Tv(n,k) = c*Tv(n,k);
        end
    end
end
%------------------------------
        
q1 = zeros(size(Tv,1),1);
q2 = q1;

for n=1:length(V)
    q1 = q1 + Tv(:,n)*V(n).Q(1);
    q2 = q2 + Tv(:,n)*V(n).Q(2);
end



for n = 1:length(q1)
    A(n,:) = (pi/4)*(stat.ne + q1(n)*stat.phi(:,1) + q2(n)*stat.phi(:,2)).^2;
end

vareas = A;
    
    