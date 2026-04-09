%hw4pr1ptd
% Part d
% make a vector of all the m variables

mvars = [3,5,10,50]


for i = 1:length(mvars)
    isevector(i) = fourierplotter(A,T,d,mvars(i))
end

plot(mvars, isevector,'o-', "LineWidth",1)
xlabel('Wavenumber (M)')
ylabel('ISE value')
