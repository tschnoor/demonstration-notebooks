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



%=======ham============
wn = wn+1;
N = 70;


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

E(wn).word = 'ham';
E(wn).N = N;
E(wn).stat = dbase.stat;
E(wn).cflag = 0;
E(wn).fotarg = 90;
E(wn).dxnew = 0.396825; %(17.46/44)
E(wn).piri = 1;

%=====================================

%--------Vowels and Consonants --------------------------

% /ae/
E(wn).C(enC).rdp = [1 1 0 0.7];
E(wn).C(enC).tmi = 20;
E(wn).C(enC).gwi = 50;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 0;
E(wn).C(enC).cflag = 0;
enC = enC + 1;


% /mm/ 
E(wn).C(enC).rdp = [-1 -1 -1 1.05];
E(wn).C(enC).tmi = 50;
E(wn).C(enC).gwi = 20;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 10;
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
E(wn).G(enG).gwi = 10;
E(wn).G(enG).skw = 1;
E(wn).G(enG).sti = 5;
enG = enG + 1;


%/cons/
E(wn).G(enG).xi = 0.05;
E(wn).G(enG).tmi = N;
E(wn).G(enG).gwi = 15;
E(wn).G(enG).skw = 1;
E(wn).G(enG).sti = 0;
enG = enG + 1;

%----subglottal pressure - R-----
%startup ramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = 1;
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
E(wn).Nas(enN).arnas = 0.1;
E(wn).Nas(enN).tmi = 40;
E(wn).Nas(enN).gwi = 40;
E(wn).Nas(enN).skw = 1;
E(wn).Nas(enN).sti = 10;
enN = enN+ 1;

%----fundamental frequency-------
% E(wn).fo(enF0).sffo = -.05;
% E(wn).fo(enF0).tmi = 1;
% E(wn).fo(enF0).gwi = 20;
% E(wn).fo(enF0).skw = 1;
% enF0 = enF0+ 1;
% 
% 
% E(wn).fo(enF0).sffo = .15;
% E(wn).fo(enF0).tmi = 25;
% E(wn).fo(enF0).gwi = 20;
% E(wn).fo(enF0).skw = 1;
% enF0 = enF0+ 1;
% 
% E(wn).fo(enF0).sffo = -.2;
% E(wn).fo(enF0).tmi = N;
% E(wn).fo(enF0).gwi = 30;
% E(wn).fo(enF0).skw = 1;
% enF0 = enF0+ 1;


%----fundamental frequency-------
E(wn).fo(enF0).sffo = .12;
E(wn).fo(enF0).tmi = 1;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;


E(wn).fo(enF0).sffo = -.18;
E(wn).fo(enF0).tmi = 30;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = -.05;
E(wn).fo(enF0).tmi = N;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;



