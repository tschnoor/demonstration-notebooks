function c = ConstraintValue(yval,y0,yext,ypk)
% ypk = 0;
% yext = 0.7;
% y0 = 0.5;
%dy = .01;

Apk = 1;

A = 2*log(4);

if(yval < ypk)
    c = 1;
else
    c = (Apk-y0)*exp((-A)*((yval-ypk)/yext).^2) + y0;
end


% A = 2.7725 for width at the "half power"