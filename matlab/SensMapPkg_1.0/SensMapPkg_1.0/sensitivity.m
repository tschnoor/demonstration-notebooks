function [Po,Uo,sens,kin,pot] = sensitivity(ARvect,LTvect,Fn,cutoff,maxF)
%sensitivity.m
%Author: Brad Story, University of Arizona
% sensitivity function calculation of vocal tract
% the results have been verified by comparing to the Lagrangian (kin-pot) graphs in Fant, G.
% 1975, "Vocal-tract area and length perturbations" STL-QPSR.

NSect 		= length(ARvect);
NPoints		= 1;				% No. of points in Freq Spect
df 			= round(maxF/NPoints);				% delta f - freq interval

r = 408;
Ft = 200;
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


%disp('Number of Vocal Tract Sections: ');
%NSect

A 			= 1;
B 			= 0;
C 			= 0;
D 			= 1;
Pi			= 1;
Ui			= 0;

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
	

   M 		= [nA nB; nC nD];
   
   if (k==1)
       Po(k) = M(1,1)*Pi + M(1,2)*Ui;
       Uo(k) = M(2,1)*Pi + M(2,2)*Ui;
   else
       Po(k) = M(1,1)*Po(k-1) + M(1,2)*Uo(k-1);
       Uo(k) = M(2,1)*Po(k-1) + M(2,2)*Uo(k-1);
   end

end


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ar = ARvect;
sens = 0*ar;
kin = 0*ar;
pot = 0*ar;
lv = LTvect(1);

for kk=1:length(ar)
    
   Lx = lv*rho/ar(kk);
   Cx = lv*ar(kk)/(rhoc*csnd);
   pot(kk) = 0.5*Cx*(abs(Po(kk))).^2;
   kin(kk) = 0.5*Lx*(abs(Uo(kk))).^2;	

end;

tot = sum(pot+kin);
sens = (kin-pot)/tot;




