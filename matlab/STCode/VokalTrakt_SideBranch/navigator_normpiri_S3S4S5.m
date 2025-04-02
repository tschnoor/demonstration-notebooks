function [sf,vfmts,areas] = navigator_normpiri_S3S4S5(ar0,f3n,f4n,f5n,Ap,Lp,N_piri,atype, tol);
%M = 1, use m = S3+S4;
%M = 2, use m = S3-S4;
%M = 3, use m = -(S3+S4);
%M = 4, use m = S4-S3;
%N = number of iterations



%
accel = 5;
areas = [];
areas(1,:) = ar0';
lsd = 100000;
i=1;
while  (lsd > tol)
    
    
    
    [S,B,K,P,fmts,Press,Flow] = sens_functions_sbranch(areas(i,:)',.396825,Ap,Lp,N_piri,'y');
    sf(i).S = S;
    
     vfmts(i,:) = fmts(1:5);
     
     
     x = f3n - fmts(3);
     y = f4n - fmts(4);
     z = f5n - fmts(5);
     
     
     z1 =x/fmts(1) * accel; 
     z2 = y/fmts(2) * accel;
     z3 = z/fmts(3)*accel;
     
     %lsd = sqrt(x^2 + y^2 + z^2)
     lsd = sqrt(z1^2 + z2^2 + z3^2)
    
    m = z1*S(:,3) + z2*S(:,4) + z3*S(:,5);
    
   

  
    
    sf(i).m = m;
    %areas(i+1,:) = areas(i,:) + m';
    
    
    if(atype ==1 )
    %---- Use log areas to avoid negative areas  -- compressor
    temp = areas(i,:);
    a = log(m'+1) + log(temp);
    areas(i+1,:) = exp(a);
  
elseif(atype ==2)
   
    
    %---- Use log areas only when area are less than 1  -- compressor
    temp = areas(i,:);
    [r,g]= find(log(temp) < 0);
    a = m' + temp;
    a(g) = exp(log(m(g)'+1) + log(temp(g)));
    
    areas(i+1,:) = a;
   
end
  i = i+1;


end;

