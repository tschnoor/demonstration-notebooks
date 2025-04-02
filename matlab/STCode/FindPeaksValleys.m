function [tmpks, pks, index] = FindPeaksValleys(tm, wave);
%Author: Brad Story
%Modified: 10.10.2013
% peak detector looks for any positive maxima


siglen = length(wave) ;

tmpks = [] ;
pks = [] ;
index = [] ;
dt = tm(2) - tm(1);
for i = 2:siglen-1
    if(abs(wave(i)-wave(i-1)) > 0.0000000001)
        if( (wave(i-1) < wave(i)) & (wave(i+1) < wave(i) ) )
            fprm = (wave(i+1) - wave(i-1))/(2*dt);
            fprm2 = (wave(i+1) - 2*wave(i)+wave(i-1))/(dt^2);
            corr = -fprm/fprm2;
            tmpks = 	[tmpks  tm(i)+corr ] ;
            pks  =  [pks   wave(i)] ;
            index = [index i];
        end ;
    end
end ;
