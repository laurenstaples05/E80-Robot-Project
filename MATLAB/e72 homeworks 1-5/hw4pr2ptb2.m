
M = [3 5 10 20 30 50];
A = 1 ;
T = 3600*24;

for i = 1:length(M)
    isevector(i) = sawtoothplotter(A,T, M(i), i);
end

plot(M, isevector,'o-', "LineWidth", 1)
xlabel('Number of Harmonics (M)')
ylabel('ISE value')
