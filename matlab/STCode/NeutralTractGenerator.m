function ne = NeutralTractGenerator(Le,Ae,Ap,Am,Rm);
%Author: B. Story, Univ. of Arizona
%Updated: 07.07.2013
%INPUTS
%Le = length of epilaryngeal section
%Ae = area of epilarynx
%Ap = area of pharyngeal section
%Am = mouth/lip area
%Rm = range of mouth area; usually use Rm=30
%OUTPUT
%ne = area function

%INTERNAL PARAMETERS
N = 44; %number of sections in area function
%Re = 5; %range for epilarynx
Re = 10; %range for epilarynx
Lm = N; %location of lip area - based on 44-section area function


ne = cgauss_nolimits([1:N],1,Le,Re);
ne(1:Le) = 0;
ne = (Ap-Ae)*ne + Ae;
dc = ( Am/Ap ) - 1;
c = 2-cgauss_nolimits([1:N],dc,Lm,Rm);
ne = ne.*c;


ne = smooth(ne,3);

