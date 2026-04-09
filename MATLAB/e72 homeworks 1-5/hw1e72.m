    
% take the input f and Vin and output the output voltage of the circuit Vout 

%define input frequency
f = linspace(100000,20000000,200);

Vin = 5; %define the input voltage

% set up a loop so that the function repeats for the whole frequency range
% of 100kHZ to 20MHz
for i = 1:length(f) 

    %define w in rad/sec
    w = 2*pi * f(i) ;

%define impedances
    r = 50;
    l = 1.12e-6*w*1i;
    c = 1/ (8.78e-10*w*1i);
    c2 = 1/ (1.23e-9*w*1i);


% matrix A from part a) calculations
A = [((1/r)+(1/l)+(1/c)) (-1/l) (0); 
    (-1/l) ((1/l)+(1/l)+(1/c2)) (-1/l);
    (0) (-1/l) ((1/l)+(1/r)+(1/c))] ;




% vector for the right hand side of the system
RHS = [Vin/r 0 0]';

% solve the system of equations for the output voltage
V = A\RHS;

%store the output voltage from each loop in a new vector that will be
%plotted
Vout(i) = abs(V(3));

end

% define a variable for the log magnitude of the output voltage
Vdb = 20* log10(Vout/Vin)


%plot the output voltage vs frequency on a log scale with a title and axis
%label
semilogx(f,Vdb)
xlabel('Frequency (rad/s)')
ylabel('Magnitude (dB)')
title('Plot of log magnitude versus frequency')
output = Vout;
