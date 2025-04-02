function [Po,Uo,sens,kin,pot] = sensitivity_sbranch(ARvect,LTvect,Fn,cutoff,maxF,Ap,Lp,N_piri)
% sensitivity function calculation of vocal tract
% the results have been verified by comparing to the Lagrangian (kin-pot) graphs in Fant, G.
% 1975, "Vocal-tract area and length perturbations" STL-QPSR.

NSect 		= length(ARvect);
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




% piriform
Zp = piri_imped_sensitivity(Ap,Lp,maxF,Fn);
KpA = ones(NPoints,1);
KpB = zeros(NPoints,1);
KpC = -1 ./(Zp);
KpD = ones(NPoints,1);



%disp('Number of Vocal Tract Sections: ');
%NSect

A 			= 1;
B 			= 0;
C 			= 0;
D 			= 1;
Pi			= 1;
Ui			= 0;


for k=1:N_piri
  
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
   if (k==1)
      Po(k) = M1(1,1)*Pi + M1(1,2)*Ui;
      Uo(k) = M1(2,1)*Pi + M1(2,2)*Ui;
   end;
   
   M2 		= [nA nB; nC nD];
   M3 		= M2*M1;
   Po(k+1) = M3(1,1)*Pi + M3(1,2)*Ui;
   Uo(k+1) = M3(2,1)*Pi + M3(2,2)*Ui;

  
   
	A 	= M3(1,1);
	B 	= M3(1,2);
	C 	= M3(2,1);
	D 	= M3(2,2);
	end
    
    
    % piriform branch---------------------------------

        M1 		= [A B; C D];
		M2 		= [KpA KpB; KpC KpD];
		M3 		= M2*M1;

       A 	= M3(1,1);
	   B 	= M3(1,2);
	   C 	= M3(2,1);
	   D 	= M3(2,2);

%-----------------------------------------------------

for k=N_piri+1:NSect
    
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
   if (k==1)
      Po(k) = M1(1,1)*Pi + M1(1,2)*Ui;
      Uo(k) = M1(2,1)*Pi + M1(2,2)*Ui;
   end;
   
   M2 		= [nA nB; nC nD];
   M3 		= M2*M1;
   Po(k+1) = M3(1,1)*Pi + M3(1,2)*Ui;
   Uo(k+1) = M3(2,1)*Pi + M3(2,2)*Ui;

  
   
	A 	= M3(1,1);
	B 	= M3(1,2);
	C 	= M3(2,1);
	D 	= M3(2,2);
	end


R 		= 128. * rho*csnd/(9*pi^2 * ARvect(NSect));
L		= 8.*rho*csnd/((3*pi*csnd)*sqrt(ARvect(NSect))*pi);

temp1 	= zeros(NPoints,1) + j*R*L*om;
temp2 	= R*ones(NPoints,1) + j*L*om;
Zrad	= temp1 ./ temp2;

temp1	= (Zrad .* D) - B;
temp2 	= A - (C .* Zrad);
Zin		= temp1 ./ temp2;
HL		= Zrad ./ temp2;

%added on 12.31.2021 - not sure about this????
%Po(k+1) = Zrad.*Uo(k+1);

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ar = ARvect;
sens = 0*ar;
kin = 0*ar;
pot = 0*ar;
lv = LTvect(1);
for kk=1:length(ar)
   Lx = lv*rho/ar(kk);
   Cx = lv*ar(kk)/(rhoc*csnd);
   pot(kk) = 0.5*Cx*(abs(Po(kk+1))).^2;
   kin(kk) = 0.5*Lx*(abs(Uo(kk+1))).^2;	
end;

tot = sum(pot)+sum(kin);
sens = (kin-pot)/tot;
%sens = (kin-pot)./(kin+pot);

