
load dbase_bhs96_L42.mat
%load dbase_Zmnopiri_5yo.mat

VTI = 1;

if(VTI == 1)
    
    load('MF_sims_26-Apr_modes96_halfyr.mat', 'Zm_nopiri');
    stat = Zm_nopiri(14).stat96;
    dbase.stat = stat;
    
else
    
    %--load 4 yr male---
    load('MF_sims_26-Apr_modes96_halfyr.mat', 'Zm_nopiri');
    stat = Zm_nopiri(5).statnewc;
    dbase.stat = stat;
    
end



clear E

wn = 0;

%=======apa============
wn = wn+1;
N = 95;


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

E(wn).word = 'apa';
E(wn).N = N;
E(wn).stat = dbase.stat;
E(wn).cflag = 12;


%=====================================

%--------Vowels and Consonants --------------------------


% % /aa/
E(wn).C(enC).rdp = [1 -0.3 0 0.7  ];
E(wn).C(enC).tmi = 17;
E(wn).C(enC).gwi = 40;
E(wn).C(enC).skw = 1;
E(wn).C(enC).cflag = 1;
enC = enC + 1;


% 
% % /pp/
E(wn).C(enC).rdp = [-1 -1 -.2 1.];
E(wn).C(enC).tmi = 45;
E(wn).C(enC).gwi = 15;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 10;
E(wn).C(enC).cflag = 1;
enC = enC + 1;
% 

% % /aa/
E(wn).C(enC).rdp = [1 -0.3 0 0.7  ];
E(wn).C(enC).tmi = 72;
E(wn).C(enC).gwi = 35;
E(wn).C(enC).skw = 1;
E(wn).C(enC).cflag = 1;
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
E(wn).G(enG).xi = 0.05;
E(wn).G(enG).tmi = 1;
E(wn).G(enG).gwi = 20;
E(wn).G(enG).skw = 1;
enG = enG + 1;

%/cons/
E(wn).G(enG).xi = 0.1;
E(wn).G(enG).tmi = 48;
E(wn).G(enG).gwi = 15;
E(wn).G(enG).skw = 1;
enG = enG + 1;

%/cons/
E(wn).G(enG).xi = 0.05;
E(wn).G(enG).tmi = N;
E(wn).G(enG).gwi = 20;
E(wn).G(enG).skw = 1;
enG = enG + 1;

%----subglottal pressure - R-----
%startup ramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = 1;
E(wn).R(enR).gwi = 20;
E(wn).R(enR).skw = 1;
enR = enR+ 1;

%/pp/
E(wn).R(enR).sfPL = -.6;
E(wn).R(enR).tmi = 45;
E(wn).R(enR).gwi = 15;
E(wn).R(enR).skw = 1;
enR = enR+ 1;

%termination ramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = N;
E(wn).R(enR).gwi = 20;
E(wn).R(enR).skw = 1;
enR = enR+ 1;

%-----nasal coupling----------
%/nn/
E(wn).Nas(enN).arnas = 0.;
E(wn).Nas(enN).tmi = 30;
E(wn).Nas(enN).gwi = 25;
E(wn).Nas(enN).skw = 1.5;
enN = enN+ 1;

%----fundamental frequency-------
E(wn).fo(enF0).sffo = -.1;
E(wn).fo(enF0).tmi = 10;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = .15;
E(wn).fo(enF0).tmi = N-20;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;


%=======atha============
wn = wn+1;
N = 95;


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

E(wn).word = 'atha';
E(wn).N = N;
E(wn).stat = dbase.stat;
E(wn).cflag = 12;
E(wn).dxnew = 0.42;
E(wn).piri = 1;

%=====================================

%--------Vowels and Consonants --------------------------


% % /aa/
E(wn).C(enC).rdp = [1 -0.3 0 0.7  ];
E(wn).C(enC).tmi = 17;
E(wn).C(enC).gwi = 30;
E(wn).C(enC).skw = 1;
E(wn).C(enC).cflag = 0;
enC = enC + 1;


% 
% % /th/
E(wn).C(enC).rdp = [-1 -0.3 0.8 .98];
E(wn).C(enC).tmi = 45;
E(wn).C(enC).gwi = 30;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 0;
E(wn).C(enC).cflag = 0;
enC = enC + 1;
% 

