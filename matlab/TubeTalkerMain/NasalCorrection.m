function [areas,nose0areas] = NasalCorrection(areas,nnose,jphrx);

load SideBranchData2011.mat
y  = nose1(1) + nose2(1);

N = size(areas,1);

%---calculate baseline-----
m = y/(nnose-1);
bl(1:6) = m*[0:5]+0;

for n=1:N
    m = (y-areas(n,45))/(nnose-1);
    nose0areas(n,1:6) = m*[0:5]+areas(n,45);
    
    ncorr = nose0areas(n,1:6)-bl;
    tmp = areas(n,jphrx:jphrx+5)-ncorr;
    tmp(tmp<0.05) = 0.05;  %check for negative areas
    areas(n,jphrx:jphrx+5) = tmp;
    
end

