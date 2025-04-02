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

% load NewNeutral.mat ne05
% dbase.stat.ne = ne05(:);

wn = 0;


%=======three============
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

E(wn).word = 'three';
E(wn).N = N;
E(wn).stat = dbase.stat;
E(wn).cflag = 12;
E(wn).dxnew = 0.396825; %(17.46/44)
E(wn).fotarg = 85;
E(wn).Lo = 1.6;
E(wn).piri = 1;
E(wn).nzbw = [500 2000];
E(wn).nzbw2 = [2000 5000];

%=====================================

%--------Vowels and Consonants --------------------------

% 
% % /th/
E(wn).C(enC).rdp = [-1 -.4 1 .98];
E(wn).C(enC).tmi = 1;
E(wn).C(enC).gwi = 20;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 10;
E(wn).C(enC).cflag = 0;
enC = enC + 1;
% 

% /rr/
E(wn).C(enC).rdp = [0 0 -1 0.85 ];
E(wn).C(enC).tmi = 25;
E(wn).C(enC).gwi = 10;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 0;
E(wn).C(enC).cflag = 0;
enC = enC + 1;



% % /ii/
E(wn).C(enC).rdp = [-.5 1 0.2 0.7 ];
E(wn).C(enC).tmi = 40;
E(wn).C(enC).gwi = 40;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 40;
E(wn).C(enC).cflag = 0;
enC = enC + 1;

% % /ii/
E(wn).C(enC).rdp = [-1 .8 0.2 0.83 ];
E(wn).C(enC).tmi = 50;
E(wn).C(enC).gwi = 30;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 35;
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
%/cons/
E(wn).G(enG).xi = 0.1; 
E(wn).G(enG).tmi = 1;
E(wn).G(enG).gwi = 20;
E(wn).G(enG).skw = 1;
E(wn).G(enG).sti = 0;
enG = enG + 1;


%/cons/
E(wn).G(enG).xi = 0.05;
E(wn).G(enG).tmi = N;
E(wn).G(enG).gwi = 20;
E(wn).G(enG).skw = 1;
E(wn).G(enG).sti = 0;
enG = enG + 1;

%----subglottal pressure - R-----
%startup ramp
E(wn).R(enR).sfPL = -.5;
E(wn).R(enR).tmi = 1;
E(wn).R(enR).gwi = 5;
E(wn).R(enR).skw = 1;
E(wn).R(enR).sti = 0;
enR = enR+ 1;

E(wn).R(enR).sfPL = .3;
E(wn).R(enR).tmi = 10;
E(wn).R(enR).gwi = 5;
E(wn).R(enR).skw = 1;
E(wn).R(enR).sti = 0;
enR = enR+ 1;


%termination ramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = N;
E(wn).R(enR).gwi = 10;
E(wn).R(enR).skw = 1;
E(wn).R(enR).sti = 0;
enR = enR+ 1;


%-----nasal coupling----------
%/nn/
E(wn).Nas(enN).arnas = 0.0;
E(wn).Nas(enN).tmi = 30;
E(wn).Nas(enN).gwi = 45;
E(wn).Nas(enN).skw = 1;
E(wn).Nas(enN).sti = 0;
enN = enN+ 1;


%----fundamental frequency-------
% E(wn).fo(enF0).sffo = -.1;
% E(wn).fo(enF0).tmi = 1;
% E(wn).fo(enF0).gwi = 10;
% E(wn).fo(enF0).skw = 1;
% enF0 = enF0+ 1;
% 
% E(wn).fo(enF0).sffo = .25;
% E(wn).fo(enF0).tmi = 30;
% E(wn).fo(enF0).gwi = 20;
% E(wn).fo(enF0).skw = 1;
% enF0 = enF0+ 1;
% 
% 
% E(wn).fo(enF0).sffo = -.2;
% E(wn).fo(enF0).tmi = N;
% E(wn).fo(enF0).gwi = 30;
% E(wn).fo(enF0).skw = 1;
% enF0 = enF0+ 1;


%----fundamental frequency-------
E(wn).fo(enF0).sffo = -.1;
E(wn).fo(enF0).tmi = 1;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = 0.3;
E(wn).fo(enF0).tmi = 45;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;


E(wn).fo(enF0).sffo = -.2;
E(wn).fo(enF0).tmi = N-5;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;
