
%homework 5
% problem 2
clear 

%part d 
% define necessary variables 
T = 0.5; %period 
Ts = 0.125; %sampling period
N = 4; %number of samples 
A = 200; %amplitude
t = 0:0.01:1; 
n =[0:N-1];  % n counting index
x = [200 50 -150 50]; 
fourier = abs (fft(x)) / N; %calculate x[k] values
fourier = fftshift(fourier);
 %use fft shift to move two of the stems over to be centered at 0
k = [ -2 -1 0 1]; % create a vector for wavenumber

hz = k./T; % convert wavenumber to frequency
stem(hz,fourier)  % create a stem plot
xlabel ('Frequency (Hz)')
ylabel ('X[k]')
grid on

% part g
y = load('pigeonY.txt'); %load in pigeon file

nn = length(y); % number of samples in the data
k = -nn/2 : (nn/2) -1; % create k wavenumbers such that 0 is centered

fourierp = abs(fft(y)) / nn; % find magnitudes of x[k] values
fourierp = fftshift(fourierp);
flapperiod = 0.15;
freq = k ./flapperiod;
figure(2)
stem(freq,fourierp); % create discreet time spectrum plot


xlabel('Frequency (Hz)')
ylabel('X[k]')

figure(3)
plot(freq, y)
xlabel('Frequency(Hz)')
ylabel('wing tip position')