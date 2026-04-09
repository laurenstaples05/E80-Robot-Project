
l1 = 10*10^-3;
l2 = 10*10^-3;
c = 10^-6;
r = 50;

A = [-r/l2 r/l2 0
    0 0 1/c
    1/l2 (-1/l1 -1/l2) 0]

B = expm(A)

voltage = @(t) [1,0,0]*expm(A*t)*[0;0;((10^-3)/l1)];

times=linspace(0,10^-3,2000);  % time points for plotting--vector from 0 to 25 with 2000 equally spaced points
%for i = 1:length(times)
    %voltage(i) = [1,0,0]*expm(A*times(i))*[0;0;(10^-3/l1)];
%end
voltage  = arrayfun(voltage, times);


plot(times, arrayfun(@(t) [1,0,0]*expm(A*t)*[0;0;(10^-3/l1)], times), 'b','LineWidth',2) % position of the voltage
xlabel('time')
ylabel('Voltage')
legend('Voltage')
title(['Voltage R(t) vs time'])
