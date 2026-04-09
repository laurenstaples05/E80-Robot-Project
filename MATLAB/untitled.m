x = 0:0.1:30;
alpha = 1; % Set a baseline constant
V = alpha * (x.^3/2700 - x.^2/60 + 2.5);
M = alpha * (x.^4/10800 - x.^3/180 + 2.5*x);

subplot(2,1,1); plot(x, V); grid on; ylabel('Shear Force (V)');
subplot(2,1,2); plot(x, M); grid on; ylabel('Bending Moment (M)');