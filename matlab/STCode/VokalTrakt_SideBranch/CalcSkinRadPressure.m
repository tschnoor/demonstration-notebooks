function skinp = CalcSkinRadPressure(r,fs)


 [b,a] = butter(4,80/(fs/2),'high');

 skin = filtfilt(b,a,r.foo);
 aud = r.pout + 0.05*skin;
 
 skinp = 0.05*skin;
 