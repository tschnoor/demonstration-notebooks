function [tme,vl,tvect] = peakfind_view(x,vw,fs);
%
%vw = 500;
dt = 1/fs; 
t = [0:dt:(length(x)-1)*dt];
ind = 1;

for i = 1:length(x)-vw
  
  [y,j] = max(x(i:i+vw));
  if(j == round(vw/2) )
    tme(ind) = t(i+(j-1));
    vl(ind) = x(i+(j-1));
    tvect(ind) = i+(j-1);
    ind = ind+1;
        
  end;
end;
%tme;

vl = [x(1); vl(:); x(end)];
tme = [t(1); tme(:); t(end)];
tvect = [1; tvect(:); length(x)];




