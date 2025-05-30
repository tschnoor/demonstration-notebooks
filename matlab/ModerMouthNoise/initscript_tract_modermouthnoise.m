%this is a script that defines a structure t
% structure contains all variables for the vocal tract

% KEEP THIS IN SYNC WITH THE VALUE IN DEFS.H !
NSECTIONS=150;		% Same as jtrch 


h.isamp = 1;

h.neplx =h.isamp*6;
h.npiri =h.isamp*4;
h.nphrx =h.isamp*16;
h.nmoth =h.isamp*(22);
h.nnose =h.isamp*6;
h.nnose12a =h.isamp*4;
h.nnose12b =h.isamp*16;
h.ntrch =h.isamp*34;
h.nsphen =h.isamp*6;
h.nmaxll =h.isamp*8;
h.ieplx =1;
h.jeplx =h.neplx;
h.iphrx =h.jeplx+1;
h.jphrx =h.jeplx+h.nphrx;
h.imoth =h.jphrx+1;
h.jmoth =h.jphrx+h.nmoth;
h.inose =h.jmoth+1;
h.jnose =h.jmoth+h.nnose;
h.inose1a =h.jnose + 1;
h.jnose1a =h.jnose + h.nnose12a;
h.inose1b =h.jnose1a + 1;
h.jnose1b =h.jnose1a + h.nnose12b;
h.inose2a =h.jnose1b + 1;
h.jnose2a =h.jnose1b + h.nnose12a;
h.inose2b =h.jnose2a + 1;
h.jnose2b =h.jnose2a + h.nnose12b;
h.isphen =h.jnose2b + 1;
h.jsphen =h.jnose2b + h.nsphen;
h.imaxll1 =h.jsphen + 1;
h.jmaxll1 =h.jsphen + h.nmaxll;
h.imaxll2 =h.jmaxll1 + 1;
h.jmaxll2 =h.jmaxll1 + h.nmaxll;
h.ipiri =h.jmaxll2+1;
h.jpiri =h.jmaxll2+h.npiri;
h.itrch =h.jpiri+1;
h.jtrch =h.jpiri+h.ntrch;

NSECTIONS = h.jtrch;

%--------------------------------------------


%constants

%disp('Remember to define t.jmoth');
%t.h = h;
t.jmoth = h.jmoth;
Nvt = t.jmoth;
%Ntrch = 32;  % male
Ntrch = 34;  % male
%Ntrch = 18; %female


t.csnd =35000;
t.rho  =0.00114;
t.rhoc =t.rho*t.csnd;
t.mu = 0.000186;
t.att_trct = 0.000837;
t.att_trch = 0.00837; %usual
%t.att_trch = 0.000837;
%disp('tracheal attenuation is same as tract');

%---TEST: take out attenuation factor-----
% t.att_trct = 0.000001;
% t.att_trch = 0.000001;
%----------------


t.Rvsc = 0;
t.Rlam = 0;
t.Rtot = 0;
t.Lvsc = 0;

% Commented by SM
%t.betaL = zeros(Nvt+Ntrch,2);
%t.betaC = zeros(Nvt+Ntrch,2); 
%t.yflow = zeros(Nvt+Ntrch,2);
%t.Pw= zeros(Nvt+Ntrch,2);
t.betaL = zeros(NSECTIONS,2);
t.betaC = zeros(NSECTIONS,2); 
t.yflow = zeros(NSECTIONS,2);
t.Pw= zeros(NSECTIONS,2);

% Commented by SM 
%t.ar = ones(Nvt+Ntrch,1);
t.ar = ones(NSECTIONS,1);
load SideBranchData2011.mat
load TracheaData.mat
t.ar(h.inose:h.jnose) = nose0;
t.ar(h.inose1a:h.jnose1b) = smooth(nose1,3);
t.ar(h.inose2a:h.jnose2b) = smooth(nose2,3);
t.ar(h.isphen:h.jsphen) = sphen;
t.ar(h.imaxll1:h.jmaxll1) = maxll1;
t.ar(h.imaxll2:h.jmaxll2) = maxll2;

%---set nasal passages to average of nose1 and nose2
nose_avg = smooth((nose1+nose2)/2,3);
t.ar(h.inose1a:h.jnose1b) = nose_avg;
t.ar(h.inose2a:h.jnose2b) = nose_avg;

