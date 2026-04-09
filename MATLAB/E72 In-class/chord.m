% This function plays a chord composed of three frequencies
% E72 Spr 2025, Profs. Bassman and Yong

fs = 44000;     % sampling frequency - sets # of points and needs to be sufficiently high 
t = [0:1/fs:1]; % vector of times to use for playing the chord

% Components of the chord, which we refer to as x(t) in the problem statement.
freqG = 392; % Hz - G4, the G above middle C
freqB = 494; % Hz - B4, the B above middle C
freqD = 587; % Hz - D5

% Create sinusoids with chord frequencies and sum them
cos1 = cos(2*pi*freqG*t);
cos2 = cos(2*pi*freqB*t);
cos3 = cos(2*pi*freqD*t);
play = cos1 + cos2 + cos3;

% define new y(t) modulated signal
y = cos(1000*2*pi*t)
% modified chord

modchord = play .* y
% Play the summed signal
soundsc(play,fs)

pause  

soundsc(modchord, fs)