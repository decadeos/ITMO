clc; clear;

syms s t omega

A = [0  1;
    -3  4];
B = [3  -5;
     2   0];
C = [4  1;
    -2  0];

% 1.1
eig(A);


% 1.2
W = simplify(C * inv(s*eye(2) - A) * B);
detW = simplify(det(W));


% 1.3
Co = ctrb(A, B);
rank(Co) == rank(A);

Ob = obsv(A, C);
rank(Ob)== rank(A);

Co_out = [C*B, C*A*B];
rank(Co_out) == rank(A);


% 1.4
g = simplify(ilaplace(W, s, t));
h = simplify(ilaplace(W / s, s, t));


% 1.5
W_jw = simplify(subs(W, s, 1i*omega))
A_ach = simplify(abs(W_jw))
phi_fch = simplify(angle(W_jw))



