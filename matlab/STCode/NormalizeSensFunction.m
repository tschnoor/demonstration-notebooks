function Sn = NormalizeSensFunction(S0)
%NormalizeSensFunction.m
%B. Story
%07.02.2018
%This function attempts to equalize the contributions of acoustic
%sensitivity functions to VT shape deformation. Without this normalization,
%the lip region, in particular, can dominate the sensitivity function and,
%as a result, move resonances with very tight lip constrictions instead of
%utilizing other regions of the VT. This is especially important for such
%configurations as /u/, /U/, and /o/.
%
%INPUT: S0 = the raw sensitivity to be normalized (can be any)
%OUTPUT: Sn = normalize sensitivity function


%--first find the negative and positive regions of the sens function - will
%---be used later to complete the normalization
S0 = S0/max(abs(S0));
[ia,j] = find(S0(:)<0);

%---Make all negative regions of sens function positive.
a0 = abs(S0);

%---Build a 2nd order Butterworth filter. The purpose is to heavily filter
%---a0 to extract the envelope. 
%---The normalized cutoff frequency ncf is typically set to 0.1, however,
%---it can be to lower or higher values. If ncf is increased the normalized
%---sens function will become more severe because there is less and less
%---filtering. In the aymptotic case, the filtered sens function would be
%---equal to the unfiltered sens function and will produce a constant line at
%---1.0 after executing this b = 1./y(:) .* a0(:); After returning the sens function 
%---to its original region
%---polarities, the sens function would become steplike because all values
%---have to be -1.0 or 1.0. The ncf can also be set to smaller values. In
%---case the filtering becomes more and more severe. In the asymptotic
%---case, the filtered version becomes a constant line and when this is
%---executed b = 1./y(:) .* a0(:);, the shape of the sens function remains
%---unchanged.
ncf = 0.1;
[b,a] = butter(2,ncf);
y = filtfilt(b,a,a0);

%---This is required to assure that the entire y vector contains values
%---exceed the corresponding values of a0
y = y + max(a0-y);

%---This operation divides a0 by y to remove the original trend.
b = 1./y(:) .* a0(:) ;

%---This operation returns the negative regions of sens function to be
%---negatively valued.
b(ia) = -b(ia);

%---Final operation to normalize the max amplitude of the new sens function
%---to 1.0
Sn = b(:)/max(abs(b(:)));


