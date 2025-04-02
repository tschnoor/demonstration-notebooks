load dbase_bhs96_L42.mat
%load dbase_Zmnopiri_5yo.mat

VTI = 1;


if(VTI == 1)
    
    load('MF_sims_26-Apr_modes96_halfyr.mat', 'Zm_nopiri');
    stat = Zm_nopiri(14).stat96;
    dbase.stat = stat;
    
elseif(VTI == 2)
    %--load 2 yr male---
    load('MF_sims_26-Apr_modes96_halfyr.mat', 'Zm_nopiri');
    stat = Zm_nopiri(3).statnewc;
    dbase.stat = stat;
    
elseif(VTI == 8)
    %--load 8 yr male---
    load('MF_sims_26-Apr_modes96_halfyr.mat', 'Zm_nopiri');
    stat = Zm_nopiri(9).statnewc;
    dbase.stat = stat;
    
elseif(VTI == 20)
    %--load adult  female---
    load('MF_sims_26-Apr_modes96_halfyr.mat', 'Zf_nopiri');
    stat = Zf_nopiri(end).statnewc;
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

%dbase.stat.ne = dbase.stat.ne*2;

wn = 0;


%=======ama============
wn = wn+1;
N = 100;


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

E(wn).word = 'ama';
E(wn).N = N;
E(wn).stat = dbase.stat;
E(wn).cflag = 0;
E(wn).dxnew = dbase.stat.dx;
E(wn).piri = [1 0.8000 0.7000 0.4000]; %will be scaled in BlackCat.m
E(wn).fotarg = 120;
E(wn).Lo = 1.5;
E(wn).To = 0.3;
E(wn).x02 = 0.065;
E(wn).xib = 0.05;
E(wn).np = 0.85;
E(wn).pgap = 0.00;
E(wn).PL = 8000;
E(wn).nzbw = [500 3000];
E(wn).nzbw2 = [500 3000];

%=====================================

%--------Vowels and Consonants --------------------------

% /aa/
E(wn).C(enC).rdp = [1 -0.3 0 0.7  ];
E(wn).C(enC).tmi = 10;
E(wn).C(enC).gwi = 50;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 0;
E(wn).C(enC).cflag = 0;
enC = enC + 1;

% /mm/
E(wn).C(enC).rdp = [-1 -1 -1 1.];
E(wn).C(enC).tmi = 35;
E(wn).C(enC).gwi = 20;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 5;
E(wn).C(enC).cflag = 0;
enC = enC + 1;
% 

% /aa/
E(wn).C(enC).rdp = [1 -0.3 0 0.7  ];
E(wn).C(enC).tmi = 60;
E(wn).C(enC).gwi = 30;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 40;
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
E(wn).G(enG).xi = 0.03; 
E(wn).G(enG).tmi = 1;
E(wn).G(enG).gwi = 20;
E(wn).G(enG).skw = 1;
E(wn).G(enG).sti = 0;
enG = enG + 1;

%/cons/
% E(wn).G(enG).xi = 0.02; 
% E(wn).G(enG).tmi = 35;
% E(wn).G(enG).gwi = 10;
% E(wn).G(enG).skw = 1;
% E(wn).G(enG).sti = 0;
% enG = enG + 1;


%/cons/
E(wn).G(enG).xi = 0.05;
E(wn).G(enG).tmi = N;
E(wn).G(enG).gwi = 20;
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

%startup ramp
% E(wn).R(enR).sfPL = -.5;
% E(wn).R(enR).tmi = 35;
% E(wn).R(enR).gwi = 10;
% E(wn).R(enR).skw = 1;
% E(wn).R(enR).sti = 0;
% enR = enR+ 1;


%termination ramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = N;
E(wn).R(enR).gwi = 5;
E(wn).R(enR).skw = 1;
E(wn).R(enR).sti = 0;
enR = enR+ 1;


%-----nasal coupling----------
%/mm/
% E(wn).Nas(enN).arnas = 0.1;
% E(wn).Nas(enN).tmi = 18;
% E(wn).Nas(enN).gwi = 20;
% E(wn).Nas(enN).skw = 1;
% E(wn).Nas(enN).sti = 10; 
% enN = enN+ 1;

E(wn).Nas(enN).arnas = 0.;
E(wn).Nas(enN).tmi = 35;
E(wn).Nas(enN).gwi = 30;
E(wn).Nas(enN).skw = 1;
E(wn).Nas(enN).sti = 10; 
enN = enN+ 1;

%----fundamental frequency-------
% 
E(wn).fo(enF0).sffo = -0.15;
E(wn).fo(enF0).tmi = 1;
E(wn).fo(enF0).gwi = 35;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = -.2;
E(wn).fo(enF0).tmi = 35;
E(wn).fo(enF0).gwi = 40;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = .05;
E(wn).fo(enF0).tmi = 60;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = -.4;
E(wn).fo(enF0).tmi = N;
E(wn).fo(enF0).gwi = 50;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;





