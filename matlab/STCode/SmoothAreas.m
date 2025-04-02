function nareas = SmoothAreas(areas)

nareas = areas;

for n = 1:44
    nareas(:,n) = medfilt1(areas(:,n),5);
    nareas(:,n) = smooth(nareas(:,n),5);
end

