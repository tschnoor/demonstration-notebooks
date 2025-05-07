function [h,z,f,D,h_alt,Zrad] = VokalTraktM(ARvect,LTvect,cutoff,maxF)
% Author: Brad Story
% Version 1.0 - 1995; Current Version: Feb 2010
% Cascade calculation of vocal tract
% Example call:  [h,z,f,D] = VokalTraktM(ones(44,1),1.396825*ones(44,1),50,5000);
% or [h,z,f,D] = VokalTraktM(areas,lengths,50,5000); 
% where areas = 44-element vector of cross-sectional areas
% and length = 44-element vector of lengths for each section

NSect 		= length(ARvect);
NPoints		= round(maxF/5);				% No. of points in Freq Spect
%NPoints		= round(maxF/.1);	
%df 			= round(maxF/NPoints);				% delta f - freq interval
df 			= (maxF/NPoints);

r = 408;
Ft = 200;
%Ft = 100;
%disp('Now running the yielding wall for females!!');
%Ft = 340;
Fw = 15;



q 			= 4.0;
csnd 		= 35000.0;				% speed of sound
rho 		= 0.00114;				% density of air
FreqVect 	= [df:df:df*NPoints]';
FreqVectLT	= length(FreqVect);
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

%disp('Number of Vocal Tract Sections: ');
%NSect

A 			= ones(NPoints,1);
B 			= zeros(NPoints,1);
C 			= zeros(NPoints,1);
D 			= ones(NPoints,1);



for k=1:NSect
  
  
  %----------This is for adding a hard-walled tube to the end of the tract --
  if(k >=  cutoff)
    r = 0;
    beta = 0;
    alpha = 0;
  end;

  temp1 		= r*ones(FreqVectLT,1) + j*(om);
  temp2 		= beta + (zeros(FreqVectLT,1) + j*om);
  gamma 		= sqrt(temp1 ./ temp2);
  sigma 		= gamma .* temp2;

  
% -------------------------------------------------------------------  
  
	nA 		= cosh( (LTvect(k)/csnd) * sigma);
	temp1 	= -rho*csnd/ARvect(k) * gamma;
	nB 		= temp1 .* sinh( (LTvect(k)/csnd) * sigma);
	temp1 	= ones(length(gamma),1) ./ gamma;
	temp2 	= -ARvect(k)/(rho*csnd) * temp1;
	nC 		= temp2 .* sinh((LTvect(k)/csnd) * sigma);
	nD 		= nA;
	
   
        M1 		= [A B; C D];
		M2 		= [nA nB; nC nD];
		

        A      = [M2(1:NPoints,1).*M1(1:NPoints,1) + M2(1:NPoints,2).*M1(NPoints+1:end,1)];
        B      = [M2(1:NPoints,1).*M1(1:NPoints,2) + M2(1:NPoints,2).*M1(NPoints+1:end,2)];
        C      = [M2(NPoints+1:end,1).*M1(1:NPoints,1) + M2(NPoints+1:end,2).*M1(NPoints+1:end,1)];
        D      = [M2(NPoints+1:end,1).*M1(1:NPoints,2) + M2(NPoints+1:end,2).*M1(NPoints+1:end,2)];
end



  R 		= 128. * rho*csnd/(9*pi^2 * ARvect(NSect));  
  L		= 8.*rho*csnd/((3*pi*csnd)*sqrt(ARvect(NSect)*pi)); 	
    

temp1 	= zeros(NPoints,1) + j*R*L*om;
temp2 	= R*ones(NPoints,1) + j*L*om;
Zrad	= temp1 ./ temp2;

%to remove effect of radiation
%disp('Calculations do NOT include radiation');
%Zrad = zeros(NPoints,1) + j*ones(NPoints,1);

%Zrad = zeros(NPoints,1) + j*zeros(NPoints,1);



temp1	= (Zrad .* D) - B;
temp2 	= A - (C .* Zrad);
z		= temp1 ./ temp2;
h		= Zrad ./ temp2;
f = FreqVect;

S = temp2./temp1;

h_alt = (-C.*B)./A +D;
%h = h_alt;
%disp('Calculations do NOT include radiation');

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


%-----These were used in an older version --------------------------------
% %om2 		= (406*pi)^2;
% om2 		= (400*pi)^2;
% %om2 		= (370*pi)^2;
% % ----yielding wall for females ??? -----------
% %disp('Now running the yielding wall for females!!');
% %om2     = (600*pi)^2;  