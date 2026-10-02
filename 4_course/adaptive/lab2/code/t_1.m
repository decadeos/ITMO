clc; clear;

A = [0 1; 2 2];
B = [0; 8];
C = [1 0];
x0 = [1;1];


z = 4.743864518;
omega0 = 47.438645184;

AM = [0 1; -omega0^2 -2*omega0];
BM = [0; omega0^2];
CM = [1 0];

k3 = 0.003554884;
k3_inv = 1 / k3;
teta3 = [-281.553132; -12.109661];
teta3_T = [-281.553132; -12.109661]';

Q = eye(2);
P = lyap(AM', Q);

% решение 1
gamma = 500;
B_T = B';



% решение 2
sigma = 5;
sigma_minus = -sigma;