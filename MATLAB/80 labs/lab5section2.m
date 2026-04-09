clear; clc; close all;

% Speed of sound in water
c = 1500;  % m/s

% Beacon frequencies
f = [9000 11000 13000];  % Hz

% Distance vector (3 cm spacing)
r = 0.03 : 0.03 : 0.18;   % 10 cm to 2 m

figure;

for k = 1:3
    
    lambda = c / f(k);
    k_wave = 2*pi / lambda;
    
    % ----- Ideal 1/r decay -----
    A = 1;                 % arbitrary amplitude constant
    ideal = A ./ r;        % smooth theoretical model
    
    % ----- Multipath simulation -----
    reflection_strength = 0.6;
    path_difference = 0.3;  % extra path length (m)
    
    multipath = reflection_strength ./ r .* ...
                cos(k_wave * (r + path_difference));
    
    V = ideal + multipath;
    
    % Add small measurement noise
    V = V + 0.03*randn(size(V));
    
    % ----- Plot -----
    subplot(3,1,k)
    
    plot(r, V, 'o', 'MarkerSize',5)
    hold on
    plot(r, ideal,'o', 'MarkerSize',5)
    hold off
    
    xlabel('Distance (m)')
    ylabel('FFT Magnitude (arb units)')
    title(['Beacon at ', num2str(f(k)/1000), ' kHz'])
    legend('Measured (with multipath)','Ideal 1/r','Location','northeast')
    grid on
end
