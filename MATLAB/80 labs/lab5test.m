% code for plotting tank beacon data

clear

% Speed of sound in water
c = 1500;  % m/s

% Beacon frequencies (in Hz)
beacon1 = 9000 ;
beacon2 = 11000;
beacon3 = 13000;% Hz

%Voltage FFT Magnitude Measurements
voltage1 = [ 52 21 9 3 8 11];
voltage2 = [17 13 18 15 8 2];
voltage3 = [44 23 7 8 12 4];

% Distance vector (3 cm spacing)
r = 0.03 : 0.03 : 0.18;   % 3cm to 18cm (6 measurements)

% Ideal 1/r voltage decay with distance for each beacon

A1 = 1.86;                 % amplitude constant (change this to fit our data)
ideal1 = A1 ./ r;        % theoretical model

A2 = 1;                 % amplitude constant (change this to fit our data)
ideal2 = A2 ./ r;        % theoretical model

A3 = 2;                 % amplitude constant (change this to fit our data)
ideal3 = A3 ./ r;        % theoretical model
    
 
figure(1)
%plot voltage vs distance for beacon 1
plot (r,voltage1, 'o', 'Markersize', 5)
hold on
plot(r, ideal1, 'r', 'LineWidth', 1)
xlabel('Distance (m)')
ylabel('FFT Magnitude of Voltage')
title(['Beacon at 9k kHz'])
legend('Measured(with multipath)', 'Ideal decay model')

figure(2)
%plot voltage vs distance for beacon 2
plot (r,voltage2, 'o', 'Markersize', 5)
hold on
plot(r, ideal2, 'r', 'LineWidth', 1)
xlabel('Distance (m)')
ylabel('FFT Magnitude of Voltage')
title(['Beacon at 11k kHz'])
legend('Measured(with multipath)', 'Ideal decay model')
 
figure(3)
%plot voltage vs distance for beacon 1
plot (r,voltage3, 'o', 'Markersize', 5)
hold on
plot(r, ideal3, 'r', 'LineWidth', 1)
xlabel('Distance (m)')
ylabel('FFT Magnitude of Voltage')
title(['Beacon at 13k kHz'])
legend('Measured(with multipath)', 'Ideal decay model')