%=======ana============
wn = wn+1;
N = 100;


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

E(wn).word = 'ada';
E(wn).N = N;
E(wn).stat = dbase.stat;
E(wn).cflag = 0;
E(wn).dxnew = dbase.stat.dx;
E(wn).piri = [1 0.8000 0.7000 0.4000]; %will be scaled in BlackCat.m
E(wn).fotarg = 120;
E(wn).Lo = 1.5;
E(wn).To = 0.3;
E(wn).x02 = 0.065;
E(wn).xib = 0.05;
E(wn).np = 0.85;
E(wn).pgap = 0.002;
E(wn).PL = 8000;
E(wn).nzbw = [500 3000];
E(wn).nzbw2 = [500 3000];


%=====================================
%--------Vowels and Consonants --------------------------

% /aa/
E(wn).C(enC).rdp = [1 -0.3 0 0.7  ];
E(wn).C(enC).tmi = 10;
E(wn).C(enC).gwi = 50;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 0;
E(wn).C(enC).cflag = 0;
enC = enC + 1;


%Z0
% % /dd/
% E(wn).C(enC).rdp = [-1 1 1 1];
% E(wn).C(enC).tmi = 35;
% E(wn).C(enC).gwi = 15;
% E(wn).C(enC).skw = 1;
% E(wn).C(enC).sti = 10;
% E(wn).C(enC).cflag = 0;
% enC = enC + 1;

%Z1
% % /dd/
% E(wn).C(enC).rdp = [-1 1 1 1];
% E(wn).C(enC).tmi = 35;
% E(wn).C(enC).gwi = 15;
% E(wn).C(enC).skw = 1;
% E(wn).C(enC).sti = 5;
% E(wn).C(enC).cflag = 0;
% enC = enC + 1;


%Z2
% % /dd/
% E(wn).C(enC).rdp = [-1 1 1 1];
% E(wn).C(enC).tmi = 35;
% E(wn).C(enC).gwi = 25;
% E(wn).C(enC).skw = 1;
% E(wn).C(enC).sti = 0;
% E(wn).C(enC).cflag = 0;
% enC = enC + 1;

% 
%Z3
% % /dd/
E(wn).C(enC).rdp = [-1 1 .1 0.99];
E(wn).C(enC).tmi = 35;
E(wn).C(enC).gwi = 50;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 0;
E(wn).C(enC).cflag = 0;
enC = enC + 1;

%Z4
% % /dd/
% E(wn).C(enC).rdp = [-1 1 1 0.99];
% E(wn).C(enC).tmi = 35;
% E(wn).C(enC).gwi = 15;
% E(wn).C(enC).skw = 1;
% E(wn).C(enC).sti = 0;
% E(wn).C(enC).cflag = 0;
% enC = enC + 1;

%Z5
% % /dd/
% E(wn).C(enC).rdp = [-1 1 1 0.98];
% E(wn).C(enC).tmi = 35;
% E(wn).C(enC).gwi = 10;
% E(wn).C(enC).skw = 1;
% E(wn).C(enC).sti = 0;
% E(wn).C(enC).cflag = 0;
% enC = enC + 1;

%Z6
% % /dd/
% E(wn).C(enC).rdp = [-1 1 1 0.97];
% E(wn).C(enC).tmi = 35;
% E(wn).C(enC).gwi = 5;
% E(wn).C(enC).skw = 1;
% E(wn).C(enC).sti = 0;
% E(wn).C(enC).cflag = 0;
% enC = enC + 1;


% /aa/
E(wn).C(enC).rdp = [1 -0.3 0 0.7  ];
E(wn).C(enC).tmi = 60;
E(wn).C(enC).gwi = 30;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 40;
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
E(wn).G(enG).xi = 0.03; 
E(wn).G(enG).tmi = 1;
E(wn).G(enG).gwi = 20;
E(wn).G(enG).skw = 1;
E(wn).G(enG).sti = 0;
enG = enG + 1;

%/cons/
% E(wn).G(enG).xi = 0.02; 
% E(wn).G(enG).tmi = 40;
% E(wn).G(enG).gwi = 20;
% E(wn).G(enG).skw = 1;
% E(wn).G(enG).sti = 0;
% enG = enG + 1;


%/cons/
E(wn).G(enG).xi = 0.05;
E(wn).G(enG).tmi = N;
E(wn).G(enG).gwi = 20;
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
E(wn).R(enR).gwi = 5;
E(wn).R(enR).skw = 1;
E(wn).R(enR).sti = 0;
enR = enR+ 1;


