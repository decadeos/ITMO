clc; clear all;

A = [-25 17 10 -7;
     -40 27 14 -10;
     -18 13 7 -6;
     -30 20 14 -9];

C = [3 -2 2 -1];
x0 = [1 1 1 1]';
x0_hat = [0 0 0 0]';


Q0 = eye(4);   
R0 = 1;       
alpha = 5;

Q_set = {Q0, alpha*Q0, Q0, alpha*Q0};
R_set = {R0, R0, alpha*R0, alpha*R0};
L_cell = cell(1,4);

for i = 1:4
    Q = Q_set{i};
    R = R_set{i};
    [P, ~, ~] = care(A', C', Q, R);
    L_cell{i} = P * C' * inv(R);
    eig(A-L_cell{i}*C)
end




