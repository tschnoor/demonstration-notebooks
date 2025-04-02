function V = LimitSmallAreas(ar);


%----Same as in TubeTalkerAC.m-----------
        a = 2;
        b = 6;
        V = ar(:);
        %V = V + ( (1/b)*exp(-a*V ));
        
        V = V + ( (1/b)*exp(-a*V ).*cgauss([1:44],1.1,1,10)' );
        
      