function [S,B,K,P,fmts,Press,Flow] = sens_functions_sbranch(ar,lv,Ap,Lp,N_piri,wtype)
%

% [h,Zin,f,D] = cascade(ar,lv*ones(length(ar),1),length(ar)+1,5000);
% [fmts, heights ] = formantid( 20*log10(abs(h)), f,4);

if(wtype == 's' | wtype == 'y')
    Nloss = length(ar)+1;
elseif(wtype == 'h')
    Nloss = 0;
else
    disp('wtype variable needs to be s, y, or h');
end;

if(length(lv) ==1)
    xvect = lv*ones(length(ar),1);
elseif(length(lv)>1)
    if(length(lv) ~= length(ar))
        disp('xvector and area function must have the same number of sections');
        return;
    else
        xvect = lv;
    end;
end;

[tf,zin,f,D,tf_alt,Zrad] = VokalTraktM_piri(ar,xvect,Nloss,5000,Ap,Lp,N_piri);
[fmts, heights ] = formantid( 20*log10(abs(tf)), f,6);
%[fmts, heights ] = formantid( 20*log10(abs(tf_alt)), f,6);


S = [];
K = [];
P = [];

for i=1:5
   if(i <= length(fmts))
       fmts(i);
      [Po,Uo,sens,kin,pot] = sensitivity_sbranch(ar,xvect,fmts(i),Nloss,5000,Ap,Lp,N_piri);
      
      %S(:,i) = sens/max(abs(sens));
      S(:,i) = sens;
      K(:,i) = kin;
      P(:,i) = pot;
      Press(:,i) = Po';
      Flow(:,i) = Uo';
   end;
end;

B = S;
B(B>=0) = 1;
B(B<0) = -1;
