clear; clc; close all;

A = [8  1  11, 
    4  0  4, 
    -4 -3  -7];

B = [-1 -3 3]';

x0 = [1 1 1]';

Q0 = eye(3);
R0 = 1;
alpha = 5;

% Формируем четыре набора (Q, R)
Q_set = {Q0, alpha*Q0, Q0, alpha*Q0};
R_set = {R0, R0, alpha*R0, alpha*R0};

% Массивы для хранения результатов
K_cell = cell(1,4);
P_cell = cell(1,4);
Jmin_vec = zeros(1,4);

% Цикл по четырём наборам
for i = 1:4
    [K_cell{i}, P, ~] = lqr(A, B, Q_set{i}, R_set{i});
    Jmin_vec(i) = x0' * P * x0;
end


T = 2;
dt = 0.01;
t_vec = 0:dt:T;
J_cell = cell(1,4);

for i = 1:4
    Q = Q_set{i};
    R = R_set{i};
    K = K_cell{i};
    
    [t, state] = ode45(@(t, s) extended_sys(t, s, A, B, K, Q, R), t_vec, [x0; 0]);
    
    J_cell{i} = state(:, 4);
end

































% load_system('closed');
% print('-sclosed', '-dpng', '-r300', '../../report/images/task1/closed.png');

function ds = extended_sys(t, s, A, B, K, Q, R)
    x = s(1:3);
    u = -K * x;
    ds = [A*x + B*u;
          x'*Q*x + u'*R*u];
end