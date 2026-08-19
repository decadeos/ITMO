clc;

% Исходные данные
% A = [17 -5 20; 10 -3 10; -10 0 -13];
% B = [1; -1; 1];
% C = [-2 2 -1];
% D = 12;
% K = [-6.191 0.420 -6.191];
% 
% G_g = [0 0 0; 0 0 2; 0 -2 0];
% Y_g = [1 1 0];
% 
% Bf = [-1 1; 0 0; 1 0];
% Df = [2 1];
% G_f = [0 1 0 1; -26 -7 20 -11; 0 1 -1 2; 16 4 -14 8];
% Yf = [2 0 -2 1; -4 -2 4 -3];  

% Проверка рангов G
lambda = [0, 2i, -2i];
for lam = lambda
    M = [A + B*K - lam*eye(3), B; C + D*K, D];
    fprintf('λ = %.3f%+.3fi: rank = %d\n', real(lam), imag(lam), rank(M));
end
fprintf('')

% Для λ = 0
M0 = [A+B*K, B; C+D*K, D];
R0 = [0;0;0;1];
sol0 = M0 \ R0;
Kg0 = sol0(4);

% Для λ = 2i
M2 = [A+B*K-2i*eye(3), B; C+D*K, D];
R2 = [0;0;0;1];
sol2 = M2 \ R2;
Kg2 = sol2(4);

K_g = [real(Kg0), real(Kg2), imag(Kg2)]


% Проверка рангов F
for lam = eig(G_f)'
    M = [A + B*K - lam*eye(3), B; C + D*K, D];
    fprintf('λ = %.3f%+.3fi: rank = %d\n', real(lam), imag(lam), rank(M));
end

% Решение для каждого λ в порядке: i, -i, 2i, -2i
lambda = [1i, -1i, 2i, -2i];
Kf_complex = zeros(1,4);

for i = 1:4
    M = [A + B*K - lambda(i)*eye(3), B; C + D*K, D];
    R = [B_f * Y_f(:,i); -D_f * Y_f(:,i)];
    sol = M \ R;
    Kf_complex(i) = sol(4);
end

K_f = [real(Kf_complex(1)), imag(Kf_complex(1)), real(Kf_complex(3)), imag(Kf_complex(3))]