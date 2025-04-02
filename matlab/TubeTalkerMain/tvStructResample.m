function tvn = tvStructResample(tv,Nnew,Nold)
%The purpose of this function is to build a default tv structure with the
%desired number of time samples (N).  The idea is that the relevant variables
%could be altered elsewhere.

if(Nnew < Nold)
inc = round(Nold/Nnew);

tmp = [1:inc:Nold];
Nnew = length(tmp);

tvn = tvStructGenerator(Nnew);

tvn.q = tv.q(1:inc:Nold,:);
tvn.mc = tv.mc(1:inc:Nold,:);
tvn.lc = tv.lc(1:inc:Nold,:);
tvn.ac= tv.ac(1:inc:Nold,:);
tvn.rc= tv.rc(1:inc:Nold,:);
tvn.sc= tv.sc(1:inc:Nold,:);
tvn.np= tv.np(1:inc:Nold,:);;
tvn.pg= tv.pg(1:inc:Nold,:);
tvn.pm= tv.pm(1:inc:Nold,:);;
tvn.lg= tv.lg(1:inc:Nold,:);;
tvn.rg= tv.rg(1:inc:Nold,:);
tvn.lm= tv.lm(1:inc:Nold,:);
tvn.rm= tv.rm(1:inc:Nold,:);
tvn.Fo = tv.Fo(1:inc:Nold,:);
tvn.Vamp = tv.Vamp(1:inc:Nold,:);
tvn.Fsp = 80;
tvn.N = Nnew;

else
    disp('Function not yet capable of upsampling');
end;
