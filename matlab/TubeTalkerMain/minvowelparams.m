function f = minvowelparams(p,af_cons,phi,ne,i1,i2)
%to run an optimization use this line at the command prompt
%[p,out] = fminsearch('minfmts',[1,0.1],[1,20,20,0,0,0,0,0,0,0,0,0,0,100],[],y1,y2,mp',[728 1174 2736]);

x = af_cons(:,1)';
%dx = diff(mcons);
%dx = dx(1);
p;


[af,V,Ct,Lvectnew,xnew] = TubeTalker([1:44],phi,ne,'g',[p(1) p(2)],41,0.03,0,8,.3,0,0,7,4,0,17.5,4);
 
    
%p(1) = q1;
%p(2) = q2;
%p(3) = lc;
%p(4) = ac;
%p(5) = rc;
%p(6) = qs;

f = af_cons(i1:i2,2) - af(i1:i2);
f = sum(f.^2);
