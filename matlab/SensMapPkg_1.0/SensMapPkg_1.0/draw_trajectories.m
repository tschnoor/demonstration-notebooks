%interpolate with cubic spline and pchip algo
%set gcf parameters

clf;
clc;

frames = 200;

vowels = {'aa', 'ae', 'ah', 'ao', 'eh', 'er', 'ey', 'ih', 'iy', 'ow', 'uh', 'uw'};
ipa = {'ɑ', 'æ', 'ʌ', 'ɔ', 'ɛ', 'ɝ', 'eɪ', 'ɪ', 'i', 'oʊ', 'ʊ', 'u'}

animation(frames) = struct('cdata', [], 'colormap', []);

%% Initialize video
myVideo = VideoWriter('trajectories', "MPEG-4"); %open video file
myVideo.FrameRate = 10;  %can adjust this, 5 - 10 works well for me
open(myVideo)

f = figure;
% f.Visible = 'off';
% set(gcf, 'color', 'none');
hold on;
axis manual;
axis([300, 1200, 600, 3400])
set(gca, 'Xtick', [], 'Ytick', []);


for v = 1:length(vowels)
    vowel = vowels{v};
    form1 = traj.(vowel)(:, 1);
    form2 = traj.(vowel)(:, 2);
    old = linspace(0, 1, length(form1));
    new = linspace(0, 1, frames);
    f1.(vowel) = interp1(old, form1, new, "pchip");
    f2.(vowel) = interp1(old, form2, new, "pchip");
end

for i = 1:frames
    for v = 1:length(vowels)
        vowel = vowels{v};
        plot(f1.(vowel)(1:i), f2.(vowel)(1:i))
        text(f1.(vowel)(i), f2.(vowel)(i), strcat('\leftarrow ', ipa{v}))
    end
    % animation(i) = getframe;
    frame = getframe(gcf); %get frame
    writeVideo(myVideo, frame);
    cla;
end

hold off;
% f.Visible = 'on';
% movie(animation);

close(myVideo)

% writeAnimation(f, "trajectories.gif")