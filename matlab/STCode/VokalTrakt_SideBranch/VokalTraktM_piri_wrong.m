function [h,z,f,D,h_alt,Zrad] = VokalTraktM_piri_wrong(ARvect,LTvect,cutoff,maxF, Ap,Lp,N_piri)
% Cascade calculation of vocal tract
% Example call:  [h,z,f,D] = VokalTraktM(ones(44,1),1.396825*ones(44,1),50,5000);
% or [h,z,f,D] = VokalTraktM(areas,lengths,50,5000);
% where areas = 44-element vector of cross-sectional areas
% and length = 44-element vector of lengths for each section
% N_piri is the connection point and is usually is 6 or 8

%NOTE: this code was validated against TubeTalker on 05.17.17

NSect 		= length(ARvect);
NPoints		= round(maxF/5);				% No. of points in Freq Spect
%df 			= round(maxF/NPoints);				% delta f - freq interval
df 			= (maxF/NPoints);
%a 			= 130*pi;
%b 			= (30*pi)^2;

% a 			= 80*pi;
% b 			= (20*pi)^2;

r = 408;
%Ft = 200;
Ft = 250; %provides better match to TubeTalker fmts
Fw = 15;


%om2 		= (406*pi)^2;
om2 		= (400*pi)^2;
%om2 		= (370*pi)^2;
% ----yielding wall for females ??? -----------
%disp('Now running the yielding wall for females!!');
%om2     = (600*pi)^2;


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





% piriform
[Zp, fp] = piri_imped(Ap(:),Lp(:),maxF);
KpA = ones(NPoints,1);
KpB = zeros(NPoints,1);
KpC = -1 ./(Zp);
KpD = ones(NPoints,1);




%disp('Number of Vocal Tract Sections: ');
%NSect

A 			= ones(NPoints,1);
B 			= zeros(NPoints,1);
C 			= zeros(NPoints,1);
D 			= ones(NPoints,1);


for k=1:N_piri
    
    if(k >=  cutoff)
        a = 0;
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



% piriform branch---------------------------------

M1 		= [A B; C D];
M2 		= [KpA KpB; KpC KpD];


A      = [M2(1:NPoints,1).*M1(1:NPoints,1) + M2(1:NPoints,2).*M1(NPoints+1:end,1)];
B      = [M2(1:NPoints,1).*M1(1:NPoints,2) + M2(1:NPoints,2).*M1(NPoints+1:end,2)];
C      = [M2(NPoints+1:end,1).*M1(1:NPoints,1) + M2(NPoints+1:end,2).*M1(NPoints+1:end,1)];
D      = [M2(NPoints+1:end,1).*M1(1:NPoints,2) + M2(NPoints+1:end,2).*M1(NPoints+1:end,2)];

%-----------------------------------------------------


for k=N_piri+1:NSect
    
    if(k >=  cutoff)
        a = 0;
        beta = 0;
        alpha = 0;
    end;
    
    
    temp1 		= r*ones(FreqVectLT,1) + j*(om);
    temp2 		= beta + (zeros(FreqVectLT,1) + j*om);
    gamma 		= sqrt(temp1 ./ temp2);
    sigma 		= gamma .* temp2;
    
    
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

temp1	= (Zrad .* D) - B;
temp2 	= A - (C .* Zrad);
z		= temp1 ./ temp2;
h		= Zrad ./ temp2;

% 
% h = z./(A - C.*z);
f = FreqVect;

S = temp2./temp1;

h_alt = (-C.*B)./A +D;
%h = h_alt;
%disp('Calculations do NOT include radiation');


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


