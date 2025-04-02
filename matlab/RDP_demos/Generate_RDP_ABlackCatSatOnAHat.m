
load dbase_bhs96_L42.mat
%load dbase_Zmnopiri_5yo.mat

%f0flag = 1;

VTI =1;

if(VTI == 1)
    
    load('MF_sims_26-Apr_modes96_halfyr.mat', 'Zm_nopiri');
    stat = Zm_nopiri(14).stat96;
    dbase.stat = stat;
    
elseif(VTI == 2)
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

% load NewNeutral.mat ne06
% dbase.stat.ne = ne06(:);

% load NewNeutral.mat ne05
% dbase.stat.ne = ne05(:);

% load NewNeutral.mat ne04
%  dbase.stat.ne = ne04(:);

% load NewNeutral.mat ne01 ne02 ne03
% dbase.stat.ne = ne03(:);

% load bhs02_neutral.mat ne
% dbase.stat.ne = ne(:);

% load pal_pha_mod.mat
% dbase.stat.ne = dbase.stat.ne(:).*pal_mod(:);

% load pal_pha_mod.mat
% dbase.stat.ne = dbase.stat.ne(:).*pha_mod(:);


% load pca_S96.mat V
% dbase.stat.ne = dbase.stat.ne(:)+V(:,42)*(-.8) - V(:,41)*.4;

wn = 0;


%=======BlackCat============
wn = wn+1;
N = 345;


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

E(wn).word = 'a black cat sat on a hat';
E(wn).N = N;
E(wn).stat = dbase.stat;
E(wn).cflag = 0;
E(wn).dxnew = 0.396825; %(17.46/44)
%E(wn).dxnew = 0.42; %(17.46/44)
E(wn).piri = 1;
E(wn).fotarg = 100;
% E(wn).nzbw = [500 2000];
% E(wn).nzbw2 = [2000 4000];
E(wn).nzbw = [300 2000];
E(wn).nzbw2 = [300 2000];

% E(wn).nzbw = [500 2000];
% E(wn).nzbw2 = [2000 4000];

%=====================================

%--------Vowels and Consonants --------------------------


% /bb/
E(wn).C(enC).rdp = [-1 -1 -1 1.05  ];
E(wn).C(enC).tmi = 20;
E(wn).C(enC).gwi = 15;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 0;
E(wn).C(enC).cflag = 0;
enC = enC + 1;

% /ll/
E(wn).C(enC).rdp = [0 0 1 0.94 ];
E(wn).C(enC).tmi = 30;
E(wn).C(enC).gwi = 20;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 0;
E(wn).C(enC).cflag = 12;
enC = enC + 1;

% /ae/
E(wn).C(enC).rdp = [1 .5 0 0.75];
E(wn).C(enC).tmi = 45;
E(wn).C(enC).gwi = 15;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 0;
E(wn).C(enC).cflag = 0;
enC = enC + 1;

% /kk/
E(wn).C(enC).rdp = [-1 1 -1 1.05 ];
E(wn).C(enC).tmi = 60;
E(wn).C(enC).gwi = 15;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 20;
E(wn).C(enC).cflag = 0;
enC = enC + 1;

% /ae/
E(wn).C(enC).rdp = [1 .6 0 0.75];
E(wn).C(enC).tmi = 95;
E(wn).C(enC).gwi = 55;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 0;
E(wn).C(enC).cflag = 0;
enC = enC + 1;

% /tt/
E(wn).C(enC).rdp = [-1 1 1 1.0 ];
E(wn).C(enC).tmi = 120;
E(wn).C(enC).gwi = 15;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 5;
E(wn).C(enC).cflag = 0;
enC = enC + 1;

% /s/ 
E(wn).C(enC).rdp = [-1 .1 1 0.97];
E(wn).C(enC).tmi = 135;
E(wn).C(enC).gwi = 20;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 5;
E(wn).C(enC).cflag = 1;
enC = enC + 1;

% /ae/
E(wn).C(enC).rdp = [1 .6 0 0.75];
E(wn).C(enC).tmi = 170;
E(wn).C(enC).gwi = 25;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 0;
E(wn).C(enC).cflag = 0;
enC = enC + 1;

% /tt/
E(wn).C(enC).rdp = [-1 1 1 1.0 ];
E(wn).C(enC).tmi = 195;
E(wn).C(enC).gwi = 15;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 5;
E(wn).C(enC).cflag = 0;
enC = enC + 1;

% /aa/
E(wn).C(enC).rdp = [1 -.3 0 0.6];
E(wn).C(enC).tmi = 225;
E(wn).C(enC).gwi = 20;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 0;
E(wn).C(enC).cflag = 0;
enC = enC + 1;

% /nn/
E(wn).C(enC).rdp = [-1 1 1 1.0 ];
E(wn).C(enC).tmi = 235;
E(wn).C(enC).gwi = 20;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 5;
E(wn).C(enC).cflag = 0;
enC = enC + 1;

% /ah/
E(wn).C(enC).rdp = [1 -.3 0 0.3];
E(wn).C(enC).tmi = 255;
E(wn).C(enC).gwi = 25;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 0;
E(wn).C(enC).cflag = 0;
enC = enC + 1;

