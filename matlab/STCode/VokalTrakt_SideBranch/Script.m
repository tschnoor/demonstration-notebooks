
% 
% 
% for n=1:length(Saa)
%     
%     
%      [f,wtrfall,afmts,ahts,abw,wtrfallm,t,wtrfalln] = VokalTraktModerMouthMale_FBW(Saa(n).areas(1:30,:),.396825,0);
%      
%      Saa(n).f = f;
%      Saa(n).hmn = wtrfall(29,:);
%      Saa(n).hm = wtrfallm(29,:);
%      Saa(n).hn = wtrfalln(29,:);
%      
%      
%      [f,wtrfall,afmts,ahts,abw,wtrfallm,t,wtrfalln] = VokalTraktModerMouthMale_FBW(Sii(n).areas(1:30,:),.396825,0);
%      
%      Sii(n).f = f;
%      Sii(n).hmn = wtrfall(29,:);
%      Sii(n).hm = wtrfallm(29,:);
%      Sii(n).hn = wtrfalln(29,:);
%      
% end

     

figure(1)
clf
hold on
da = 8;

plot(Saa(1).f,Saa(1).hmn,'-r','LineWidth',3);
for n=2:length(Saa)
    
    plot(Saa(n).f,Saa(n).hmn+(n-1)*da,'-k','LineWidth',1);
    
end

 axis([0 6000 15 190]) 
 set(gca,'PlotBoxAspectRatio',[1 1 1])
 set(gca,'FontSize',12)
 grid
 xlabel('Frequency (Hz)');
set(gca,'YTickLabel',[]);

figure(2)
clf
hold on

 plot(Sii(1).f,Sii(1).hmn,'-r','LineWidth',3);
for n=2:length(Sii)
    plot(Sii(n).f,Sii(n).hmn+(n-1)*da,'-k','LineWidth',1);
    
end
axis([0 6000 15 190]) 
set(gca,'PlotBoxAspectRatio',[1 1 1])
set(gca,'FontSize',12)
grid
xlabel('Frequency (Hz)');
set(gca,'YTickLabel',[]);