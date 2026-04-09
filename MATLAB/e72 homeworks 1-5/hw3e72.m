% Homework 3

%Problem 1

% Define the matrix A and vector B so that the constraints are Ax<=b

A = [1 0 0 0 0 0;
    0 1 0 0 0 0;
    0 0 1 0 0 0;
    150 0 0 -1 0 0;
    -1300 0 0 1 0 0;
    0 250 0 0 -1 0;
    0 -1200 0 0 1 0;
    0 0 200 0 0 -1;
    0 0 -1400 0 0 1];

b= [1 1 1 0 0 0 0 0 0]';

%create a vector f that will be dotted with x to create the obective
%function

energycosts = [250 100 450 0.25 0.5 0.15];
% create an equation Ax= b for our equality constraint 
Aeq = [0 0 0 1 1 1];

beq= [1500];

%create upper and lower bound vectors to constrain the values of our decision variables
lb = [ 0 0 0 0 0 0];
ub= [ 1 1 1 1300 1200 1400];

%use intlinprog to find the optimal solution to minimize production cost
opt = intlinprog(energycosts, [1:3],A,b,Aeq,beq,lb,ub)

totalcost = 250*opt(1) + 100*opt(2) + 450* opt(3) + 0.25*opt(4) + 0.5 * opt(5) + 0.15*opt(6)

%Problem 2
%define the variable h as the heights at each point along the road
h = [1:1:101];

hinitial = mean(e) * ones(101,1);%create an inital height guess for fmincon to use

%define x as the points along the road and insert the given elevation
%equation
x = 1:1:101;
e = 5*sin((3*pi)*x/L) +sin(10*pi*x/L);

%start by creating empty matrices
A = zeros(594,101);
b = zeros(594,1);

%define the matrix A based on the given constraints so that we do not have
%to type out the entire matrix
for i = 1:(length(h)-1)
  A(i,i+1) = 1;
  A (i,i) = -1;
b(i) = 0.08;
end

for i = 1:(length(h)-1)
  A (i+100,i+1) = -1;
  A (i+100,i) = 1;
  b(i+100)= 0.08;
end

for i = 2:(length(h)-1)
   A (i+199,i+1) = 1;
   A(i+199,i) = -2;
   A(i+199,i-1) = 1;
b(i+199)= 0.025;
end

for i = 2:(length(h)-1)
   A (i+298,i+1) = -1;
   A(i+298,i) = 2;
   A(i+298,i-1) = -1;
b(i+298) = 0.025;
end

for i = 3:(length(h)-1)
    A(i+396,i+1) = 1;
    A(i+396,i) = -3;
    A(i+396,i-1) = 3;
    A(i+396,i-2) = -1;
  b(i+396)= 0.005 ;
end

for i = 3:(length(h)-1)
    A(i+494,i+1) = -1;
    A(i+494,i) = 3;
    A(i+494,i-1) = -3;
    A(i+494,i-2) = 1;
  b(i+494) = 0.005 ;
end



% create a variable that is the output of using fmincon on our
% fillcutoptimization function from our other file 
%call fillcutomptization as an anonymous function
gradingplan = fmincon(@fillcutoptimization,hinitial,A,b);

%plot the original elevation and the grading plan overlayed on the same
%plot
plot(x,e,"r")

hold on
%add labels and bounds to the plot, and a legend
plot(x,gradingplan,"b")
xlabel('Distance of road in meters')
ylabel('Elevation')
legend('Grading plan', 'Original elevation')
xlim([0 100])


% problem 3

%define terms needed for the problem
w = 2*pi; 
w0 = 2*w; %omega for the new sin wave 
a0 = 2/pi;%fourier constant that we calculated
newT = 2*pi/w0; %period of the new sin wave
t = linspace(0,4*newT,1000); %plot over 4 evenly spaced periods T

abssin = abs(sin(w*t)); % plug in the equation for the rectified sin wave

%equations for the 3 fourier series
% (i chose to just write out ak in my fourier euqations instead of defining
% it as a variable)
fourier2 = a0 + (4/(pi-(4*pi*1^2)))*cos(w0*t);
fourier4 = a0 + (4/(pi-(4*pi*1^2)))*cos(w0*t)+ (4/(pi-(4*pi*2^2)))*cos(2*w0*t)+(4/(pi-(4*pi*3^2)))*cos(3*w0*t);
fourier8 = a0 + (4/(pi-(4*pi*1^2)))*cos(w0*t)+ (4/(pi-(4*pi*2^2)))*cos(2*w0*t)...
    +(4/(pi-(4*pi*3^2)))*cos(3*w0*t)+(4/(pi-(4*pi*4^2)))*cos(4*w0*t)+ (4/(pi-(4*pi*5^2)))*cos(5*w0*t)...
    +(4/(pi-(4*pi*6^2)))*cos(6*w0*t)+  (4/(pi-(4*pi*7^2)))*cos(7*w0*t);

%plot the rectified signal and the 3 fourier approximations
plot(t,abssin,'b') 
hold on
plot(t,fourier2,'r')
plot(t,fourier4,'b')
plot(t,fourier8,'g')

%create a legend to tell which line is which
legend('Rectified sin wave','First two terms','First four terms','First eight terms')