% % /aa/
E(wn).C(enC).rdp = [1 -0.3 0 0.7  ];
E(wn).C(enC).tmi = 72;
E(wn).C(enC).gwi = 35;
E(wn).C(enC).skw = 1;
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
E(wn).G(enG).xi = 0.05;
E(wn).G(enG).tmi = 1;
E(wn).G(enG).gwi = 20;
E(wn).G(enG).skw = 1;
enG = enG + 1;

%/cons/
E(wn).G(enG).xi = 0.15;
E(wn).G(enG).tmi = 48;
E(wn).G(enG).gwi = 15;
E(wn).G(enG).skw = 1;
enG = enG + 1;

%/cons/
E(wn).G(enG).xi = 0.05;
E(wn).G(enG).tmi = N;
E(wn).G(enG).gwi = 20;
E(wn).G(enG).skw = 1;
enG = enG + 1;

%----subglottal pressure - R-----
%startup ramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = 1;
E(wn).R(enR).gwi = 20;
E(wn).R(enR).skw = 1;
enR = enR+ 1;

%/th/
E(wn).R(enR).sfPL = -.6;
E(wn).R(enR).tmi = 45;
E(wn).R(enR).gwi = 15;
E(wn).R(enR).skw = 1;
enR = enR+ 1;

%termination ramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = N;
E(wn).R(enR).gwi = 20;
E(wn).R(enR).skw = 1;
enR = enR+ 1;

%-----nasal coupling----------
%/nn/
E(wn).Nas(enN).arnas = 0.;
E(wn).Nas(enN).tmi = 30;
E(wn).Nas(enN).gwi = 25;
E(wn).Nas(enN).skw = 1.5;
enN = enN+ 1;

%----fundamental frequency-------
E(wn).fo(enF0).sffo = -.1;
E(wn).fo(enF0).tmi = 10;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = .15;
E(wn).fo(enF0).tmi = N-20;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;




%=======ata============
wn = wn+1;
N = 95;


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

E(wn).word = 'ata';
E(wn).N = N;
E(wn).stat = dbase.stat;
E(wn).cflag = 12;


%=====================================

%--------Vowels and Consonants --------------------------


% % /aa/
E(wn).C(enC).rdp = [1 -0.3 0 0.7  ];
E(wn).C(enC).tmi = 17;
E(wn).C(enC).gwi = 40;
E(wn).C(enC).skw = 1;
E(wn).C(enC).cflag = 1;
enC = enC + 1;


% 
% % /tt/
E(wn).C(enC).rdp = [-1 1 1 1.];
E(wn).C(enC).tmi = 45;
E(wn).C(enC).gwi = 15;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 10;
E(wn).C(enC).cflag = 1;
enC = enC + 1;
% 

% % /aa/
E(wn).C(enC).rdp = [1 -0.3 0 0.7  ];
E(wn).C(enC).tmi = 72;
E(wn).C(enC).gwi = 35;
E(wn).C(enC).skw = 1;
E(wn).C(enC).cflag = 1;
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
E(wn).G(enG).xi = 0.05;
E(wn).G(enG).tmi = 1;
E(wn).G(enG).gwi = 20;
E(wn).G(enG).skw = 1;
enG = enG + 1;

%/cons/
E(wn).G(enG).xi = 0.15;
E(wn).G(enG).tmi = 48;
E(wn).G(enG).gwi = 15;
E(wn).G(enG).skw = 1;
enG = enG + 1;

%/cons/
E(wn).G(enG).xi = 0.05;
E(wn).G(enG).tmi = N;
E(wn).G(enG).gwi = 20;
E(wn).G(enG).skw = 1;
enG = enG + 1;

%----subglottal pressure - R-----
%startup ramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = 1;
E(wn).R(enR).gwi = 20;
E(wn).R(enR).skw = 1;
enR = enR+ 1;

%/tt/
E(wn).R(enR).sfPL = -.4;
E(wn).R(enR).tmi = 45;
E(wn).R(enR).gwi = 15;
E(wn).R(enR).skw = 1;
enR = enR+ 1;

