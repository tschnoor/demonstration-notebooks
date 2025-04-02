
load E_ata_baseline.mat E

sti = [10 5 2 0 0 0 0 0 0];
mu = [1 1 1 1 1 0.99 0.98 0.97 0.96];


for n=1:length(sti)
    E.C(2).rdp(4) = mu(n);
    E.C(2).sti = sti(n);
    E.G(2).sti = sti(n);
    
    Z = OratorVerbisComputisAlt(E);
    D(n).Z = Z
    D(n).E = E;
    
end
