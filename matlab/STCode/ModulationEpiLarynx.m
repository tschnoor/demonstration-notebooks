function areas = ModulationEpiLarynx(areas,Ae,Le);



c = 2-cgauss([1:44],Ae,1,Le);

for n = 1:size(areas,1)
    areas(n,1:44) = c(:)'.*areas(n,1:44);
end

