clc; clear;

syms s

A = [0 1; -3 4];
B = [3 -5; 2 0];
C = [4 1; -2 0];
D = [2 0; 0 -3];
Bf = [3 1; 2 0];
Df = [-1 0; 0 1];
Cz = [3 1; 2 0];
Dz = [-2 0; 0 1];
x0 = [1; 1];

G = [0 2 0 0 0 0;
    -2 0 0 0 0 0;
     0 0 0 4 0 0;
     0 0 -4 0 0 0;
     0 0 0 0 0 9;
     0 0 0 0 -9 0];

w0 = [1 0 1 0 1 0]'; 
Y1 = [0 -5 0 0 0 0; 0 0 5 0 0 0]; 
Y2 = [0 0 3 0 0 0; 0 -1 0 0 0 0]; 
Yg = [0 0 0 0 4 0; 0 0 0 0 0 -3]; 

n_w = size(G, 1);
n = size(A, 1);

Ab = [G,          zeros(n_w, n);
         Bf * Y1,          A];

Bb = [zeros(n_w, size(B, 2))
         B];

Cb = [Df * Y2,          C];

Ct = [Cb; 
           Yg, zeros(size(Yg, 1), size(A, 1))];

Dt = [D;
           zeros(size(Yg, 1), size(D, 2))];

xe0=[0 0 0 0 0 0 0 0]';


% 2.1
Co_out_y = [C*B, C*A*B, D];
rank(Co_out_y) == 2;

Co_out_z = [Cz*B, Cz*A*B, Dz];
rank(Co_out_z) == 2;

% 2.2
W_yu = simplify(C * inv(s*eye(2) - A) * B + D);
W_zu = simplify(Cz * inv(s*eye(2) - A) * B + Dz);




% Синтез K
Gamma = [-4  0; 0 -5];
Y = [1 1; 1 1];
P = sylvester(A, -Gamma, B*Y);
K = -Y * inv(P);
eig(A+B*K)



% Синтез Kw
Acl = A + B*K;
F = Cz + Dz*K;
Dz_inv = inv(Dz); 
A_eq = -Acl + B * Dz_inv * F;
B_eq = Bf*Y1 + B * Dz_inv * Yg;
P = sylvester(A_eq, G, B_eq);
Kw = Dz_inv * (Yg - F*P);

Acl = A + B*K;
F = Cz + Dz*K;
for lambda = eig(G).'
    M = [Acl - lambda*eye(n), B; F, Dz];
    fprintf('lambda = %g%+gi, rank = %d\n', ...
    real(lambda), imag(lambda), rank(M));
end

res1 = norm(P*G - Acl*P - Bf*Y1 - B*Kw);
res2 = norm(F*P + Dz*Kw - Yg);
fprintf('Невязка 1: %e\n', res1);
fprintf('Невязка 2: %e\n', res2);



% Синтез L
lambda_obs = [-10; -11; -12; -13; -14; -15; -16; -17];
L = place(Ab', Ct', lambda_obs)';
































% load_system('closed_observer');
% print('closed_observer', '-dpng', '-r300', '-sclosed_observer');