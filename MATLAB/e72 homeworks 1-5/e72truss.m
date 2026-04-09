% e72truss.m  E72
%
% this is my code for parts a and b of homework 2 problem 2
%
% This program takes the x- and y-coordinates of joint B as input
% (in a vector) and outputs some desired property of the truss.

function output = e72truss(B)

% These are the locations of the joints.
A=[5 0];
C=[2 2];
D=[0 0];
E=[0 2];

% Calculate unit vectors from one joint to another.
% "norm" calculates the length of a vector
unitAB = (B-A)/norm(B-A);
unitAC = (C-A)/norm(C-A);
unitAD = (D-A)/norm(D-A);
unitAE = (E-A)/norm(E-A);
unitBC = (C-B)/norm(C-B);
unitBD = (D-B)/norm(D-B);
unitBE = (E-B)/norm(E-B);
unitCD = (D-C)/norm(D-C);
unitCE = (E-C)/norm(E-C);
unitDE = (E-D)/norm(E-D);

% Now form a system of equations governing the bar forces and
% reaction forces. 
%
% In this calculation, we will take F=1 (load).

matrix = [unitAB(1) unitAC(1) 0 0 0 0 0 0 0 0;
    unitAB(2) unitAC(2) 0 0 0 0 0 0 0 0;
    -unitAB(1) 0 unitBC(1) unitBD(1) 0 0 0 0 0 0;
    -unitAB(2) 0 unitBC(2) unitBD(2) 0 0 0 0 0 0;
    0 -unitAC(1) -unitBC(1) 0 unitCD(1) unitCE(1) 0 0 0 0;
    0 -unitAC(2) -unitBC(2) 0 unitCD(2) unitCE(2) 0 0 0 0;
    0 0 0 -unitBD(1) -unitCD(1) 0 unitDE(1) 0 0 1;
    0 0 0 -unitBD(2) -unitCD(2) 0 unitDE(2) 0 0 0;
    0 0 0 0 0 -unitCE(1) -unitDE(1) 1 0 0;
    0 0 0 0 0 -unitCE(2) -unitDE(2) 0 1 0;]


%% HINT:  unitAB(1) is the i-component of the unit vector from A to B
%% HINT:  unitAB(2) is the j-component of the unit vector from A to B

% Define the vector representing the right-hand side of the system
% of equations.
RHS = [0 1 0 0 0 0 0 0 0 0]';

% Solve the system of equations for the forces.
forces = matrix\RHS

% Calculate the total length of the truss.
totallength = norm(B-A)+norm(C-A)+norm(C-B)+norm(D-B)+norm(D-C)+norm(E-C)+norm(E-D); 
disp(totallength);
% Calculate the maximum applied load (Fmax).
maxload = ((pi^2)*8.75*(10^5))/(norm(B-A))^2+((pi^2)*8.75*(10^5))/(norm(C-A))^2+((pi^2)*8.75*(10^5))/(norm(C-B))^2+((pi^2)*8.75*(10^5))/(norm(D-B))^2+((pi^2)*8.75*(10^5))/(norm(D-C))^2+((pi^2)*8.75*(10^5))/(norm(E-C))^2+((pi^2)*8.75*(10^5))/(norm(E-D))^2;

% Set the output to be whatever we want to observe.
output = totallength;



