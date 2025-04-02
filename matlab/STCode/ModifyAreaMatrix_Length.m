function Anew = ModifyAreaMatrix_Length(A,dL);

    flag = 0;
    Nsect = size(A,2);
    
    if(Nsect ==45)
        Anas = A(:,Nsect);
        A = A(:,1:Nsect-1);
        Nsect = Nsect-1;
        flag = 1;
    end
    
    xold = make_lengthv(dL);
    xold = xold-xold(1);
    xnew = [0:xold(end)/(Nsect-1):xold(end)];
    
    for n=1:size(A,1)
        Anew(n,:) = interp1(xold(:)',A(n,:),xnew(:)','spline');
    end
    


if(flag == 1)
    Anew(:,45) = Anas(:)';
end



    