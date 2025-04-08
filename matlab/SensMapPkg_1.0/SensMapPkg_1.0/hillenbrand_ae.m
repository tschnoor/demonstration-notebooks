%TestCase_a.m
%Author: Brad Story
%Date: 07.03.2013

%Synopsis: this script loads an initial area function that would produce
%roughly a neutral vowel. The goal for the test is to perturb the initial
%area function so that its resonance frequencies are aligned with those
%given below (which are /a/-like).

%loads ar0 (area vector) and lv (tubelet length)
load TestCaseData

%set tolerance to 10 Hz 
tol = 10; 

%Set minimum area allowed at any point along the area function
minA = 0.1;

%===========TWO FORMANT MATCHING==================
%Assign target formant frequencies for a two-formant version; this means
%perturbation algorithm will attempt to match only these formants
F = [588 1952];
[sf,vfmts,areas,M] = SensMap(ar0,F,lv, tol, minA);

figure(1)
clf
subplot(2,1,1);
hold on
x = lv*[1:length(ar0)];
plot(x,ar0,'-k','LineWidth',2);
plot(x,areas(end,:),'-r','LineWidth',2);
h=legend('Initial','Final');
axis([0 x(end)+.5 0 max(areas(end,:))+1]);
grid
xlabel('Distance from Glottis (cm)');
ylabel('Area (cm^2)');
title('Initial and Final Area Functions');

subplot(2,1,2);
hold on
[h0,z,f,D,h_alt] = VokalTraktM(ar0,lv*ones(length(ar0),1),50,5000);
[h1,z,f,D,h_alt] = VokalTraktM(areas(end,:),lv*ones(length(ar0),1),50,5000);
plot(f,20*log10(abs(h0)),'-k','LineWidth',2);
plot(f,20*log10(abs(h1)),'-r','LineWidth',2);

%Add vertical lines to show the target formants
for n=1:length(F)
    plot([F(n) F(n)],[-20 60],'-k');
end

h=legend('Initial','Final');
axis([0 5000 -10 60]);
grid
xlabel('Frequency (Hz)');
ylabel('Rel. Ampl. (dB)');
title('Initial and Final Frequency Response Functions');



%===========THREE FORMANT MATCHING==================
%Assign target formant frequencies for a three-formant version; this means
%perturbation algorithm will attempt to match only these formants
F = [588 1952 2601];
[sf,vfmts,areas,M] = SensMap(ar0,F,lv, tol, minA);

figure(2)
clf
subplot(2,1,1);
hold on
x = lv*[1:length(ar0)];
plot(x,ar0,'-k','LineWidth',2);
plot(x,areas(end,:),'-r','LineWidth',2);
h=legend('Initial','Final');
axis([0 x(end)+.5 0 max(areas(end,:))+1]);
grid
xlabel('Distance from Glottis (cm)');
ylabel('Area (cm^2)');
title('Initial and Final Area Functions');

subplot(2,1,2);
hold on
[h0,z,f,D,h_alt] = VokalTraktM(ar0,lv*ones(length(ar0),1),50,5000);
[h1,z,f,D,h_alt] = VokalTraktM(areas(end,:),lv*ones(length(ar0),1),50,5000);
plot(f,20*log10(abs(h0)),'-k','LineWidth',2);
plot(f,20*log10(abs(h1)),'-r','LineWidth',2);

%Add vertical lines to show the target formants
for n=1:length(F)
    plot([F(n) F(n)],[-20 60],'-k');
end

h=legend('Initial','Final');
axis([0 5000 -10 60]);
grid
xlabel('Frequency (Hz)');
ylabel('Rel. Ampl. (dB)');
title('Initial and Final Frequency Response Functions');

% figure(3);
% plot(vfmts(:, 1), vfmts(:, 2));
% xlabel("F1 FREQUENCY (HZ)");
% ylabel("F2 FREQUENCY (HZ)");
% title("Formant Trajectories");
% 
% hold on;
% 

traj.ae = [vfmts(:, 1) vfmts(:, 2)];