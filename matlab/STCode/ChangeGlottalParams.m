function qnew = ChangeGlottalParams(q)

% pc = MovementTrajCos([1 10 60  73],[-1 0 0 -1.2]);
% gc = MovementTrajCos([1 5 60 73],[0.1 0 0 0]);
% 
q.x02r = 0.11;
q.x02l = 0.11;
q.npr = 0.9;
q.npl = 0.9;
q.pgap = 0.00;
q.xibl = 0.05;
q.xibr = 0.05;

% q.pc = pc(:);
% q.gc = gc(:);


q.dxnew = 0.42;
q.fotarg = 85;
q.F0contour = 2;  %use for dug series
%q.F0contour = 6;  %use for redo of Q series
qnew = q;

