%hw4problem 2 pt b

function ISE = sawtoothplotter( A, T, M, P )

%   A: amplitude of signal
%   T: fundamental period
%   M: number of harmonics in the Fourier series approximation
% The function returns the integrated square error (ISE) for the approximation
%define necessary variables
N0=100
dt = T/N0
w0 = 2*pi/T  ;   % fundamental frequency
t= 0:100:2*T;
x = (sawtooth(w0*t,1) + 1) * (A/2); %create our sawtooth function as the original signal

% Calculate Fourier coefficients. k goes from -M to M, but the vector of 
% coefficients has to start with index 1
k = -M:1:M;
c = (A*1i) ./(2*pi*k);
% C_0 is not calculated by this formula and needs to be done separately 
% due to division by zero.
% Indexing is tricky! C_k is in the (k+M+1)th element of the c vector
c(0+M+1) = A/2 ;


% Build the approximated signal from the Fourier coefficients and basis functions
xhat = zeros(1,length(t));
for n = -M:1:M  % using n to avoid messing up k vector
    xhat = xhat + c(n+M+1).*exp(1j*n*w0*t); 
end

% Make plots of the original and approximated signal 

figure(1)
% Original and approximated signal
subplot(3,2,P)
plot(t,x,'k',t,xhat,'r') 
xlabel('time (sec)')
ylabel('x(t)')
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






