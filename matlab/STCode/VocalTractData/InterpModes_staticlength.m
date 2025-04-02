function dbase = InterpModes_staticlength(stat,N);
jj = 1;

coeff = stat.coeff;
afactor = 1.3;
cf1 = afactor*min(coeff(1,:)); 
cf1inc =  (afactor*max(coeff(1,:)) - cf1)/(N-1);
cf2 = afactor*min(coeff(2,:));
cf2inc = (afactor*max(coeff(2,:)) - cf2)/(N-1);

%
tot_fmts=[];
tot_coeffs=[];
fmts = zeros(1,4);
hts = fmts;
minA = 0.05;
%arscale = 1;

dL = stat.dx;


for i = 1:N
    for j=1:N   
        
         V = cf1*stat.phi(1:44,1) + cf2*stat.phi(1:44,2); 
         lv = dL*ones(1,44);
        
        %----Same as in TubeTalkerAC.m-----------
        a = 1.75;
        b = 2.8;
        V = (V+stat.ne);
        V = V + ( (1/b)*exp(-a*V ).*cgauss([1:44],1.1,1,10)' );
        V = (pi/4)*V.^2;
        af = V;
        %-----Area scaling---------
        %mna = min(af);
        %mn = min(af.^arscale);
        %af = af.^arscale+ (mna-mn);
        %af = arscale*af;
        %af(af<minA) = minA; 
        %-------------------------
        
        af(45) = 0;
        %piri = [0.9228 0.6921 0.4614 0.2307];
        piri = [0 0 0 0];

       
        [fmts, vhts, vbw, wtrfall, zall, fx] = calc_areafmts_bw_piri(af(:)',dL*ones(44,1),44,3,piri+.0000001,dL*ones(1,4),6);
   
    
        %[h,z,f,D,h_alt] = VokalTraktM(af,lv,50,7000);
        %[fmts,hts] = formantid(20*log10(abs(h)),f,2);
        %[fmts2,hts] = formantid(20*log10(abs(h_alt)),f,2);
%         
%         if(length(fmts2) == 1)
%             fmts2(2:3) = fmts2(1);
%         elseif(length(fmts2) == 2)
%             fmts2(3) = fmts2(2);
%         end
        
        for kk =1:length(fmts)
            tot_fmts(jj,kk) = fmts(kk);
            %tot_fmts2(jj,kk) = fmts2(kk);
        end;
        
        
        tot_areas(jj,:) = af';
        tot_lengths(jj) = dL;
        tot_coeffs(jj,1) = cf1;
        tot_coeffs(jj,2) = cf2;
        
        
        clear af
        jj = jj+1;
        cf1 = cf1 + cf1inc;
    end;
    
    cf1 = afactor*min(coeff(1,:)); 
    cf2 = cf2 + cf2inc;
    i
end;

dbase.fmts = tot_fmts;
%dbase.fmts2 = tot_fmts2;
dbase.coeffs = tot_coeffs;
dbase.areas = tot_areas;
dbase.lengths = tot_lengths;
% ------------------------------------------------

