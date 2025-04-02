function areasN = Modulate_VT_abs(ar,nLoc,nW,amod,dur,FM,fsvt);

%ar = area vector;
%nLoc = area section to focus the deformation
%nW = width in sections of Gaussian
%amod = amount of area in cm2 to modulate
%dur = duration of modulation in seconds
%FM = frequency (in Hz) of the modulation
%fsvt = sampling frequency for area function modulation (not audio;
%typically 146 Hz)


ar = ar(:)';
nAR = length(ar);

mc = MovementTrajGaussianSkew(nAR,nLoc,nW,1,1);
mc = mc(:)';

tm = [0:1/fsvt:dur];
sigmod = amod*sin(2*pi*FM*tm);


for n = 1:length(tm)
    
    areasN(n,1:nAR) = ar + mc*sigmod(n);
    
end







