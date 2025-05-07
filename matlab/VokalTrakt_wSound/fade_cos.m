function b = fade_cos(a,rt,Fs);
%fade_cos.m
%B. Story
%a = input signal
%rt = rise time in seconds
%Fs = sampling freq


if(size(a,1) >1)
    a = a';
end
    
b = fadein_cos(a,rt,Fs);
b = fadeout_cos(b,rt,Fs);

if(size(b,1)==1)
    b = b';
end
