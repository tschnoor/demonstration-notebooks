function [act,ata,q,Z] = Transform_F0_MuscleAct(Z,act0,ata0,sf,Lo);


M = sum(Z.Tf,2);
Fs = round(35000/(2*Z.q.dxnew));
%dur = length(Z.Tf(:,1))/146;
Ndur = ceil(Fs*Z.q.td)

act = log10((M-min(M))*sf + 1) + act0;


tmp = -log10((M-min(M))*sf + 1);
tmp = tmp - min(tmp);

ata = act*0 + ata0;

tmo = [0:1/146:(length(act)-1)/146];
tmn = [0:1/Fs:Z.q.td];

y1 = interp1(tmo(:),act(:),tmn(:),'pchip');
y2 = interp1(tmo,ata,tmn,'pchip');



q = Z.q;
q.act = y1(:)';
q.ata = y2(:)';
q.x02l = 0.01;
q.x02r = 0.01;
q.Lo = Lo;

Z.act = act;
Z.ata = ata;

