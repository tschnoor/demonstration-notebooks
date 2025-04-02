function dbase = CalcSensFunction_dbase(dbase);


S1 = dbase.areas(:,1:44)*0;
S2 = S1;
S3 = S1;

for n=1:size(dbase.areas,1)
    
    [S] = sens_functions(dbase.areas(n,1:44),.4,'y');
    
    S1(n,:) = S(:,1)';
    S2(n,:) = S(:,2)';
    S3(n,:) = S(:,3)';
    
end

dbase.S1 = S1;
dbase.S2 = S2;
dbase.S3 = S3;