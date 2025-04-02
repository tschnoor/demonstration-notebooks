function q = Recalc_F0_contour(q,E,fotarg_new);

N = E.N;

%NOTE (06.28.18): New variable in structures called 'sti' means 'saturation
%index' and allows for sustaining a gesture over some amount of time -
%however, time is indicated by number of time samples like other parameters
%(hence the 'i' in the name).

if(isfield(E,'sti_flag') == 1)
    sti_flag = E.sti_flag;
else
    %sti_flag = 1; %---this option puts Npk in the middle of sti; use 2 for beginning
    sti_flag = 2; %---this option puts Npk in the middle of sti; use 2 for beginning
end


if(isfield(E,'randF0') == 1)
    randF0 = E.randF0;
else
    randF0 = 0;
end


%-----Generate timing functions for adduction -----

for n=1:length(E.G)
    
    if(isfield(E.G(n),'sti') == 0 || isempty(E.G(n).sti) == 1)
        E.G(n).sti = 0;
    end
    Tg(:,n) = MovementTrajGaussianSkewHold(N,E.G(n).tmi,E.G(n).gwi,E.G(n).xi,E.G(n).skw,E.G(n).sti,sti_flag)';
end

q.gc = sum(Tg,2);


%-----Generate timing functions for fo -----
for n=1:length(E.fo)
    
    if(isfield(E.fo(n),'sti') == 0 || isempty(E.fo(n).sti) == 1)
        E.fo(n).sti = 0;
    end
    Tf(:,n) = MovementTrajGaussianSkewHold(N,E.fo(n).tmi,E.fo(n).gwi,E.fo(n).sffo,E.fo(n).skw,E.fo(n).sti,sti_flag)';
end

fo = sum(Tf,2);

gcoffset = 0.03;
%fogc = 1-fo;
%fogc = (1+fo).^2;
%fogc = fogc-min(fogc);
%fogc = gcoffset*fogc/max((fogc));
fogc = fo/max(abs(fo));
fogc = gcoffset*fogc;


fo = fo + 1;
tmo = [0:0.006866:(length(fo)-1)*.006866];
tmn = [0:1/2000:tmo(end)+.006866];
F0 = interp1(tmo,fo,tmn,'spline'); %---resample to fs = 2000 Hz

%-FM-----
s = q.FMext*sin(2*pi*q.FMfreq*tmn) + 1;
F0 = F0(:).*s(:);

q.fo = F0(:)*fotarg_new;

if(randF0 == 0)
    %---impose fo variation on fo contour-----
    fsfo = 2000;
    tm = [0:1/fsfo:(length(q.fo)-1)/fsfo];
    
    %     cn = dsp.ColoredNoise('Color','pink','SamplesPerFrame',length(q.fo));
    %     y = cn();
    
    y = pinknoise(length(q.fo));
    [b,a] = butter(2,20/(2000/2),'high');
    y = filtfilt(b,a,y);
    y = y/max(abs(y));
    s = 1+ q.FMext*sin(2*pi*5*tm(:)) + q.jitterOVC*y(:);
    q.fo = s(:).*q.fo(:);
else
    
    %----Random fo--------
    fsfo = 2000;
    [b,a] = butter(2,3/(fsfo/2));
    y = rednoise(length(q.fo));
    y = filtfilt(b,a,y);
    y = y/max(abs(y));
    q.fo = ((y(:)*.2+1).*q.fotarg);
    y = pinknoise(length(q.fo));
    [b,a] = butter(2,20/(2000/2),'high');
    y = filtfilt(b,a,y);
    y = q.fotarg*q.jitterOVC*y/max(abs(y));
    q.fo = q.fo+y(:);
end

q.fotarg = fotarg_new;

%Modify the TV adduction based on fo change 
q.gc = fogc(:) +q.gc;