%termination ramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = N;
E(wn).R(enR).gwi = 20;
E(wn).R(enR).skw = 1;
enR = enR+ 1;

%-----nasal coupling----------
%/nn/
E(wn).Nas(enN).arnas = 0.;
E(wn).Nas(enN).tmi = 30;
E(wn).Nas(enN).gwi = 25;
E(wn).Nas(enN).skw = 1.5;
enN = enN+ 1;

%----fundamental frequency-------
E(wn).fo(enF0).sffo = -.1;
E(wn).fo(enF0).tmi = 10;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = .15;
E(wn).fo(enF0).tmi = N-20;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;




%=======aka============
wn = wn+1;
N = 95;


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

E(wn).word = 'aka';
E(wn).N = N;
E(wn).stat = dbase.stat;
E(wn).cflag = 12;


%=====================================

%--------Vowels and Consonants --------------------------


% % /aa/
E(wn).C(enC).rdp = [1 -0.3 0 0.7  ];
E(wn).C(enC).tmi = 17;
E(wn).C(enC).gwi = 40;
E(wn).C(enC).skw = 1;
E(wn).C(enC).cflag = 1;
enC = enC + 1;


% 
% /kk/
E(wn).C(enC).rdp = [-1 1 -1 1.];
E(wn).C(enC).tmi = 45;
E(wn).C(enC).gwi = 15;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 10;
E(wn).C(enC).cflag = 1;
enC = enC + 1;
% 

% % /aa/
E(wn).C(enC).rdp = [1 -0.3 0 0.7  ];
E(wn).C(enC).tmi = 72;
E(wn).C(enC).gwi = 35;
E(wn).C(enC).skw = 1;
E(wn).C(enC).cflag = 1;
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
E(wn).G(enG).xi = 0.05;
E(wn).G(enG).tmi = 1;
E(wn).G(enG).gwi = 20;
E(wn).G(enG).skw = 1;
enG = enG + 1;

%/cons/
E(wn).G(enG).xi = 0.15;
E(wn).G(enG).tmi = 48;
E(wn).G(enG).gwi = 15;
E(wn).G(enG).skw = 1;
enG = enG + 1;


%/cons/
E(wn).G(enG).xi = 0.05;
E(wn).G(enG).tmi = N;
E(wn).G(enG).gwi = 20;
E(wn).G(enG).skw = 1;
enG = enG + 1;

%----subglottal pressure - R-----
%startup ramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = 1;
E(wn).R(enR).gwi = 20;
E(wn).R(enR).skw = 1;
enR = enR+ 1;

%/kk/
E(wn).R(enR).sfPL = -.1;
E(wn).R(enR).tmi = 45;
E(wn).R(enR).gwi = 15;
E(wn).R(enR).sti = 0;
E(wn).R(enR).skw = 1;
enR = enR+ 1;

%termination ramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = N;
E(wn).R(enR).gwi = 20;
E(wn).R(enR).skw = 1;
enR = enR+ 1;

%-----nasal coupling----------
%/nn/
E(wn).Nas(enN).arnas = 0.;
E(wn).Nas(enN).tmi = 30;
E(wn).Nas(enN).gwi = 25;
E(wn).Nas(enN).skw = 1.5;
enN = enN+ 1;

%----fundamental frequency-------
E(wn).fo(enF0).sffo = -.1;
E(wn).fo(enF0).tmi = 10;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = .15;
E(wn).fo(enF0).tmi = N-20;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;

%=======aha============
wn = wn+1;
N = 95;


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

E(wn).word = 'aha';
E(wn).N = N;
E(wn).stat = dbase.stat;
E(wn).cflag = 12;


%=====================================

%--------Vowels and Consonants --------------------------


% % /aa/
E(wn).C(enC).rdp = [1 -0.3 0 0.7  ];
E(wn).C(enC).tmi = 17;
E(wn).C(enC).gwi = 40;
E(wn).C(enC).skw = 1;
E(wn).C(enC).cflag = 1;
enC = enC + 1;


% 
% /hh/
E(wn).C(enC).rdp = [1 -0.3 0 0.3  ];
E(wn).C(enC).tmi = 45;
E(wn).C(enC).gwi = 15;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 5;
E(wn).C(enC).cflag = 1;
enC = enC + 1;
% 

