function PlotMultiEventFunctions_Full(Z,areas,minA,muflag);
iopj = [];
deltaflag = 0;

alphaX = 0.2;


if(muflag == 1)
    for j=1:size(Z.Tc,2)
        Z.Tc(:,j) = Z.Tc(:,j)*Z.P(4,j);
    end
end

cf = ['b';'r';'g';'b';'r';'g';'b';'r';'g';'b';'r';'g';'b';'r';'g';'b';'r';'g'];
cf = ['r';'r';'r';'r';'r';'r';'r';'r';'r';'r';'r';'r';'r';'r';'r';'r';'r';'r'];
%cf = ['b';'b';'b';'b';'b';'b';'b';'b';'b';'b';'b';'b';'b';'b';'b';'b';'b';'b'];
%cf = ['g';'g';'g';'g';'g';'g';'g';'g';'g';'g';'g';'g';'g';'g';'g';'g';'g';'g'];



open('MultiEventFunction_Template.fig');
clf

%-======Event function window===========
% hs1=subplot(4,1,1);
% set(hs1,'Position',[0.15,0.65,0.75,0.25]);
hs1 = axes('Position',[0.15,0.65,0.75,0.3]);

hold on

cfi = 1;

for k = 1:size(Z.Tc,2);
    
    tmf = Z.tmf;
    
    if(Z.P(4,k) < 0.94 & Z.P(4,k) > 0 & abs(Z.P(1,k)) >0)
        h =  fill([Z.tmf(:); Z.tmf(end); Z.tmf(1)],[Z.Tc(:,k); 0; 0],'k');
        set(h,'EdgeColor','none','FaceAlpha',alphaX);
        plot(tmf,Z.Tc(:,k),'-k','LineWidth',3);
    elseif(Z.P(4,k)>=0.95 & Z.P(4,k) < 1)
        h =  fill([Z.tmf(:); Z.tmf(end); Z.tmf(1)],[Z.Tc(:,k); 0; 0],'g');
        set(h,'EdgeColor','none','FaceAlpha',alphaX);
        plot(tmf,Z.Tc(:,k),'-k','LineWidth',3);
        
    elseif(Z.P(1,k)==0 & Z.P(2,k) == 0)
        h =  fill([Z.tmf(:); Z.tmf(end); Z.tmf(1)],[Z.Tc(:,k); 0; 0],'b');
        set(h,'EdgeColor','none','FaceAlpha',alphaX);
        plot(tmf,Z.Tc(:,k),'-k','LineWidth',3);
        
    elseif(Z.P(4,k) > 0 )
        h =  fill([Z.tmf(:); Z.tmf(end); Z.tmf(1)],[Z.Tc(:,k); 0; 0],'r');
        set(h,'EdgeColor','none','FaceAlpha',alphaX);
        plot(tmf,Z.Tc(:,k),'-k','LineWidth',3);
        
    end
    
    plot([0 tmf(end)],[1 1],'-k','LineWidth',.5);
    axis([0 1*tmf(end) 0 1.7]);
    %axis([0 3.1 0 2]);
    grid off
    set(gca,'FontSize',12);
    set(gca,'YTick',[0:.5:1]);
    xlabel('Time (sec.)');
    ylabel('Event magnitude');
    %ylabel('Event magnitude            ')
    
    if(tmf(end) > 1)
        set(gca,'XTick',[0:.5:4]);
    else
        set(gca,'XTick',[0:.1:2]);
    end
    
    
    
    tmp = max(Z.Tc(:,k));
    [i,j] = find(Z.Tc(:,k)-.5*tmp >= 0);
    %plot([tmf(i(1)) tmf(i(end))],[.5 .5],'-k','LineWidth',1);
    %plot([tmf(i(1)) tmf(i(end))],[.5 .5],'.k','MarkerSize',20);
    hw = tmf(i(end))-tmf(i(1));
    hw = round(hw*100)/100;
    tmpks = tmf(i(1)) + hw/2;
    pks = 1;
    
    if(k==1)
        tmpks = 1/146;
        pks = 1;
    end
    
    %plot([tmpks tmpks],[0 pks],'-k','LineWidth',1)
    if(Z.P(4,k) > 0)
    plot(tmpks,pks,'.k','MarkerSize',20);
    end
    
    
    
    if(deltaflag == 1)
        set(gca,'XTick',[0:.1:tmf(end)],'YTick',[0:.25:1 ]);
        tmpks = tmpks-.02;
        if(Z.P(3,k) >= 0)
            h3 = text(tmpks,pks+.4,['\delta_3 =  ' num2str(Z.P(3,k))],'FontSize',12);
        else
            h3 = text(tmpks,pks+.4,['\delta_3 = ' num2str(Z.P(3,k))],'FontSize',12);
        end
        
        if(Z.P(2,k) >= 0)
            h2 = text(tmpks,pks+.25,['\delta_2 =  ' num2str(Z.P(2,k))],'FontSize',12);
        else
            h2 = text(tmpks,pks+.25,['\delta_2 = ' num2str(Z.P(2,k))],'FontSize',12);
        end
        
        if(Z.P(1,k) >= 0)
            h1 = text(tmpks,pks+.1,['\delta_1 =  ' num2str(Z.P(1,k))],'FontSize',12);
        else
            h1 = text(tmpks,pks+.1,['\delta_1 = ' num2str(Z.P(1,k))],'FontSize',12);
        end
        
        h0 = text(tmpks,pks+.55,['\mu =   ' num2str(Z.P(4,k))],'FontSize',12,'FontWeight','bold');
        %h0 = text(tmpks,pks+.55,[' ' num2str(Z.P(4,k))],'FontSize',12,'FontWeight','bold');
        %h3 = text(0,1.55,['\mu' ],'FontSize',12,'FontWeight','bold');
        %h = text(tmpks,pks+.05,['\delta_3 = -1';'\delta_2 =  1';'\delta_1 =  1'])
        h = text(tmpks,.43,['w = ' num2str(hw) ' s'],'FontSize',12);
    else
        set(gca,'XTick',[0:.1:tmf(end)],'YTick',[0:.25:1 1.1 1.25 1.4]);
        tmpks = tmpks-.01;
        if(k==1)
            %             h3 = text(-.02,pks+.42,['\delta_3   ' ],'FontSize',12);
            %             h3 = text(-.02,pks+.27,['\delta_2   ' ],'FontSize',12);
            %             h3 = text(-.02,pks+.12,['\delta_1   ' ],'FontSize',12);
            
            C = {[0:.25:1]';'\delta_1';'\delta_2';'\delta_3'};
            D = {'0';'0.25';'0.50';'0.75';'1.0';'\delta_1';'\delta_2';'\delta_3'};
            set(gca,'YTickLabel',D);
            
        end
        if(Z.P(4,k) > 0)
        if(Z.P(3,k) >= 0)
            h3 = text(tmpks,pks+.4,[' ' num2str(Z.P(3,k))],'FontSize',8);
        else
            h3 = text(tmpks,pks+.4,[num2str(Z.P(3,k))],'FontSize',8);
        end
        
        if(Z.P(2,k) >= 0)
            h2 = text(tmpks,pks+.25,[' ' num2str(Z.P(2,k))],'FontSize',8);
        else
            h2 = text(tmpks,pks+.25,[ num2str(Z.P(2,k))],'FontSize',8);
        end
        
        if(Z.P(1,k) >= 0)
            h1 = text(tmpks,pks+.1,[' ' num2str(Z.P(1,k))],'FontSize',8);
        else
            h1 = text(tmpks,pks+.1,[num2str(Z.P(1,k))],'FontSize',8);
        end
        
        %h0 = text(tmpks,pks+.55,['\mu =   ' num2str(Z.P(4,k))],'FontSize',12,'FontWeight','bold');
        h0 = text(tmpks,pks+.55,[' ' num2str(Z.P(4,k))],'FontSize',8,'FontWeight','bold');
        %h3 = text(0,1.55,['\mu' ],'FontSize',12,'FontWeight','bold');
        end
    end
    
end

h3 = text(-.05,1.55,['\mu' ],'FontSize',10,'FontWeight','bold');
grid on


%=============F0==============
% hs2=subplot(4,1,2);
% set(hs2,'Position',[0.15,0.4,0.75,0.1]);
hs2 = axes('Position',[0.15,0.48,0.75,0.12]);
hold on

tmfo = [0:1/2000:(length(Z.fo)-1)/2000];

h =  fill([tmfo(:); tmfo(end); tmfo(1)],[Z.fo; 0; 0],'k');
set(h,'FaceColor',[0 50 100]/256);
set(h,'EdgeColor','none','FaceAlpha',alphaX);
plot(tmfo,Z.fo,'-k','LineWidth',3);
axis([0 1*tmf(end) min(Z.fo)-10 max(Z.fo)+20]);
%axis([0 3.1 0 2]);
grid on
set(gca,'FontSize',12);
set(gca,'YTick',[50:50:350]);
set(gca,'XTick',[0:.1:tmf(end)]),
xlabel('Time (sec.)');
ylabel('f_o (Hz)');


%=============fo alternative==============
% hs2=subplot(4,1,2);
% 
% hold on
% 
% for k = 1:size(Z.Tf,2);
%     h =  fill([Z.tmf(:); Z.tmf(end); Z.tmf(1)],[Z.Tf(:,k); 0; 0],'k');
%     set(h,'EdgeColor','none','FaceAlpha',alphaX);
%     plot(tmf,Z.Tf(:,k),'-k','LineWidth',3);
%     
% end
% 
% axis([0 1*tmf(end) -.4 .6]);
% grid on
% set(gca,'FontSize',12);
% set(gca,'YTick',[-.4:.1:.6]);
% set(gca,'XTick',[0:.1:tmf(end)]),
% xlabel('Time (sec.)');
% ylabel('\Delta f_o');

%=============Adduction==============
% hs3=subplot(4,1,3);
% set(hs3,'Position',[0.15,0.25,0.75,0.1]);
hs3 = axes('Position',[0.15,0.25,0.75,0.15]);

hold on

for k = 1:size(Z.Tg,2);
    h =  fill([Z.tmf(:); Z.tmf(end); Z.tmf(1)],[Z.Tg(:,k); 0; 0],'k');
    set(h,'FaceColor',[255 128 0]/256);
    set(h,'EdgeColor','none','FaceAlpha',alphaX);
    plot(tmf,Z.Tg(:,k),'-k','LineWidth',3);
    
end

axis([0 1*tmf(end) 0 .15]);
grid on
set(gca,'FontSize',12);
set(gca,'YTick',[0:.05:.15]);
set(gca,'XTick',[0:.1:tmf(end)]),
xlabel('Time (sec.)');
ylabel('\xi_{02} (cm)');


%=============Nasal==============

% hs4=subplot(4,1,4);
% set(hs4,'Position',[0.15,0.1,0.75,0.1]);
hs4 = axes('Position',[0.15,0.1,0.75,0.1]);

hold on

for k = 1:size(Z.Tn,2);
    h =  fill([Z.tmf(:); Z.tmf(end); Z.tmf(1)],[Z.Tn(:,k); 0; 0],'k');
    set(h,'FaceColor',[0 100 0]/256);
    set(h,'EdgeColor','none','FaceAlpha',alphaX);
    plot(tmf,Z.Tn(:,k),'-k','LineWidth',3);
    
end

axis([0 1*tmf(end) 0 .15]);
grid on
set(gca,'FontSize',12);
set(gca,'YTick',[0:.05:.2]);
set(gca,'XTick',[0:.1:tmf(end)]),
xlabel('Time (sec.)');
ylabel('A_{np} (cm^2)');


%============WAVEFORM==============================
%
% fs = 44100;
% h=subplot(3,1,1);
% set(h,'Position',[0.15 0.7 0.75 0.1]);
% hold on
%
% tma = [0:1/fs:(length(Z.aud)-1)/fs];
% plot(tma,Z.aud,'-k','LineWidth',1);
% axis([0 Z.tmf(end) -1 1]);
% if(tmf(end) > 1)
%     set(gca,'XTick',[0:.2:2]);
% else
%     set(gca,'XTick',[0:.1:2]);
% end
%
% %set(gca,'XTick',[0:.1:tmf(end)]);
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
% ylabel('Audio','FontSize',18);
% grid on
%
%

