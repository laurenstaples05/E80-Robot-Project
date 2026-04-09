% code for plotting tank beacon data
clear

% Speed of sound in water
c = 1500;  % m/s

%Voltage FFT Magnitude Measurements
%voltage1 = ['Insert measured voltages here'];
voltage2 = [1.669 0.624 0.514 0.2964 0.109 0.156 0.187];

% Distance vector (3 cm spacing)
r = 0.03 : 0.03 : 0.21;   % 3cm to 18cm (6 measurements)

% Ideal 1/r voltage decay with distance for each beacon


A2 = 0.0455;     % amplitude constant (change this to fit our data)
ideal2 = A2 ./ r;        % theoretical model


 

figure(2)
%plot voltage vs distance for beacon 2
plot (r,voltage2, 'o', 'Markersize', 6)
hold on
plot(r, ideal2, 'r', 'LineWidth', 1)
xlabel('Distance (m)')
ylabel('FFT Magnitude of Voltage (V)')
title(['Beacon at 13k kHz'])
legend('Measured(with multipath)', 'Ideal decay model')
 
