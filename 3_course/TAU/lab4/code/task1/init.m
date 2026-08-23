clear all; clc;
  
A = [8 1 11; 
    4 0 4; 
    -4 -3 -7];
B = [-1; -3; 3];
C = [-2 0 -3];
D = 15;

% Матрицы возмущения
B_f = [1, -1; 
       0, 0; 
       -1, 0];

D_f = [0 3];

wf0 = [1; 1; 1; 1];

% Генератор возмущения
G_f = [35 10 -28 17;
      -22 -7 18 -12;
       56 17 -45 27;
       34 12 -28 17];

Y_f = [12 -6;
    4 -2;
    -10 4;
    6 -3].';

% Генератор задающего воздействия
G_g = [0 0 0; 
        0 0 2; 
        0 -2 0];
Y_g = [1, 1, 0];
wg0 = [-12; 0; 21];

% Начальные условия x0
x0 = [0; 0; 0];

K = [-3.5 1 -3.5];

% Поиск регулятора K_g

n = size(A,1); m = size(B,2);

fprintf('\n=== Kg ===\n');
for lam = eig(G_g)'
    M = [A+B*K-lam*eye(n), B; C+D*K, D];
    fprintf('rank = %d (need %d) for λ = %.2f%+.2fi\n', rank(M), n+m, real(lam), imag(lam));
end

r = size(G_g,1);
I = @(x) eye(x);
M11 = kron(G_g', I(n)) - kron(I(r), A);
M12 = -kron(I(r), B);
M21 = kron(I(r), C);
M22 = D * I(r);
sol = [M11, M12; M21, M22] \ [zeros(n*r,1); Y_g'];
X_g = reshape(sol(1:n*r), n, r);
U_g = sol(n*r+1:end)';
K_g = U_g - K*X_g

% Поиск регулятора K_f
fprintf('\n=== Kf ===\n');
for lam = eig(G_f)'
    M = [A+B*K-lam*eye(n), B; C+D*K, D];
    fprintf('rank = %d (need %d) for λ = %.2f%+.2fi\n', rank(M), n+m, real(lam), imag(lam));
end

p = size(G_f,1);
M11 = kron(G_f', I(n)) - kron(I(p), A);
M12 = -kron(I(p), B);
M21 = kron(I(p), C);
M22 = D * I(p);
sol = [M11, M12; M21, M22] \ [reshape(B_f*Y_f, [], 1); (-D_f*Y_f)'];
X_f = reshape(sol(1:n*p), n, p);
U_f = sol(n*p+1:end)';
K_f = U_f - K*X_f


% h = get_param(gcs, 'Handle');
% print(h, '../../report/images/task1/model1.png', '-dpng', '-r300');

% Запуск модели с флагами для регулятора. Разомкнутая.

bool_K = 0; bool_K_f = 0; bool_K_g = 0;
out = sim('model_1');

% Данные из воркспейса

t = out.y.time;
f_u0 = out.f.signals.values;

g_u0 = out.g.signals.values;
x_u0 = out.x.signals.values;
y_u0 = out.y.signals.values;
e_u0 = g_u0 - y_u0;
u_u0 = out.u.signals.values;

% Запуск модели с флагами для регулятора. u = Kx

bool_K = 1; bool_K_f = 0; bool_K_g = 0;
out = sim('model_1');

% Данные из воркспейса

f_uK = out.f.signals.values;

g_uK = out.g.signals.values;
x_uK = out.x.signals.values;
y_uK = out.y.signals.values;
e_uK = g_uK - y_uK;
u_uK = out.u.signals.values;

% Запуск модели с флагами для регулятора. u = Kx + K_f * w_f

bool_K = 1; bool_K_f = 1; bool_K_g = 0;
out = sim('model_1');

% Данные из воркспейса

f_uKf = out.f.signals.values;

g_uKf = out.g.signals.values;
x_uKf = out.x.signals.values;
y_uKf = out.y.signals.values;
e_uKf = g_uKf - y_uKf;
u_uKf = out.u.signals.values;

% Запуск модели с флагами для регулятора. u = Kx + K_g * w_g

bool_K = 1; bool_K_f = 0; bool_K_g = 1;
out = sim('model_1');

% Данные из воркспейса

f_uKg = out.f.signals.values;

g_uKg = out.g.signals.values;
x_uKg = out.x.signals.values;
y_uKg = out.y.signals.values;
e_uKg = g_uKg - y_uKg;
u_uKg = out.u.signals.values;

% Запуск модели с флагами для регулятора. u = Kx + K_f * w_f + K_g * w_g

bool_K = 1; bool_K_f = 1; bool_K_g = 1;
out = sim('model_1');

% Данные из воркспейса

f_uKfg = out.f.signals.values;

g_uKfg = out.g.signals.values;
x_uKfg = out.x.signals.values;
y_uKfg = out.y.signals.values;
e_uKfg = g_uKfg - y_uKfg;
u_uKfg = out.u.signals.values;

%%%%%%%%%%%%%%%      очистка всего кроме отрисовки          %%%%%%%%%%%%%%%

clear A B B_f bool_K bool_K_f bool_K_g C D D_f G_f G_g K K_f;
clear K_g L wf_0 wg0 Y_f Y_g out wf0 x0;
clear I lam m M M11 M12 M21 M22 n p r sol U_f U_g X_f X_g;

%%%%%%%%%%%%%%%      для графиков эстетика                  %%%%%%%%%%%%%%%

colors = [0, 0.5, 0.4; 
        0, 0, 0.7; 
        0.8, 0.2, 0.2; 
        0.85, 0.65, 0.0]; 
L = 2.5; F = 15;

addpath('/home/eva/Documents/ITMO/3_course/TAU/lab4/code/config');

