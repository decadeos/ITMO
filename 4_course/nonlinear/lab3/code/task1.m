clc; clear;


syms x1 x2 x3

z = [x3;
    x2 - x3;
    x1];

J = jacobian(z, [x1, x2, x3])

det_J = det(J)