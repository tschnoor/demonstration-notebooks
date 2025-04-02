function c = CompressAreaGaussian(x,dc,lc,rc);
%

A = 2*log(8);
c = 0+dc*exp((-A)*((x-lc)/rc).^2);