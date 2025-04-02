function Anew = ModifyAreaMatrix_Time(A,dT);

Ns = size(A,1);

tmp = ones(1,Ns).*dT(:)';
tmp = cumsum(tmp);
xold = tmp;

xold = xold-xold(1);
xnew = [0:xold(end)/(Ns-1):xold(end)];

for n = 1:size(A,2)
    Anew(:,n) = interp1(xold,A(:,n),xnew,'spline');
end

