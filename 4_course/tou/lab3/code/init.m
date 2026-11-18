clc; clear;

A = [0 1; 5 -3];
b = [2; 5];
x0 = [1;0];

Q = [2 0; 0 3];
r = 2;

[P, ~, ~] = icare(A, b, Q, r)

K = r^-1 * b' * P

eig(A - b*K)

J_min = x0' * P * x0;

Am = [-2.317 0 ; 0 -7.4250];


Y = [1 1];
P = lyap( A , -Am , -b * Y )

K = Y * P^-1


