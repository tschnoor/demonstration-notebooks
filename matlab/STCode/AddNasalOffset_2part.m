function [a,a1,a2] = AddNasalOffset_2part(Nareas,noffset);
%Nareas = q.areas(:,45);
%noffset = the target nasal offset 
%This function determines the actual offset needed so that when
%the peak amplitudes are preserved, the target offset is achieved.

a = Nareas;
Nmax1 = max(Nareas(1:100));
Nmax2 = max(Nareas(101:end));

z1 = noffset*Nmax1/(Nmax1-noffset);
z2 = noffset*Nmax2/(Nmax2-noffset);

a1 = a(1:100)+z1;
a2 = a(101:end)+z2;
a1 = Nmax1*a1/max(a1);
a2 = Nmax2*a2/max(a2);

clear a
a = [a1(:); a2(:)];



