function vareas = MakeVowelSubstrate_Ev(Tv,V,stat);


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
    
    