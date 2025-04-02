function [nq,nqf] = get_tvcoeffs_dbase(fmts,dbase,dt)
%fmts = formants to match
%dbase = fmt-coeff dbase
%dt = sampling interval of the formants


fmts;

for i = 1:length(fmts)
    [q1,q2] = find_q1q2(dbase,fmts(i,:));
    nq(i,1:2) = [q1 q2];
end;


% norder = 6;
% [b,a] = butter(norder,15/((1/dt)/2));
% 
% if(length(nq)>norder*3)
%     for i=1:2
%         nqf(:,i) = filtfilt(b,a,nq(:,i));
%     end
%     
% else
%     nqf = nq;
% end



for i=1:2
    nqf(:,i) = smooth(nq(:,i),5);
end
