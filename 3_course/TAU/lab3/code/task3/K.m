clear; clc;

A = [8, 1, 11; 4, 0, 4; -4, -3, -7];
B = [-1; -3; 3];

P = [-1, -3, -1; 0, -2, 0; 1, 2, 0];
Aj1 = [2, 2; -2, 2];
Bj1 = [3/2; -7/2];

% Q = eye(2); R = 0;
Q = [0, 0; 0, 0]; R = 0;
b = -2.5; r = 1.5;

syms P_ [2 2]
K_ = -(inv(R + Bj1' * P_ * Bj1) * Bj1' * P_ * (Aj1 - b*eye(2)));
eqs = (Aj1 + Bj1*K_ - b*eye(2))' * P_ * (Aj1 + Bj1*K_ - b*eye(2)) - r^2 * P_ == -Q;
s = vpasolve(eqs, [P_], Random=true);
P_ = [s.P_1_1, s.P_1_2; s.P_2_1, s.P_2_2];

K = round([0, -(inv(R + Bj1' * P_ * Bj1) * Bj1' * P_ * (Aj1 - b*eye(2)))] * P^-1, 4);
e = round(eig(A + B*K), 4);
dists = abs(e - b);

if all(real(e) < 0) && all(dists < r)
    disp('K ='); disp(K);
    disp('e ='); disp(e);
else
    disp('нет');
end