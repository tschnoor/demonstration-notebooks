function [audio] = generateRDP(...
    n,...
    cflag,...
    piri_1,...
    piri_2,...
    piri_3,...
    piri_4,...
    fotarg,...
    lo,...
    to,...
    x02,...
    xib,...
    np,...
    pgap,...
    pl,...
    nzbw_1,...
    nzbw_2,...
    nzbw2_1,...
    nzbw2_2,...
    con,...
    add,...
    press,...
    nas,...
    f0);

    load dbase_bhs96_L42.mat
    %load dbase_Zmnopiri_5yo.mat

    load('MF_sims_26-Apr_modes96_halfyr.mat', 'Zm_nopiri');
    stat = Zm_nopiri(14).stat96;
    dbase.stat = stat;

    clear E

    wn = 0;
    wn = wn+1;
    N = n;

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


    E(wn).word = 'Did you eat yet (reduced)';

    E(wn).N = N;
    E(wn).stat = dbase.stat;
    E(wn).cflag = cflag;
    E(wn).dxnew = dbase.stat.dx;
    E(wn).piri = [piri_1 piri_2 piri_3 piri_4]; %will be scaled in BlackCat.m
    E(wn).fotarg = fotarg; %to be aligned with Bell labs recording
    E(wn).Lo = lo;
    E(wn).To = to;
    E(wn).x02 = x02;
    E(wn).xib = xib;
    E(wn).np = np;
    E(wn).pgap = pgap;
    E(wn).PL = pl;
    E(wn).nzbw = [nzbw_1 nzbw_2];
    E(wn).nzbw2 = [nzbw2_1 nzbw2_2];

    %--------Vowels and Consonants --------------------------

    for i = 1:length(con)
        E(wn).C(enC).rdp = [con{i}{1} con{i}{2} con{i}{3} con{i}{4}];
        E(wn).C(enC).tmi = con{i}{5};
        E(wn).C(enC).gwi = con{i}{6};
        E(wn).C(enC).skw = con{i}{7};
        E(wn).C(enC).sti = con{i}{8};
        E(wn).C(enC).cflag = con{i}{9};
        enC = enC + 1;
    end

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

    for i = 1:length(add)
        E(wn).G(enG).xi = add{i}{1}; 
        E(wn).G(enG).tmi = add{i}{2};
        E(wn).G(enG).gwi = add{i}{3};
        E(wn).G(enG).skw = add{i}{4};
        E(wn).G(enG).sti = add{i}{5};
        enG = enG + 1;
    end

    %----subglottal pressure - R-----

    for i = 1:length(press)
        E(wn).R(enR).sfPL = press{i}{1};
        E(wn).R(enR).tmi = press{i}{2};
        E(wn).R(enR).gwi = press{i}{3};
        E(wn).R(enR).skw = press{i}{4};
        E(wn).R(enR).sti = press{i}{5};
        enR = enR+ 1;
    end

    %-----nasal coupling----------

    for i = 1:length(nas)
        E(wn).Nas(enN).arnas = nas{i}{1};
        E(wn).Nas(enN).tmi = nas{i}{2};
        E(wn).Nas(enN).gwi = nas{i}{3};
        E(wn).Nas(enN).skw = nas{i}{4};
        E(wn).Nas(enN).sti = nas{i}{5}; 
        enN = enN+ 1;
    end

    %----fundamental frequency-------

    for i = 1:length(f0)
        E(wn).fo(enF0).sffo = f0{i}{1};
        E(wn).fo(enF0).tmi = f0{i}{2};
        E(wn).fo(enF0).gwi = f0{i}{3};
        E(wn).fo(enF0).skw = f0{i}{4};
        E(wn).fo(enF0).sti = f0{i}{5};
        enF0 = enF0+ 1;
    end

    % -------------------------------
    % save("temp_E.mat", 'E')
    Z = OratorVerbisComputisAlt(E);
    audio = Z.aud;
    % soundsc(Z.aud,44100);

    % audiowrite("synthesis.wav", Z.aud, 44100)

end