function z= piri_imped_sensitivity(Ap,Lp,maxF,Fn)
% Cascade calculation of piriform sinus impedance
% Example call:  [h,z,f,D] = VokalTraktM(ones(44,1),1.396825*ones(44,1),50,5000);
% or [h,z,f,D] = VokalTraktM(areas,lengths,50,5000);
% where areas = 44-element vector of cross-sectional areas
% and length = 44-element vector of lengths for each section

NSect 		= length(Ap);
NPoints		= 1;				% No. of points in Freq Spect
%df 			= round(maxF/NPoints);				% delta f - freq interval
df 			= (maxF/NPoints);

r = 408;
Ft = 250;
%disp('Now running the yielding wall for females!!');
%Ft = 340;
Fw = 15;



q 			= 4.0;
csnd 		= 35000.0;				% speed of sound
rho 		= 0.00114;				% density of air
rhoc		= rho*csnd;

FreqVect 	= Fn;
FreqVectLT	= 1;

om 			= 2*pi*FreqVect;
alpha 		= zeros(FreqVectLT,1) + j*(q*om);
alpha 		= sqrt(alpha);
temp1 		= r*ones(FreqVectLT,1) + j*(om);
temp2 		= zeros(FreqVectLT,1) + j*(om);
den 		= temp1.*temp2;
temp1 		= ((2*pi*Fw)^2)*ones(FreqVectLT,1) + j*zeros(FreqVectLT,1);
den 		= den + temp1;
num 		= zeros(FreqVectLT,1) + j*om*(2*pi*Ft)^2;
beta 		= (num ./ den) + alpha;


A 			= 1;
B 			= 0;
C 			= 0;
D 			= 1;


for k=1:NSect   
    
    temp1 		= r*ones(FreqVectLT,1) + j*(om);
    temp2 		= beta + (zeros(FreqVectLT,1) + j*om);
    gamma 		= sqrt(temp1 ./ temp2);
    sigma 		= gamma .* temp2;
    
    
    % -------------------------------------------------------------------
    
    
    
    nA 		= cosh( (Lp(k)/csnd) * sigma);
    temp1 	= -rho*csnd/Ap(k) * gamma;
    nB 		= temp1 .* sinh( (Lp(k)/csnd) * sigma);
    temp1 	= ones(length(gamma),1) ./ gamma;
    temp2 	= -Ap(k)/(rho*csnd) * temp1;
    nC 		= temp2 .* sinh((Lp(k)/csnd) * sigma);
    nD 		= nA;
    
    
    M1 		= [A B; C D];
    M2 		= [nA nB; nC nD];
    M3 		= M2*M1;
    
    A 	= M3(1,1);
    B 	= M3(1,2);
    C 	= M3(2,1);
    D 	= M3(2,2);
end



rhoc = rho*csnd;
Zend = 0 - j*(rhoc/Ap(NSect))./(tan(om*Lp(NSect)/csnd));
temp1	= (Zend .* D) - B;
temp2 	= A - (C .* Zend);
z = temp1 ./ temp2;

