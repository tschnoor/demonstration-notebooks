function qnew = Resample_qstruct(q,Nx)
%Nx = the new number of samples
if(isfield(q,'np') == 0);
    q.np = q.mc(:,1)*0;
end    


Nold = size(q.mc,1);

if(Nold < Nx)
    tmo = [0:Nold-1];
    tmn = [0:Nold/Nx:tmo(end)];
elseif(Nold > Nx)
     tmo = [0:Nold-1];
     %tmn = [0:Nx/Nold:tmo(end)];
     tmn = [0:Nold/Nx:tmo(end)];
else
    disp('New sample number is the same as the old: Nothing will be done');
    qnew = q;
    return;
end

qnew = q;

qnew = rmfield(qnew,['np';'mc'; 'lc'; 'ac'; 'rc'; 'sc'; 'gc'; 'pc' ]);
qnew = rmfield(qnew,['nqf']);

if(isempty(qnew.dT)==0)
    qnew = rmfield(qnew,['dT']);
    qnew.dT = interp1(tmo,q.dT(:,1),tmn)';
end


if(isempty(q.nqf)==0)
    for n=1:size(q.nqf,2)
        qnew.nqf(:,n) = interp1(tmo,q.nqf(:,n),tmn);
    end
else
    qnew.nqf = [];
end



if(isempty(q.areas)==0)
    qnew = rmfield(qnew,['areas']);
    for n=1:size(q.areas,2)
        qnew.areas(:,n) = interp1(tmo,q.areas(:,n),tmn);
    end    
end



for n=1:size(q.mc,2)
    qnew.mc(:,n) = interp1(tmo,q.mc(:,n),tmn);
    qnew.lc(:,n) = interp1(tmo,q.lc(:,n),tmn);
    qnew.ac(:,n) = interp1(tmo,q.ac(:,n),tmn);
    qnew.rc(:,n) = interp1(tmo,q.rc(:,n),tmn);
    qnew.sc(:,n) = interp1(tmo,q.sc(:,n),tmn);
end

qnew.np(:,1) = interp1(tmo,q.np(:,1),tmn);
qnew.gc(:,1) = interp1(tmo,q.gc(:,1),tmn);
qnew.pc(:,1) = interp1(tmo,q.pc(:,1),tmn);

if(isfield(q,'mctx') == 1)
    if(isempty(q.mctx)==0)
        qnew.mctx = interp1(tmo,q.mctx,tmn);
    end
end


qnew.td = 0.006866*size(qnew.mc,1);


if(isempty(q.fo)==0)
    ntmp = qnew.td/(length(q.fo)-1);
    tmo = [0:ntmp:qnew.td];
    tmn = [0:1/2000:qnew.td];
    qnew.fo = interp1(tmo,q.fo,tmn);
    qnew.fo = qnew.fo(:);
end

    
    
