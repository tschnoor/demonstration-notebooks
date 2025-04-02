function [aud,b,Fx,Hx] = SWS(F,H,Fins,Fouts);
%SWS.m:  function to generate Sine Wave Speech from time-varying formants
%Author: B. Story
%Last updated: 04.18.13
%INPUTS:
%F = matrix of formants  (could be from Praat or other formant tracking)
% (be careful with formants from Praat - the first column in the F matrix
% is usually the time vector, so the input in that case should be
% F(:,2:end) in order to ignore the first column
%H = formant amplitudes - if H is empty (' []') then all formants have constant amplitude
%Fins = the sampling frequency of the time-varying formants in F
%Fouts = the desired output (audio) sampling frequency (typically 22050 or 44100 Hz)
%OUTPUTS:
%aud = sine wave speech signal
%b = matrix of each individual sine wave

if(isempty(H) == 1)
    H = 40+0*F;
end

a = size(F);
Tend = (a(1)-1)/Fins;
N = a(2);

%Resample formants (F) and amplitudes (H) to audio sampling frequency
for i=1:N
    Fx(:,i) = interp1([0:1/Fins:Tend],F(:,i),[0:1/Fouts:Tend])';
    Hx(:,i) = interp1([0:1/Fins:Tend],H(:,i),[0:1/Fouts:Tend])';
end

a = size(F);
N = a(2);
dtt = 1/Fouts;
freqp = 0;
theta = 0;

b = 0*F;

for j=1:N
    freqp = 0;
    theta = 0;
    for i=1:length(Fx)
        
        freq = Fx(i,j);
        theta = theta+pi*(freq + freqp)*dtt;
        
        if(theta > 2*pi)
            theta = theta - 2*pi;
            freqp = freq;
        end;
        
        b(i,j) = Hx(i,j)*sin(theta);
          
    end;
    b(:,j) = fadeout_cos(b(:,j)',.05,Fouts);
    b(:,j) = fadein_cos(b(:,j)',.03,Fouts);
    
end;

aud = sum(b(:,:)');
aud = 0.7*aud/max(abs(aud));

