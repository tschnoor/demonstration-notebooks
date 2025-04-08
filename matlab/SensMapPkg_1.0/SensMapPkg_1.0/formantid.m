function [formants, heights, index] = formantid( spectra, freq,numformants)
%Author: Brad Story
%Modified: 08.25.08
% peak detector looks for any positive maxima
% Used in spectrum formant tracking, since spectra is
% smoothly varying. Assumes a cascade generated spectra 

siglen = length(spectra) ;
; 
formants = [] ;
heights = [] ;
index = [] ;
df = freq(2) - freq(1);
for i = 2:siglen-1
   if( (spectra(i-1) < spectra(i)) & ...
         (spectra(i+1) < spectra(i) ) )
      fprm = (spectra(i+1) - spectra(i-1))/(2*df);
      fprm2 = (spectra(i+1) - 2*spectra(i)+spectra(i-1))/(df^2);
      corr = -fprm/fprm2;
      formants = 	[formants  freq(i)+corr ] ;
      heights  =  [heights   spectra(i)] ; 
      index = [index i];
   end ; 
end ; 

if (length(formants) > numformants)
   formants = formants(1:numformants);
   heights = heights(1:numformants);
end;