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



wn = 0;

%=======buddy============
wn = wn+1;
N = 80;


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

E(wn).word = 'buddy';
% E(wn).N = N;
% E(wn).stat = dbase.stat;
% E(wn).cflag = 0;
% E(wn).dxnew = 0.396825; %(17.46/44)
% %E(wn).dxnew = 0.42; %(17.46/44)
% E(wn).piri = 1;
% E(wn).fotarg = 90;
% E(wn).Lo = 1.4;
% E(wn).nzbw = [500 3000];
% E(wn).nzbw2 = [500 3500];

E(wn).N = N;
E(wn).stat = dbase.stat;
E(wn).cflag = 0;
E(wn).dxnew = dbase.stat.dx;
E(wn).piri = [1 0.8000 0.7000 0.4000]; %will be scaled in BlackCat.m
E(wn).fotarg = 110; %to be aligned with Bell labs recording
%E(wn).fotarg = 80; %version "c"
E(wn).Lo = 1.4;
E(wn).To = 0.3;
E(wn).x02 = 0.06;
E(wn).xib = 0.05;
E(wn).np = 0.85;
E(wn).pgap = 0.00;
E(wn).PL = 8000;
E(wn).nzbw = [500 3000];
E(wn).nzbw2 = [500 3000];

%=====================================

%--------Vowels and Consonants --------------------------


% /bb/
E(wn).C(enC).rdp = [-1 -1 -1 1.0];
E(wn).C(enC).tmi = 5;
E(wn).C(enC).gwi = 15;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 5;
E(wn).C(enC).cflag = 0;
enC = enC + 1;


% /ah/
E(wn).C(enC).rdp = [-.5 -1 0 0.4  ];
E(wn).C(enC).tmi = 20;
E(wn).C(enC).gwi = 20;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 0;
E(wn).C(enC).cflag = 0;
enC = enC + 1;

% /dd/ 
E(wn).C(enC).rdp = [-1 1 1 1.0];
E(wn).C(enC).tmi = 40;
E(wn).C(enC).gwi = 15;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 5;
E(wn).C(enC).cflag = 0;
enC = enC + 1;


% /ii/
E(wn).C(enC).rdp = [-.5 1 0.2 0.5 ];
E(wn).C(enC).tmi = 55;
E(wn).C(enC).gwi = 25;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 15;
E(wn).C(enC).cflag = 0;
enC = enC + 1;

% % /ii/
E(wn).C(enC).rdp = [-1 .8 0.2 0.8 ];
E(wn).C(enC).tmi = 65;
E(wn).C(enC).gwi = 30;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 15;
E(wn).C(enC).cflag = 0;
enC = enC + 1;

%=============


%----Vowel -----

%dummy
E(wn).V(enV).rdp =  [-0.1 0.1 0 ];
[q1,q2,y] = find_q1q2_Norm(dbase,E(wn).V(enV).rdp(1:2));
E(wn).V(enV).Q = 0*[q1 q2];
E(wn).V(enV).tmi = 1;
E(wn).V(enV).gwi = 15;
E(wn).V(enV).skw = 1;
E(wn).V(enV).sti = N;
enV = enV + 1;


%----adduction- G-----
%/cons/
E(wn).G(enG).xi = .05; 
E(wn).G(enG).tmi = 1;
E(wn).G(enG).gwi = 5;
E(wn).G(enG).skw = 1;
E(wn).G(enG).sti = 0;
enG = enG + 1;


%/cons/
E(wn).G(enG).xi = .05; 
E(wn).G(enG).tmi = N;
E(wn).G(enG).gwi = 15;
E(wn).G(enG).skw = 1;
E(wn).G(enG).sti = 5;
enG = enG + 1;


%----subglottal pressure - R-----
%startup sramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = 1;
E(wn).R(enR).gwi = 5;
E(wn).R(enR).skw = 1;
E(wn).R(enR).sti = 0;
enR = enR+ 1;


%termination ramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = N;
E(wn).R(enR).gwi = 5;
E(wn).R(enR).skw = 1;
E(wn).R(enR).sti = 0;
enR = enR+ 1;


%-----nasal coupling----------
%/nn/
E(wn).Nas(enN).arnas = 0.;
E(wn).Nas(enN).tmi = N;
E(wn).Nas(enN).gwi = 20;
E(wn).Nas(enN).skw = 1;
E(wn).Nas(enN).sti = 0;
enN = enN+ 1;


%----NEW fundamental frequency-------
E(wn).fo(enF0).sffo = .3;
E(wn).fo(enF0).tmi = 20;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;
% 

E(wn).fo(enF0).sffo = -.3;
E(wn).fo(enF0).tmi = N;
E(wn).fo(enF0).gwi = 20;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;

