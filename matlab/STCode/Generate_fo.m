function q = Generate_fo(q,E,randF0)
%note E is one word within "E"; e.q. q = Generate(q,E(1));


N = E.N;
sti_flag = 1; %---this option puts Npk in the middle of sti; use 2 for beginning

%-----Generate timing functions for fo -----
for n=1:length(E.fo)
    
    if(isfield(E.fo(n),'sti') == 0 || isempty(E.fo(n).sti) == 1)
        E.fo(n).sti = 0;
    end
    Tf(:,n) = MovementTrajGaussianSkewHold(N,E.fo(n).tmi,E.fo(n).gwi,E.fo(n).sffo,E.fo(n).skw,E.fo(n).sti,sti_flag)';
end

fo = sum(Tf,2);
fo = fo + 1;
tmo = [0:0.006866:(length(fo)-1)*.006866];
tmn = [0:1/2000:tmo(end)+.006866];
F0 = interp1(tmo,fo,tmn,'spline'); %---resample to fs = 2000 Hz

q.fo = F0(:)*q.fotarg;

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

