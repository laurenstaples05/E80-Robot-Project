
% problem 2, parts b, c and d 
%this file is where I am plotting my various plots using functions I
%defined in other files


% part b 
%define variables needed for sawtooth function
M = [3 5 10 20 30 50]; %harmonic vector
A = 1 ; %amplitude
T = 3600*24; %period

%create a vector of the ISE values for each harmonic
for i = 1:length(M)
    isevector(i) = sawtoothplotter(A,T, M(i), i);
end

%plot the approximations for M = 3 to M = 50 in figure 1, with 6 small
%subplots all in the same figure, one for each harmonic
figure(1)

sawtoothplotter(1, 86400, 3, 1)
sawtoothplotter(1, 86400, 5, 2)
sawtoothplotter(1, 86400, 10, 3)
sawtoothplotter(1, 86400, 20, 4)
sawtoothplotter(1, 86400, 30, 5)
sawtoothplotter(1, 86400, 50, 6)


% figure 2 is the plot of ise values as a function of M
figure(2)

plot(M, isevector,'o-', "LineWidth", 1)
xlabel('Number of Harmonics (M)')
ylabel('ISE value')

% part c
% plot the input and output on the same plot for T = 24 hours and T = 50
figure(3)
frfplotter(1,86400,30,1)

figure(4)
frfplotter(1,50,30,1)

% part d
%define all values that are in the transfer function
m = 1;
b = 1;
kspring = 0.8;
w = 10e-8:1:10e4;
% create the transfer function for the bode plot
 G = ((b*j*w) +kspring) ./((-m*w.^2)+ (b*j*w) + kspring);

 %define a variable that is the log magnitude of our output
db = 20* log10(G);
% Plot Bode diagram with a log scale on the x axis
figure(5)
semilogx(w,db)
xlabel('Frequency (rad/s)')
ylabel('Magnitude(db)')