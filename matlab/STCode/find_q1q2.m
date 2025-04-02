function [q1,q2,y] = find_q1q2(dbase,F)
%


%[x,y]=min(( dbase.fmts(:,1) - F(1)).^2 + ( dbase.fmts(:,2) - F(2)).^2 );

[x,y]=min(( dbase.fmtsN(:,1) - F(1)).^2 + ( dbase.fmtsN(:,2) - F(2)).^2 );

q1 = dbase.coeffs(y,1);
q2 = dbase.coeffs(y,2);


