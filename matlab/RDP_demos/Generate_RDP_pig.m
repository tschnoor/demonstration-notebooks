load dbase_bhs96_L42.mat
%load dbase_Zmnopiri_5yo.mat

VTI = 1;


if(VTI == 1)
    
    load('MF_sims_26-Apr_modes96_halfyr.mat', 'Zm_nopiri');
    stat = Zm_nopiri(14).stat96;
    dbase.stat = stat;
    
elseif(VTI == 8)
    %--load 8 yr male---
    load('MF_sims_26-Apr_modes96_halfyr.mat', 'Zm_nopiri');
    stat = Zm_nopiri(9).statnewc;
    dbase.stat = stat;
else
    
    %--load 4 yr male---
    load('MF_sims_26-Apr_modes96_halfyr.mat', 'Zm_nopiri');
    stat = Zm_nopiri(5).statnewc;
    dbase.stat = stat;
    
end



clear E

% load NewNeutral.mat ne0
% dbase.stat.ne = ne0(:);


wn = 0;



%=======big============
wn = wn+1;
N = 110;


%enC = Event number - consonant
enC = 1;
%enG = Event number - adduction
enG = 1;
%enR = Event number - subglottal pressure
enR = 1;
%enN = Event number - nasal port
enN = 1;
%enV = Event number - vowel
enV = 1;
%enF0 = Event number - fundamental frequency
enF0 = 1;

E(wn).word = 'pig';
E(wn).N = N;
E(wn).stat = dbase.stat;
E(wn).cflag = 0;
E(wn).dxnew = dbase.stat.dx;
%E(wn).dxnew = 0.42;
E(wn).piri = [1 0.8000 0.7000 0.4000]; %will be scaled in BlackCat.m
E(wn).fotarg = 110; 

E(wn).Lo = 1.6;
E(wn).To = 0.3;
E(wn).x02 = 0.07;
E(wn).xib = 0.1;
E(wn).np = 0.8;
E(wn).pgap = 0.0;
E(wn).PL = 8000;
E(wn).nzbw = [300 2000];
E(wn).nzbw2 = [300 2000];

%=====================================

%--------Vowels and Consonants --------------------------

% /ah/
%E(wn).C(enC).rdp = [-1 -.2 0 0.5 ];
%E(wn).C(enC).rdp = [0.1 -1 0.5 0.5 ];;
E(wn).C(enC).rdp = [.2 -1 0.5 0.8 ];;
E(wn).C(enC).tmi = 5;
E(wn).C(enC).gwi = 15;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 0;
E(wn).C(enC).cflag = 0;
enC = enC + 1;



% /pp/
E(wn).C(enC).rdp = [-.1 -1 -1 1.0];
E(wn).C(enC).tmi = 15;
E(wn).C(enC).gwi = 10;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 15;
E(wn).C(enC).cflag = 0;
enC = enC + 1;


% /ih/
E(wn).C(enC).rdp = [-.5 1 .2 0.8];
E(wn).C(enC).tmi = 40;
E(wn).C(enC).gwi = 60;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 0;
E(wn).C(enC).cflag = 0;
enC = enC + 1;


% /gg/
E(wn).C(enC).rdp = [-.1 1 -1 1.05];
E(wn).C(enC).tmi = 70;
E(wn).C(enC).gwi = 20;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 15;
E(wn).C(enC).cflag = 0;
enC = enC + 1;


%----Vowel -----

%dummy
E(wn).V(enV).rdp =  [0.3 0.05 0 ];
[q1,q2,y] = find_q1q2_Norm(dbase,E(wn).V(enV).rdp(1:2));
E(wn).V(enV).Q = 0*[q1 q2];
E(wn).V(enV).tmi = 25;
E(wn).V(enV).gwi = 25;
E(wn).V(enV).skw = 1;
enV = enV + 1;


%----adduction- G-----
%/onset/
E(wn).G(enG).xi = 0.02;
E(wn).G(enG).tmi = 1;
E(wn).G(enG).gwi = 5;
E(wn).G(enG).skw = 1;
E(wn).G(enG).sti = 0;
enG = enG + 1;

E(wn).G(enG).xi = 0.1;
E(wn).G(enG).tmi = 20;
E(wn).G(enG).gwi = 10;
E(wn).G(enG).skw = 1;
E(wn).G(enG).sti = 12;
enG = enG + 1;


%/offset/
E(wn).G(enG).xi = 0.03;
E(wn).G(enG).tmi = N;
E(wn).G(enG).gwi = 40;
E(wn).G(enG).skw = 1;
E(wn).G(enG).sti = 25;
enG = enG + 1;


%----subglottal pressure - R-----
%onset ramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = 1;
E(wn).R(enR).gwi = 10;
E(wn).R(enR).skw = 1;
E(wn).R(enR).sti = 0;
enR = enR+ 1;

% E(wn).R(enR).sfPL = -0.8;
% E(wn).R(enR).tmi = 8;
% E(wn).R(enR).gwi = 10;
% E(wn).R(enR).skw = 1;
% E(wn).R(enR).sti = 0;
% enR = enR+ 1;

%offset ramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = N;
E(wn).R(enR).gwi = 45;
E(wn).R(enR).skw = 1;
E(wn).R(enR).sti = 20;
enR = enR+ 1;



%-----nasal coupling----------
%/ng/
E(wn).Nas(enN).arnas = 0.;
E(wn).Nas(enN).tmi = 65;
E(wn).Nas(enN).gwi = 30;
E(wn).Nas(enN).skw = 1;
E(wn).Nas(enN).sti = 10;
enN = enN+ 1;


%----fundamental frequency-------


E(wn).fo(enF0).sffo = -.4;
E(wn).fo(enF0).tmi = 1;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = .15;
E(wn).fo(enF0).tmi = 30;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = -.4;
E(wn).fo(enF0).tmi = N-10;
E(wn).fo(enF0).gwi = 80;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 30;
enF0 = enF0+ 1;



%original
% %----fundamental frequency-------
% 
% 
% E(wn).fo(enF0).sffo = -.3;
% E(wn).fo(enF0).tmi = 1;
% E(wn).fo(enF0).gwi = 30;
% E(wn).fo(enF0).skw = 1;
% enF0 = enF0+ 1;
% 
% E(wn).fo(enF0).sffo = .15;
% E(wn).fo(enF0).tmi = 30;
% E(wn).fo(enF0).gwi = 40;
% E(wn).fo(enF0).skw = 1;
% enF0 = enF0+ 1;
% 
% E(wn).fo(enF0).sffo = -.4;
% E(wn).fo(enF0).tmi = N;
% E(wn).fo(enF0).gwi = 40;
% E(wn).fo(enF0).skw = 1;
% enF0 = enF0+ 1;
% 

