function b = xfer_to_impulse(h)
%

hc = conj(h);
hc = hc(2048:-1:1);
zoo = [h;hc];
dfoo = ifft(zoo,4096);
b = real(dfoo);
b(2048:end) = 0;

