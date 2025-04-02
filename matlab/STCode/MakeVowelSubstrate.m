function vareas = MakeVowelSubstrate(Ev,Cv,stat);


q1 = zeros(size(Ev,1),1);
q2 = q1;

for n=1:size(Ev,2)
    q1 = q1 + Ev(:,n)*Cv(1,n);
    q2 = q2 + Ev(:,n)*Cv(2,n);
end

for n = 1:length(q1)
    V(n,:) = (pi/4)*(stat.ne + q1(n)*stat.phi(:,1) + q2(n)*stat.phi(:,2)).^2;
end

vareas = V;
    
    