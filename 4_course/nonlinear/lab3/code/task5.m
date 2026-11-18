clc; clear;

A = [0 1 0; 0 0 1; 0 0 0];

B = [0 ; 0 ; 1];

eig(A)

gamma = [-2; -2; -3]

K = acker(A, B, gamma)

eig(A-B*K)