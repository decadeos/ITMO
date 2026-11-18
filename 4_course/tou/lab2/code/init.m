clc; clear;

x1_0 = 0;
x2_0 = 0;

R = 5;

format long g
C1_opt = 1250 * (1 + exp(45)) / (47 + 43*exp(45));
C2_opt = -250 * (1 - exp(45)) / (47 + 43*exp(45));