% /hh->ae/
E(wn).C(enC).rdp = [1 0.5 0 0.75];
E(wn).C(enC).tmi = 290;
E(wn).C(enC).gwi = 60;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 0;
E(wn).C(enC).cflag = 0;
enC = enC + 1;

% 
% E(wn).C(enC).rdp = [1 1 1 0.5];
% E(wn).C(enC).tmi = 285;
% E(wn).C(enC).gwi = 50;
% E(wn).C(enC).skw = 1;
% E(wn).C(enC).sti = 0;
% E(wn).C(enC).cflag = 0;
% enC = enC + 1;

% /tt/
E(wn).C(enC).rdp = [-1 1 1 1.0 ];
E(wn).C(enC).tmi = 325;
E(wn).C(enC).gwi = 15;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 5;
E(wn).C(enC).cflag = 0;
enC = enC + 1;


%----Vowel -----

%dummy
E(wn).V(enV).rdp =  [0.3 -0.3 0 ];
[q1,q2,y] = find_q1q2_Norm(dbase,E(wn).V(enV).rdp(1:2));
E(wn).V(enV).Q = 0*[q1 q2];
E(wn).V(enV).tmi = 1;
E(wn).V(enV).gwi = 40;
E(wn).V(enV).skw = 1;
E(wn).V(enV).sti = 0;
enV = enV + 1;


%----adduction- G-----
%/cons/
E(wn).G(enG).xi = 0.02;
E(wn).G(enG).tmi = 1;
E(wn).G(enG).gwi = 10;
E(wn).G(enG).skw = 1;
E(wn).G(enG).sti = 0;
enG = enG + 1;

%/kk/
E(wn).G(enG).xi = 0.1;
E(wn).G(enG).tmi = 58;
E(wn).G(enG).gwi = 10;
E(wn).G(enG).skw = 1;
E(wn).G(enG).sti = 25;
enG = enG + 1;

%/cons/
E(wn).G(enG).xi = 0.1;
E(wn).G(enG).tmi = 120;
E(wn).G(enG).gwi = 10;
E(wn).G(enG).skw = 1;
E(wn).G(enG).sti = 25;
enG = enG + 1;

%/cons/
E(wn).G(enG).xi = 0.1;
E(wn).G(enG).tmi = 195;
E(wn).G(enG).gwi = 10;
E(wn).G(enG).skw = 1;
E(wn).G(enG).sti = 5;
enG = enG + 1;

%/cons/
E(wn).G(enG).xi = 0.15;
E(wn).G(enG).tmi = 285;
E(wn).G(enG).gwi = 10;
E(wn).G(enG).skw = 1;
E(wn).G(enG).sti = 0;
enG = enG + 1;

%/cons/
E(wn).G(enG).xi = 0.1;
E(wn).G(enG).tmi = 325;
E(wn).G(enG).gwi = 10;
E(wn).G(enG).skw = 1;
E(wn).G(enG).sti = 20;
enG = enG + 1;

%/cons/
% E(wn).G(enG).xi = 0.1;
% E(wn).G(enG).tmi = N;
% E(wn).G(enG).gwi = 10;
% E(wn).G(enG).skw = 1;
% E(wn).G(enG).sti = 5;
% enG = enG + 1;

%----subglottal pressure - R-----
%startup ramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = 1;
E(wn).R(enR).gwi = 5;
E(wn).R(enR).skw = 1;
E(wn).R(enR).sti = 0;
enR = enR+ 1;

%punch down between tt and ss
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = 128;
E(wn).R(enR).gwi = 5;
E(wn).R(enR).skw = 1;
E(wn).R(enR).sti = 0;
enR = enR+ 1;

%punch down
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = 200;
E(wn).R(enR).gwi = 5;
E(wn).R(enR).skw = 1;
E(wn).R(enR).sti = 5;
enR = enR+ 1;

%hh
E(wn).R(enR).sfPL = .5;
E(wn).R(enR).tmi = 285;
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
E(wn).Nas(enN).tmi = 235;
E(wn).Nas(enN).gwi = 20;
E(wn).Nas(enN).skw = 1;
E(wn).Nas(enN).sti = 5;
enN = enN+ 1;


%----fundamental frequency-------
E(wn).fo(enF0).sffo = -.1;
E(wn).fo(enF0).tmi = 1;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = .4;
E(wn).fo(enF0).tmi = 55;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = -.15;
E(wn).fo(enF0).tmi = 75;
E(wn).fo(enF0).gwi = 20;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = .4;
E(wn).fo(enF0).tmi = 95;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = .3;
E(wn).fo(enF0).tmi = 170;
E(wn).fo(enF0).gwi = 40;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = -.15;
E(wn).fo(enF0).tmi = 210;
E(wn).fo(enF0).gwi = 50;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = .1;
E(wn).fo(enF0).tmi = 225;
E(wn).fo(enF0).gwi = 20;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = .2;
E(wn).fo(enF0).tmi = 310;
E(wn).fo(enF0).gwi = 50;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;


E(wn).fo(enF0).sffo = -.4;
E(wn).fo(enF0).tmi = N;
E(wn).fo(enF0).gwi = 50;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;







