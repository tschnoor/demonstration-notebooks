function PlotFmtMesh_trim(tot_fmts,Ni,c,h,delta)

cn = .6;

if(h ==1)
   figure(1)
   clf
   hold on;
end;

% delta = 170;
% delta = 3000;

%tot_fmts = tot_fmts/1000;
N = Ni*Ni;
for i = 1:Ni
    
    n1 = (i-1)*Ni+1;
    n2 = Ni*i;
   
    tmp1 = (tot_fmts(n1:n2,1));
    tmp2 = (tot_fmts(n1:n2,2));
    
    [j,k] = find(abs(diff(tmp2))>delta);
    if(isempty(j) == 0)
        n2 = j(1);
        %tmp1 = tmp1(1:n2);
        %tmp2 = tmp2(1:n2);
        
        tmp1 = tmp1(n2+1:end);
        tmp2 = tmp2(n2+1:end);
    end
    
    
    
    %plot(tmp1,tmp2,c,'MarkerSize',2,'LineWidth',.5);
    plot(tmp1,tmp2,c,'MarkerSize',2,'LineWidth',.5,'Color',[cn cn cn]);
    
    
    n1 = i;
    n2 = 0;
   
    tmp1 = (tot_fmts(i:Ni:N,1));
    tmp2 = (tot_fmts(i:Ni:N,2));
    
    [j,k] = find(abs(diff(tmp2))>delta);
    if(isempty(j) == 0)
        n1 = j(1);
        %tmp1 = tmp1(n1+1:end);
        %tmp2 = tmp2(n1+1:end);
        
        tmp1 = tmp1(1:n1);
        tmp2 = tmp2(1:n1);
    end
    
    %plot(tmp1,tmp2,c,'MarkerSize',2,'LineWidth',.5);
    plot(tmp1,tmp2,c,'MarkerSize',2,'LineWidth',.5,'Color',[cn cn cn]);
    
	%plot(tot_fmts((i-1)*Ni+1:Ni*i,1),tot_fmts((i-1)*Ni+1:Ni*i,2),c,'MarkerSize',1,'LineWidth',.5);
	%plot(tot_fmts(i:Ni:N,1),tot_fmts(i:Ni:N,2),c,'MarkerSize',1,'LineWidth',.5);



end;
%axis([0 1000/1000 0 2800/1000]);
axis([200 1800 250 5000]);
%axis([0 1000 0 3500]);

set(gca,'PlotBoxAspectRatio',[1 1 1],'FontSize',16,'XTick',[0:500:1500],'YTick',[500:1000:5000]);
% xlabel('F_1 (Hz)');
% ylabel('F_2 (Hz)');

%used for SVBD paper
% xlabel('f_{R1} or F_1 (Hz)');
% ylabel('f_{R2} or F_2 (Hz)');

xlabel('f_{R1} ');
ylabel('f_{R2} ');

grid on





	
