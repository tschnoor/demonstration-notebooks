function ug = flowsource(source_params,Fsp,Fs);

% source_params is a two column matrix where col 1 is the Fo and col 2 is
% the flow amplitude
% Fsp = sampling frequency of the source params (e.g. 80 Hz)
% Fs = audio sampling frequency (e.g. 44100 Hz)

%Example function call: 
% ug = flowsource(source_params,80,44100);

%---Set up some constants and defaults

    rho = 0.00114;
    Qs = 2;
    Qo = 0.6;
    Uac = 0;
    dt = 1/Fs;
    
%---- Set up some numbers for my interpolator - you probably won't need to do this

    Nfrm = length(source_params);
    N = floor((Nfrm/Fsp)*Fs);
    Nwind = round(Fs/Fsp)
    ncnt = 0;
    frmcnt = 1;
  
 %---- Allocate memory for the output vector
 
    ug = zeros(N,1);
    
 %---- Assign some initial params before the time loop begins   
    freqp = source_params(1,1);
    theta = 0;
    gama = 64.*( Qs - 1.0);
	beta = 	Qo + 1.0;
    
    
    for n=1:N-Nwind
        
    %------This is all interpolation (Siddharth: you can use the same interpolator you are using 
    % for the areas and lengths 
        
    if(ncnt < Nwind)
    
        A = source_params(frmcnt,1);
	    B = source_params(frmcnt+1,1);
	    freq = (B-A)*ncnt/Nwind + A;
        
        
        A = source_params(frmcnt,2);
	    B = source_params(frmcnt+1,2);
	    ampl = (B-A)*ncnt/Nwind + A;
		
        ncnt = ncnt + 1;
    else
        ncnt = 0;
	    frmcnt = frmcnt + 1;
    end
    
    %-------------End of interpolation - Begin signal generator----------------------------
    
    
        plg=ampl*freq/7.5;	
	    vo=sqrt(2*plg/rho);	
        
        
        
        theta = theta+pi*(freq + freqp)*dt;
        
        if(theta > 2*pi) 
            theta = theta - 2*pi;
            freqp = freq;
        end;
        
        if(theta < Qo*2*pi-.00001 && ampl > 0) 
		    th = theta/(2.* Qo);
            sinfun = sin(th)^beta;
		    ga = ampl*sinfun/vo;
		    up = max(0.,Uac);
		    Uac = max(0.,ampl*sinfun);
		    d = max(0.,gama*sinfun);
		    hold = sqrt( (Uac * Uac)*(1.+d*d)+2.*d*up * Uac );
		    Uac = max(0.,hold-d * Uac);  
	    else 
		    up = Uac;
		    Uac = 0.0;
		    ga = 0.0; 
        end;
        
        ug(n) = Uac;
      
        
        
    end;
    
	