%-----nasal coupling----------
%/mm/
% E(wn).Nas(enN).arnas = 0.1;
% E(wn).Nas(enN).tmi = 18;
% E(wn).Nas(enN).gwi = 20;
% E(wn).Nas(enN).skw = 1;
% E(wn).Nas(enN).sti = 10; 
% enN = enN+ 1;

E(wn).Nas(enN).arnas = 0.;
E(wn).Nas(enN).tmi = 35;
E(wn).Nas(enN).gwi = 30;
E(wn).Nas(enN).skw = 1;
E(wn).Nas(enN).sti = 10; 
enN = enN+ 1;

%----fundamental frequency-------
% 
E(wn).fo(enF0).sffo = -0.15;
E(wn).fo(enF0).tmi = 1;
E(wn).fo(enF0).gwi = 35;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = -.2;
E(wn).fo(enF0).tmi = 35;
E(wn).fo(enF0).gwi = 40;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = .05;
E(wn).fo(enF0).tmi = 60;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = -.4;
E(wn).fo(enF0).tmi = N;
E(wn).fo(enF0).gwi = 50;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;




%=======anga============
wn = wn+1;
N = 100;


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

E(wn).word = 'anga';
E(wn).N = N;
E(wn).stat = dbase.stat;
E(wn).cflag = 0;
E(wn).dxnew = dbase.stat.dx;
E(wn).piri = [1 0.8000 0.7000 0.4000]; %will be scaled in BlackCat.m
E(wn).fotarg = 120;
E(wn).Lo = 1.5;
E(wn).To = 0.3;
E(wn).x02 = 0.065;
E(wn).xib = 0.05;
E(wn).np = 0.85;
E(wn).pgap = 0.002;
E(wn).PL = 8000;
E(wn).nzbw = [500 3000];
E(wn).nzbw2 = [500 3000];

%=====================================

%--------Vowels and Consonants --------------------------

% /aa/
E(wn).C(enC).rdp = [1 -0.3 0 0.7  ];
E(wn).C(enC).tmi = 10;
E(wn).C(enC).gwi = 50;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 0;
E(wn).C(enC).cflag = 0;
enC = enC + 1;

% /ng/
E(wn).C(enC).rdp = [-1 1 -1 1.];
E(wn).C(enC).tmi = 35;
E(wn).C(enC).gwi = 20;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 5;
E(wn).C(enC).cflag = 0;
enC = enC + 1;
% 

% /aa/
E(wn).C(enC).rdp = [1 -0.3 0 0.7  ];
E(wn).C(enC).tmi = 60;
E(wn).C(enC).gwi = 30;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 40;
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
E(wn).G(enG).xi = 0.03; 
E(wn).G(enG).tmi = 1;
E(wn).G(enG).gwi = 20;
E(wn).G(enG).skw = 1;
E(wn).G(enG).sti = 0;
enG = enG + 1;

%/cons/
% E(wn).G(enG).xi = 0.02; 
% E(wn).G(enG).tmi = 25;
% E(wn).G(enG).gwi = 10;
% E(wn).G(enG).skw = 1;
% E(wn).G(enG).sti = 0;
% enG = enG + 1;


%/cons/
E(wn).G(enG).xi = 0.05;
E(wn).G(enG).tmi = N;
E(wn).G(enG).gwi = 20;
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
E(wn).R(enR).gwi = 5;
E(wn).R(enR).skw = 1;
E(wn).R(enR).sti = 0;
enR = enR+ 1;


%-----nasal coupling----------
%/mm/
% E(wn).Nas(enN).arnas = 0.1;
% E(wn).Nas(enN).tmi = 18;
% E(wn).Nas(enN).gwi = 20;
% E(wn).Nas(enN).skw = 1;
% E(wn).Nas(enN).sti = 10; 
% enN = enN+ 1;


E(wn).Nas(enN).arnas = 0.;
E(wn).Nas(enN).tmi = 35;
E(wn).Nas(enN).gwi = 30;
E(wn).Nas(enN).skw = 1;
E(wn).Nas(enN).sti = 10; 
enN = enN+ 1;

%----fundamental frequency-------
% 
E(wn).fo(enF0).sffo = -0.15;
E(wn).fo(enF0).tmi = 1;
E(wn).fo(enF0).gwi = 35;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = -.2;
E(wn).fo(enF0).tmi = 35;
E(wn).fo(enF0).gwi = 40;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = .05;
E(wn).fo(enF0).tmi = 60;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = -.4;
E(wn).fo(enF0).tmi = N;
E(wn).fo(enF0).gwi = 50;
E(wn).fo(enF0).skw = 1;
E(wn).fo(enF0).sti = 0;
enF0 = enF0+ 1;



