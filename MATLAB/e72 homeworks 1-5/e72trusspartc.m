% e72trusspartc.m  E72
%
%This code is for part c of problem 2 homework 2, it was giving me issues
%trying to do it in the same file as my one for part a and b, so I made a
%seperate one :)
%
% This program takes the x- and y-coordinates of joint B as input
% (in a vector) and outputs some desired property of the truss.

function output = e72trusspartc(B)

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
%Create a matrix of the unit lengths of each bar
matrix = [unitAB(1) unitAC(1) 0 0 0 0 0 0 0 0;
    unitAB(2) unitAC(2) 0 0 0 0 0 0 0 0;
    -unitAB(1) 0 unitBC(1) unitBD(1) 0 0 0 0 0 0;
    -unitAB(2) 0 unitBC(2) unitBD(2) 0 0 0 0 0 0;
    0 -unitAC(1) -unitBC(1) 0 unitCD(1) unitCE(1) 0 0 0 0;
    0 -unitAC(2) -unitBC(2) 0 unitCD(2) unitCE(2) 0 0 0 0;
    0 0 0 -unitBD(1) -unitCD(1) 0 unitDE(1) 0 0 1;
    0 0 0 -unitBD(2) -unitCD(2) 0 unitDE(2) 0 0 0;
    0 0 0 0 0 -unitCE(1) -unitDE(1) 1 0 0;
    0 0 0 0 0 -unitCE(2) -unitDE(2) 0 1 0;];

%% HINT:  unitAB(1) is the i-component of the unit vector from A to B
%% HINT:  unitAB(2) is the j-component of the unit vector from A to B

% Define the vector representing the right-hand side of the system
% of equations.
RHS = [0 1 0 0 0 0 0 0 0 0]';

% Solve the system of equations for the forces.
forces = matrix\RHS;

% Calculate the total length of the truss.
totallength = norm(B-A)+norm(C-A)+norm(C-B)+norm(D-B)+norm(D-C)+norm(E-C)+norm(E-D); 
disp(totallength);

%create a vector that includes the length of each individual bar 
barlengths = [(norm(B-A)) (norm(C-A)) (norm (C-B)) (norm (D-B)) (norm (D-C)) (norm(E-C)) (norm(E-D))];
barlengthsinch = barlengths * 12 % convert bar lengths to inches since other units are in inches
% create a vector of only the bar forces and exclude the reaction forces
barforces = forces(1:7);

% caclulate the maximum load each bar can take 
maxloadperbar = zeros(1,7);

for i = 1:7
flimcomp = (pi^2)*((8.75 * 10^5)/(barlengthsinch(i)^2)); % equation for compression flimit converted to lbf
flimtens = 40000; % equation for tension flimit in lbf

    if forces(i) > 0 % use equation for tension
       maxloadperbar(i) = flimtens/abs(barforces(i)) 

    else % use equation for compression
       maxloadperbar(i) = flimcomp/abs(barforces(i)) 
    end

end

breakingforce = min(maxloadperbar) % smallest ratio of flimit/fi out of all the bars (where truss will break first)

W = sum(barlengthsinch)*1*0.1; % calculate total weight of the truss

phi = breakingforce / W; %calculation of phi

output = -phi %crerate an output that is negative since fminsearch minimizes but we actually want to maximize phi, so we negate it
end
