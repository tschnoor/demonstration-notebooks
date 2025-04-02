
load E_ata_baseline.mat E

sti = [0 0 0 0 0 0 0];
mu = 0.99*[1 1 1 1 1 1 1];
gwi = [15 20 25 30 35 40 45];


for n=1:length(sti)
    E.C(2).gwi = gwi(n);
    E.C(2).rdp(4) = mu(n);
    E.C(2).sti = sti(n);
    
    E.G(2).sti = sti(n);
    
    Z = OratorVerbisComputisAlt(E);
    D(n).Z = Z
    D(n).E = E;
    
end
