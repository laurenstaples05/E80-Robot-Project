% homework 6 problem 3

% part A

function Aprime = rotateTensor(A,theta)


Rz = [cos(theta) sin(theta) 0 
     (-sin(theta)) cos(theta) 0 
      0 0 1];

Aprime = Rz * A * Rz'

end
