%e72 homework 2 
% Problem 1
% set up system of equations for each point
%T1 = (10 + 10 + 10 +T3 )/4
%T2 = (10+10 +T3 + T5)/4
%T3 = (T1 + T2 + T2 + T6)/4
%T4 = (10 + 10 + T5 + T8)/4
%T5 = ( T2 + T6 + T4 + T4)/4
%T6 = (T3 + T5 + T5 + T10)/4
%T7 = (10 + 10 + T8 + T8)/4
%T8 = (T4 + T7 + T9 + 10)/4
%T9 = (T5 + T8 + T10 + 10)/4
%T10 = ( T6 + T9 + 10 + T9)/4

%rearrange system of equations into matrix of the form Ax = b:
% matrix A
A = [4 0 -1 0 0 0 0 0 0 0;
     0 4 -1 0 -1 0 0 0 0 0;
     -1 -2 4 0 0 -1 0 0 0 0;
     0 0 0 4 -1 0 0 -1 0 0;
     0 -1 0 -1 4 -1 0 0 -1 0;
     0 0 -1 0 -2 4 0 0 0 -1;
     0 0 0 0 0 0 4 -2 0 0;
     0 0 0 -1 0 0 -1 4 -1 0;
     0 0 0 0 -1 0 0 -1 4 -1;
     0 0 0 0 0 -1 0 0 -2 4];

b = [ 30 20 0 20 0 0 100 90 90 90]'; %this is the right hand side vector

temp = A\b; %solve the system of equations to find the temperatures at each dot and put it into the vector temp

%create the bounds spacing for a new matrix to plot using contourf
x = [0:4:12]; 
y = [0:4:20];

%set up the matrix in the same orientation as the dots in the problem
m = [90 90 90 90;
     temp(7) temp(8) temp(9) temp(10);
     10 temp(4) temp(5) temp(6);
     10 10 temp(2) temp(3);
     10 10 10 temp(1);
     10 10 10 10;];

% plot a temperature plot using contourf
%contourf(x,y,m);

%part b
k = 200;

area = 0.4*20; % scale width by 20 to convert from 12mm to 0.24m and then multiply by the depth into the page

qbottom = k/2 *((temp(7)-90) + 2*(temp(8)-90)+ 2*(temp(9)-90)+ (temp(10)-90)); % given equation for the heat at the bottom

rateofheat = qbottom*area; %plug values into the given equation to solve for rate of heat transfer

% Problem 2
%part a
optlocation = fminsearch(@e72truss,[2 1]); %find optimal location of B

minlength = e72truss(optlocation) % print the minimum length when B is at its optimal location

%part b
constraint = fmincon(@e72truss,[2 1], [],[],[],[],[3 0],[Inf Inf] ); % find optimal location of B with constraint x>=3
minlengthcon = e72truss(constraint); % print the length of the truss when B is at optimal location

%part c
optlocationc = fminsearch(@e72trusspartc, [2 1]); %find optimal location of B that maximizes phi


%part d 
% find location of B that maximizes phi with constraint x>=3
 optlocationd = fmincon(@e72trusspartc, [2 1], [-1 0], -3)% I changed the way I defined the constraint to be < -3 instead
 % of >3, because the other way was giving me errors.
  