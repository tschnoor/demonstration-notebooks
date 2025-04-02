function H = GetConstraintFunction(P)
% P = P(x) = perturbation function to be modified (constrained)
% P should have 44-elements
ypk = -.2;

%---These could be moved outside of function-----
%Y0 = MovementTrajCos([1 4 25 32 44],[0 .3 .3 1 1]);
Y0 = MovementTrajCos([1  44],[0  1]);
Yext = 0.2*ones(44,1);
%---------------------------------

for n=1:length(P)
    H(n) = ConstraintValue(P(n),Y0(n),Yext(n),ypk);
end

