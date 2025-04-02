function H = GetConstraintFunctionX(P,harshness)
% P = P(x) = perturbation function to be modified (constrained)
% P should have 44-elements

P = P/max(abs(P));

%---These could be moved outside of function-----
%Y0 = MovementTrajCos([1 4 25 32 44],[0 .3 .3 1 1]);
%Y0 = MovementTrajCos([1  44],[1  0]);

 x = [1:44];
 
 Y0 = harshness*1./(1+exp(.2*(x-30)));
%---------------------------------

for n=1:length(P)
    H(n) = Y0(n)*1/(1+exp(4*(P(n))))+(1-Y0(n));
end

