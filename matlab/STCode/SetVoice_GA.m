function q = SetVoice_GA(q,Ev,Egc);


N = length(q.mc);

pk = 0.1; 
qo = .4;
qs = 2.;

%===============Set up Source params=================

% 
% pc = sum(E'); 
% pc = pc/max(pc);
% 
% [b,a] = butter(2,10/(146/2));
% pc(pc>.5) = 1;
% pc = filtfilt(b,a,pc);
% 
% gc = pc;
% pc = pc-max(pc);
% q.pc = pc(:)*q.PL;
% 
% gc = (1-gc)*.1;
% gc = gc-min(gc)+.005;
% q.gc = gc(:);

%--------Determine new sampling freq.-----------------
if(q.dxnew == 0.396825)
    fs = 44100;
else
    fs = round(35000/(2*q.dxnew));
end

fsn = 2000;
Nfo = ceil(fsn*(N/146));



if(q.F0contour == 1)  
    fo = MovementTraj([1 round(.3*Nfo)  Nfo],[.85*q.fotarg 1.2*q.fotarg  .70*q.fotarg]);
elseif(q.F0contour == 2)
    fo = MovementTraj([1 round(.05*Nfo) round(.65*Nfo)  Nfo],[.85*q.fotarg 1.3*q.fotarg 1.0*q.fotarg  .8*q.fotarg]);
elseif(q.F0contour == 3)
    fo = MovementTraj([1 round(.3*Nfo)  Nfo],[1*q.fotarg 1.2*q.fotarg  .7*q.fotarg]);
elseif(q.F0contour == 4)
    fo = MovementTrajCos([1  round(.5*Nfo)  round(.7*Nfo) Nfo],[1.*q.fotarg  .9*q.fotarg 1.35*q.fotarg  .85*q.fotarg]);
elseif(q.F0contour == 5)
    fo = MovementTrajCos([1  round(.2*Nfo)  round(.4*Nfo) Nfo],[1.*q.fotarg  .9*q.fotarg 1.35*q.fotarg  .85*q.fotarg]);
elseif(q.F0contour == 6)
    fo = MovementTrajCos([1    Nfo],[1*q.fotarg   1*q.fotarg]);
else
    fo = MovementTrajCos([1   Nfo],[1.1*q.fotarg 0.8*q.fotarg]);
end

disp('at 56');
if(isempty(Ev) == 0)
    Ev = sum(Ev,2)+1;
    if(length(Ev)>Nfo)
        Ev = Ev(1:length(Nfo));
    elseif(length(Ev) < Nfo)
        Ev(end:Nfo) = 0;
    end
    fo = fo(:).*Ev(:);   
end

if(q.FMext > 0)
    tfo = [0:1/fsn:(length(fo)-1)/fsn];
    fo = fo(:).*(1 + q.FMext*sin(2*pi*q.FMfreq*tfo'));
end

q.fo = fo(:);

fo
disp('at 74');

fox = Convert_LongFO_to_CycleF0(fo,fsn);
fox(end+1) = fox(end);

if(isempty(Egc) == 0)
    Egc = sum(Egc');
    q.gc = Egc(:);   
end


ga = MakeGlottalAreaSignal(fox,pk,qo,qs,q.gc,fs);
q.vox = ga(:);



%======




