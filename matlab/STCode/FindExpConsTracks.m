function [V,P] = FindExpConsTracks(C,xlimExp,xlimCons);

j = 1;
jj = 1;
H = [];
for n=1:size(C,1)
    [xpks, pks, index] = FindPeaksValleys([1:xlimCons], -C(n,1:xlimCons));
    if(isempty(xpks)==0)    
        V(j,1) = n;
        V(j,2) = xpks(end);
        V(j,3) = -pks(end);
        j = j+1;
    end
    
    [xpks, pks, index] = FindPeaksValleys([1:xlimExp], C(n,1:xlimExp));
    if(isempty(xpks)==0)    
        P(jj,1) = n;
        P(jj,2) = xpks(end);
        P(jj,3) = pks(end);
        jj = jj+1;
    end
    
    
end


