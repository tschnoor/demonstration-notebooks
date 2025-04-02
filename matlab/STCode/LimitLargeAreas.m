function V = LimitLargeAreas(ar);


%----Same as in TubeTalkerAC.m-----------
        a = 1.;
        b = 1;
        V = ar(:);
        %V = V + ( (1/b)*exp(-a*V ));
        %V = V + ( -(1/b)*(1-exp(-a*V )) );
        
        x = V;
        %V = V + -(1/40)*((x-0) + .6*(x-0).^3)/40;
     
        
        a = 0.2;
        b = 1;
        tmp = (1-exp(a*(x-1)))/b;
        tmp(tmp>0) = 0;
        V = V + tmp;