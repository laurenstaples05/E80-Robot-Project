%hw4problem 2 

function ISE = frfplotter( A, T, M, P )
% This function plots a periodic signal and a complex exponential series 
% approximation of it. 

%   A: amplitude of signal
%   T: fundamental period
%   M: number of harmonics in the Fourier series approximation
% The function returns the integrated square error (ISE) for the approximation

%define necessary variables
N0=100;
dt = T/N0;
w0 = 2*pi/T  ;

%define system parameters of the transfer function
b = 1;
m = 1;
kspring = 0.8;
t= 0:dt:2*T;
x = (sawtooth(w0*t,1) + 1) * (A/2); %define the original sawtooth input signal


% Calculate Fourier coefficients. k goes from -M to M, but the vector of 
% coefficients has to start with index 1
k = -M:1:M;
c = (A*1j)./(2*pi*k);
% C_0 is not calculated by this formula and needs to be done separately 
% due to division by zero.
% Indexing is tricky! C_k is in the (k+M+1)th element of the c vector
c(0+M+1) = A/2 ;


% Build the approximated input signal from the Fourier coefficients and basis functions
xhat = zeros(1,length(t));
for n = -M:1:M  % using n to avoid messing up k vector
    xhat = xhat + c(n+M+1).*exp(1j*n*w0*t); 
end

%Build the approximated output signal from the fourier coefficients
%including G(jw)
yhat = zeros(1,length(t));
for n = -M:1:M  % using n to avoid messing up k vector
 wn = n*w0;   % define a harmonic frequency that changes based on n
 Gjw = ((b*j*wn) +kspring)/((-m*wn^2)+ (b*j*wn) + kspring); %define frequency response function

 yhat = yhat + Gjw*c(n+M+1).*exp(1j*n*w0*t);

end
% Make plots of the original and approximated signal and a stem plot


% Original and approximated signal, both input and output

plot(t,x,'k',t,xhat,'y', 'LineWidth',3) 
xlabel('time (sec)')
ylabel('x(t)')
axis tight

hold on

plot(t,yhat,'r','LineWidth',1) 
xlabel('time (sec)')
ylabel('y(t)')
axis tight

% Compute the ISE value within one period of the signal by adding squared error
% at each time (multiplied by time step dt). Show ISE as the title of the graph.

ISE=0;
for i = 1:N0+1   % can start anywhere and add one period's worth of points
    ISE = ISE + (x(i)-xhat(i)).^2*dt; 
end

% The x and xhat values are real, but they are calculated from complex
% valued expressions they retain tiiiiiiny imaginary parts. This gets rid
% of them so we don't need to see an error message
ISE = abs(ISE);


title(['ISE is ' num2str(ISE,'%0.3e') ' for M = ' num2str(M)]);
% look at documentation for sprintf to see what the %0.3e means for formatting

end
