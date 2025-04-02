function a = AddNasalOffset(Nareas,noffset);
%Nareas = q.areas(:,45);
%noffset = the target nasal offset 
%This function determines the actual offset needed so that when
%the peak amplitudes are preserved, the target offset is achieved.

a = Nareas;
Nmax = max(Nareas);

z = noffset*Nmax/(Nmax-noffset);

a = a+z;
a = Nmax*a/max(a);

