function [q1,q2,y] = find_q1q2(dbase,F)
%
%[x,y]=min((F12(:,1) - F(1)).^2 + (F12(:,2) - F(2)).^2 + ...
 % (F12(:,3) - F(3)).^2 );

[x,y]=min(( dbase.fmts(:,1) - F(1)).^2 + ( dbase.fmts(:,2) - F(2)).^2 );
%[x,y]=min(( dbase.fmts2(:,1) - F(1)).^2 + ( dbase.fmts2(:,2) - F(2)).^2 );
%disp('using dbase.fmts2 !!!');
%[x,y]=min(( dbase.nfmts(:,1) - F(1)).^2 + ( dbase.nfmts(:,2) - F(2)).^2 );

q1 = dbase.coeffs(y,1);
q2 = dbase.coeffs(y,2);


