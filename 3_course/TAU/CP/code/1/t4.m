rng(25, "philox");
M  = randi([100000, 1000000]) / 1000 / sqrt(2)
m1 = randi([1000, 10000])    / 1000 * sqrt(3)
m2 = randi([1000, 10000])    / 1000 * sqrt(3)
l  = randi([100, 1000])      / sqrt(5) / 100

g = 9.81;

m = m1 + m2
lc = l * (m1/2 + m2) / m
beta = m * lc    
J = (1/3)*m1*l^2 + m2*l^2
Meff = (M + m)*J - beta^2

A = [0, 1, 0, 0;
     0, 0, -beta*g/Meff, 0;
     0, 0, 0, 1;
     0, 0, (M+m)*g*beta/Meff, 0]

B = [0; J/Meff; 0; -beta/Meff]
D = [0; -beta/Meff; 0; (M+m)/Meff]
C = [1 0 0 0; 0 0 1 0]