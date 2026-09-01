clc; clear all;

M = 658.36;
m1 = 15.66;
m2 = 14.80;
l = 1.77;
g = 9.81;

m = m1 + m2;
lc = l * (m1/2 + m2) / m;
beta = m * lc;        
J = (1/3)*m1*l^2 + m2*l^2;
Meff = (M + m)*J - beta^2;

f = 0;
u = 0;

x0 = [0;0;0.02;0];