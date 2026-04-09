%homework 5 problem 3
%part a
clear
load('damAccel.mat');
acceldata = data(:,2); %extract the acceleration column data from the file

N = length(acceldata); % create the variable N

samplingtime = 0.0001; %sampling time in the data file

fs = 1/ samplingtime; %variable for the sampling frequency
T0 = N/fs; %total time that data was collected

% compute x[k] values
[X,f] = fdomain(acceldata,fs);
f = f(:)';
 
%create a bandpass filter to filter frequencies outside our desired range
bandpass = (abs(f) >= 100) & (abs(f) <= 250);
Xfiltered = X .* bandpass';

%use tdomain to do our inverse DFT transform
[filteredsignal, t] = tdomain(Xfiltered, fs); 

%part c
% Calculating PSD

PSD = (N/fs).*(abs(Xfiltered).^2);
sum = sum(PSD)

%part d 
totalpower = sum * 1/T0 %integration of PSD method
totalpowermean = mean(filteredsignal.^2) %x[n] squared method
%plot our original vs filtered data in the time domain
subplot(3,1,1)
plot(t, acceldata, 'b')
hold on 
plot(t, filteredsignal,'r')
legend('Original data', 'Filtered data')

xlim([0 1.2])

% plot of original vs filtered data in the frequency domain
subplot(3,1,2)
plot(f, abs(X), 'b')
hold on
plot(f, abs(Xfiltered), 'r')
legend('Original data', 'Filtered data')
xlim([-2000 2000])

%plot of PSD
subplot(3,1,3);
plot(f, abs(PSD), 'r');
xlabel('Frequency');
ylabel('PSD');

xlim([-2000 2000])




