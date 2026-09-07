clc; clear all;

A = [-40  16   9   7;
     -64  25  14  12;
     -26  11   7   3;
     -48  18  14   8];

C = [-3  2  -2  1];
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




































% L = [1 1 1 1];
% 
% load_system('closed_observer');
% print('-sclosed_observer', '-dpng', '-r300', '../../report/images/task2/closed_observer.png');
