% 1. Import data from the CSV file
% The readmatrix function is recommended for files with only numeric values
% For files with text headers, consider using readtable or importdata
data = readmatrix('scope_239.csv');

% Extract time and signal data from the columns
time = data(:,1);
signal = data(:,2);

% 2. Define sampling parameters
% Calculate the average time step (sampling interval)
Ts = mean(diff(time)); 
% Calculate the sampling frequency (Fs)
Fs = 1/Ts;

% Get the length of the signal
L = length(signal);

% 3. Perform the FFT
% Subtract the mean to remove the DC bias
signal_detrended = signal - mean(signal);
% Compute the Fourier Transform (Y)
Y = fft(signal);

% 4. Calculate the single-sided amplitude spectrum
% Compute the two-sided spectrum P2
P2 = abs(Y/L);
% Compute the single-sided spectrum P1 from P2 (up to the Nyquist frequency)
P1 = P2(1:floor(L/2)+1);
% For the single-sided spectrum, multiply all points except the DC and Nyquist components by 2
P1(2:end-1) = 2*P1(2:end-1);

% 5. Create the frequency vector
% Define the frequency vector (f) for the single-sided spectrum
f = Fs*(0:(L/2))/L;

% 6. Plot the results
figure;
plot(f, P1)
title('Single-Sided Amplitude Spectrum')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
grid on