%----Cul-de-Sac-------
% t.ar(h.inose1b+6:h.inose1b+8) = 0;
% t.ar(h.inose2b+6:h.inose2b+8) = 0;
% t.ar(h.imaxll1:h.jmaxll1) = 0;
% t.ar(h.imaxll2:h.jmaxll2) = 0;
% disp('Cul-de-sac settings ON');
%----------------------------------
% %----Denasal-------
%%t.ar(h.inose+2:h.jnose) = 0.1; %keep commented out
% t.ar(h.inose1a:h.jnose1b) = 0.;
% t.ar(h.inose2a:h.jnose2b) = 0.;
% t.ar(h.imaxll1:h.jmaxll1) = 0.01;
% t.ar(h.imaxll2:h.jmaxll2) = 0.01;
% disp('Denasal settings ON');
%----------------------------------
% %----Hyponasal-------
% t.ar(h.inose+2:h.jnose) = 0.15;
% t.ar(h.inose1a:h.jnose1b) = 0.12;
% t.ar(h.inose2a:h.jnose2b) = 0.12;
% t.ar(h.imaxll1:h.jmaxll1) = 0.0;
% t.ar(h.imaxll2:h.jmaxll2) = 0.0;
% disp('Hyponasal settings ON');
%----------------------------------
% %----Aramat hypothesis-------
% t.ar(h.inose+2:h.jnose) = 0.15;
% t.ar(h.inose1b-6:h.jnose1b) = 0.3*t.ar(h.inose1b-6:h.jnose1b);
% t.ar(h.inose2b-6:h.jnose2b) = 0.3*t.ar(h.inose2b-6:h.jnose2b);
% %t.ar(h.imaxll1:h.jmaxll1) = 0.0;
% %t.ar(h.imaxll2:h.jmaxll2) = 0.0;
% disp('Aramat settings ON');
%----------------------------------

t.ar(h.ipiri:h.jpiri) = piri;
%t.ar(h.itrch:h.jtrch) = trach3;
%t.ar(h.itrch:h.jtrch) = trach4;
%t.ar(h.itrch:h.jtrch) = trach5;
t.ar(h.itrch:h.jtrch) = trach6; %added on 05.25.18
%disp('using female trachea sf3 - change me in initscript_tract_modermouthnoise.m');
%t.ar(h.itrch:h.jtrch) = trach_sf3;
%yn3 = [1.5 1.5 yn3]';
%t.ar(h.itrch:h.jtrch) = yn3;
%t.ar(h.itrch:h.jtrch) = 30; % use only for demo & Amanda's comps
%disp('Using 30 cm2 trachea!!!!');

% Commented by SM 
%t.Pv = zeros(Nvt+Ntrch,2);
%t.Lv = zeros(Nvt+Ntrch,2);
%t.Ul = zeros(Nvt+Ntrch,2);

t.Pv = zeros(NSECTIONS,2);
t.Lv = zeros(NSECTIONS,2);
t.Ul = zeros(NSECTIONS,2);

t.visc = 1;
t.yw = 1;

t.Fs = 44100;

% Commented by SM 
%t.ac = zeros(Nvt+Ntrch,1);
t.ac = zeros(NSECTIONS,1);

t.Pext = 0.0;

t.L = 35000/(2*t.Fs);

t.Ltract = 1;	%Turns on wave prop in the trachea
t.Utract = 1;   % Turn on wave prop in the vocal tract

t.VS = 1;  % 1 for threemass, 2 for external using t.vox as GA, 3 for external using t.vox as UG
t.vox = zeros(4096,1);
t.vox(100) = 200;
t.ata_tm = p.ata*ones(1,1);
t.act_tm = p.act*ones(1,1);
t.PL_tm = p.PL*ones(1,1);
t.Fo_tm = 120*ones(1,1);
t.x02_tm = 0.1*ones(1,1);

%areas in t.ar_tm must span the columns, time points will span rows
%t.ar_tm only applies to supraglottal system.
%Use resample_areas_time.m to convert 0.0125 s intervals to 1/44100 intervals
%b = resample_areas_time(areas,.0125,1/44100);
%then t.ar_tm = b(:,1:44); 

%t.ar_tm = t.ar(1:h.inose)';
t.ar_tm = t.ar(1:h.jnose)';

%441 points is one cycle at 100 Hz - when Fs = 44100 Hz
%for NY 21  NZ 15
t.xiL = zeros(10*441*21,15);
t.xiR = zeros(10*441*21,15);

%for NY 21*2  NZ 15*2
% t.xiL = zeros(10*441*(21*2),(15*2));
% t.xiR = zeros(10*441*(21*2),(15*2));

t.ca = [1.0 -3.0743 3.5844 -1.9199 0.4108]';
t.cb = [0.0681 0.0 -0.1362 0.0 0.0681]';

t.cca = [1.0 -3.0743 3.5844 -1.9199 0.4108]';
t.ccb = [0.0681 0.0 -0.1362 0.0 0.0681]';

