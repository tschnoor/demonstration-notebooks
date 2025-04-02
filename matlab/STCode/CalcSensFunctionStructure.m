function [sf, Ftarg, ar] = CalcSensFunctionStructure(areas,dx)


for n=1:size(areas,1)
    n;
    ar = areas(n,1:44);
    ar(ar<.01) = .01; 
    [S,Bx,K,P,fmts,Press,Flow] = sens_functions(ar,dx,'y');
    sf(n).S = S;
    sf(n).ar = areas(n,1:44);
    sf(n).fmts = fmts;
end

Ftarg = sf(end).fmts;
ar = sf(end).ar;