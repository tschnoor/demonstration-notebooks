function c = cgauss_nolimits(x,dc,lc,rc);
%

A = 2*log(4);
c = 1-dc*exp((-A)*((x-lc)/rc).^2);

%2.7725 for width at the "half power" point, 18 for width at 3 standard deviations
