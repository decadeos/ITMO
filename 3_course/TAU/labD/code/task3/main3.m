clc; clear all;

A = [5 -9 -7 1;
    -9 5 -1 7;
    -7 -1 5 9;
    1 7 9 5];

B = [3 0;
    3 0;
    1 0;
    3 0];
C = [2 -2 2 2; 
    -2 4 2 4];

D = [0 4;
    0 1];

x0=[1 1 1 1]';
x0_hat=[0 0 0 0]';



QK = eye(4);
RK = eye(2);

QL = eye(4);
RL = eye(2);

[K, PK, ~] = lqr(A, B, QK, RK);
eig(A-B*K);

[PL, ~, ~] = care(A', C', QL, RL)
L = PL * C' * inv(RL)
eig(A-L*C);

Co = ctrb(A, B);
rank(Co) == rank(A);

Ob = obsv(A, C);
rank(Ob)== rank(A);



[V, J] = jordan(sym(A));
J = double(J); V = double(V);

C_tilde = C * V;
J = V \ A * V;























% load_system('closed_observer');
% print('-sclosed_observer', '-dpng', '-r300', '../../report/images/task3/closed_observer.png');
