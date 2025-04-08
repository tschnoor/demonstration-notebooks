function [S,K,P,fmts,Press,Flow] = sens_functions(ar,lv,wtype)
%Matlab function used to calculated acoustic sensitivity functions of an
%area function (vocal tract shape).
%Author: Brad Story
%Last revision: 05-19-08
%
%INPUT:
%ar = area function; often a 44-element vector
%lv = length of each section of the area function; typically a scalar, but
%could be vector if variable length sections were desired.
%wtype = vocal tract wall type; "s" or "y" indicates yielding walls, and
%"h" is a hard walled version. Typically would use "s" or "y".
%
%OUTPUT
%S = matrix of sensitivity functions
%K = matrix of kinetic energy functions
%P = matrix of potential energy functions
%fmts = formant frequencies calculated for the input area function
%Press = matrix of pressure along the vocal tract
%Flow =  matrix of volume velocity along the vocal tract.



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


%First calculate the formant frequencies of the area function
[tf, zin,f,D, tf_alt,Zrad] = VokalTraktM(ar,xvect,Nloss,5000);
[fmts, heights ] = formantid( 20*log10(abs(tf)), f,6);
fmts;

%Now - based on the calculated formants, determine the acoustic sensitivity
%of the area function at each formant frequency
S = [];
K = [];
P = [];
for i=1:6
   if(i <= length(fmts))
       fmts(i);
      [Po,Uo,sens,kin,pot] = sensitivity(ar,xvect,fmts(i),Nloss,5000);
      
      %S(:,i) = sens/max(abs(sens));
      S(:,i) = sens;
      K(:,i) = kin;
      P(:,i) = pot;
      Press(:,i) = Po';
      Flow(:,i) = Uo';
   end;
end;