% % /aa/
E(wn).C(enC).rdp = [1 -0.3 0 0.7  ];
E(wn).C(enC).tmi = 72;
E(wn).C(enC).gwi = 35;
E(wn).C(enC).skw = 1;
E(wn).C(enC).cflag = 1;
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
E(wn).G(enG).xi = 0.05;
E(wn).G(enG).tmi = 1;
E(wn).G(enG).gwi = 20;
E(wn).G(enG).skw = 1;
enG = enG + 1;

%/cons/
E(wn).G(enG).xi = 0.1;
E(wn).G(enG).tmi = 45;
E(wn).G(enG).gwi = 15;
E(wn).G(enG).skw = 1;
enG = enG + 1;


%/cons/
E(wn).G(enG).xi = 0.05;
E(wn).G(enG).tmi = N;
E(wn).G(enG).gwi = 20;
E(wn).G(enG).skw = 1;
enG = enG + 1;

%----subglottal pressure - R-----
%startup ramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = 1;
E(wn).R(enR).gwi = 20;
E(wn).R(enR).skw = 1;
enR = enR+ 1;

%/kk/
E(wn).R(enR).sfPL = -.4;
E(wn).R(enR).tmi = 45;
E(wn).R(enR).gwi = 15;
E(wn).R(enR).sti = 0;
E(wn).R(enR).skw = 1;
enR = enR+ 1;

%termination ramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = N;
E(wn).R(enR).gwi = 20;
E(wn).R(enR).skw = 1;
enR = enR+ 1;

%-----nasal coupling----------
%/nn/
E(wn).Nas(enN).arnas = 0.;
E(wn).Nas(enN).tmi = 30;
E(wn).Nas(enN).gwi = 25;
E(wn).Nas(enN).skw = 1.5;
enN = enN+ 1;

%----fundamental frequency-------
E(wn).fo(enF0).sffo = -.1;
E(wn).fo(enF0).tmi = 10;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = .15;
E(wn).fo(enF0).tmi = N-20;
E(wn).fo(enF0).gwi = 30;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;


%=======aa============
wn = wn+1;
N = 95;


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

E(wn).word = 'aa';
E(wn).N = N;
E(wn).stat = dbase.stat;
E(wn).cflag = 12;


%=====================================

%--------Vowels and Consonants --------------------------


% % /aa/
E(wn).C(enC).rdp = [1 -0.3 0 0.7  ];
E(wn).C(enC).tmi = 17;
E(wn).C(enC).gwi = 40;
E(wn).C(enC).skw = 1;
E(wn).C(enC).sti = 90;
E(wn).C(enC).cflag = 1;
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
E(wn).G(enG).xi = 0.01;
E(wn).G(enG).tmi = 1;
E(wn).G(enG).gwi = 20;
E(wn).G(enG).skw = 1;
enG = enG + 1;

%/cons/
E(wn).G(enG).xi = 0.01;
E(wn).G(enG).tmi = N;
E(wn).G(enG).gwi = 10;
E(wn).G(enG).skw = 1;
enG = enG + 1;

%----subglottal pressure - R-----
%startup ramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = 1;
E(wn).R(enR).gwi = 25;
E(wn).R(enR).skw = 1;
enR = enR+ 1;


%termination ramp
E(wn).R(enR).sfPL = -1;
E(wn).R(enR).tmi = N;
E(wn).R(enR).gwi = 20;
E(wn).R(enR).skw = 1;
enR = enR+ 1;

%-----nasal coupling----------
%/nn/
E(wn).Nas(enN).arnas = 0.;
E(wn).Nas(enN).tmi = 30;
E(wn).Nas(enN).gwi = 25;
E(wn).Nas(enN).skw = 1.5;
enN = enN+ 1;

%----fundamental frequency-------
E(wn).fo(enF0).sffo = .5;
E(wn).fo(enF0).tmi = 5;
E(wn).fo(enF0).gwi = 60;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;

E(wn).fo(enF0).sffo = -.2;
E(wn).fo(enF0).tmi = N;
E(wn).fo(enF0).gwi = 70;
E(wn).fo(enF0).skw = 1;
enF0 = enF0+ 1;






