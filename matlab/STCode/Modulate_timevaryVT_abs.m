function areasN = Modulate_timevaryVT_abs(areas,nLoc,nW,amod,FM,fsvt);

%ar = area vector;
%nLoc = area section to focus the deformation
%nW = width in sections of Gaussian
%amod = amount of area in cm2 to modulate
%dur = duration of modulation in seconds
%FM = frequency (in Hz) of the modulation
%fsvt = sampling frequency for area function modulation (not audio;
%typically 146 Hz)



nAR = 44;

mc = MovementTrajGaussianSkew(nAR,nLoc,nW,1,1);
mc = mc(:)';

dur = size(areas,1);
tm = [0:1/fsvt:(dur-1)/fsvt];
sigmod = amod*sin(2*pi*FM*tm);


size(tm)
for n = 1:length(tm)
    
    ar = areas(n,1:nAR);
    areasN(n,1:nAR) = ar + mc*sigmod(n);
    
end


if(size(areas,2) == 45)
    areasN(:,45) = areas(:,45);
end






