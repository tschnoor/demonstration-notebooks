function mc = MovementTrajSin(Nv,Av)



mc = [];

Nv(1) = 0;
for i=1:length(Nv)-1
    
    mc = [mc;focontour_sin(Av(i),Av(i+1),Nv(i+1)-Nv(i))'];
    
end;

