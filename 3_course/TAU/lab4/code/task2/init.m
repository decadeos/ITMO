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
K_f = [-9.2262   -2.9556    6.9958   -4.9150]; 
K_g = [0.0703   -0.0562    0.0658]; 

G = [-5 0 0;
    0 -6 0;
    0 0 -7];

Y = [1; 7; 8];

Q = lyap(G_g', -G, -(Y*Y_g)')';
Q_inv = pinv(Q);


n = size(A, 1);   r = size(G_f, 1); 
zero_1 = zeros(r, n);  zero_2 = zeros(n, r);     

A_bar = [G_f,          zero_1;
         B_f * Y_f,    A];
B_bar = [zeros(r, size(B, 2));
         B];
C_bar = [D_f * Y_f, C];

desired_poles = [-3.0+0.5i, -3.0-0.5i, -3.2+1.0i, -3.2-1.0i, -3.5+1.5i, -3.5-1.5i, -5];
L = place(A_bar', -C_bar', desired_poles)';


% h = get_param(gcs, 'Handle');
% print(h, '../../report/images/task2/model2.png', '-dpng', '-r300');

out = sim('model2');

% Данные из воркспейса

t = out.y.time;

y = out.y.signals.values;
u = out.u.signals.values;
g = out.g.signals.values;
e = g - y;

w_f = out.w_f.signals.values;
wf_hat = out.wf_hat.signals.values;
e_f = w_f - wf_hat;

w_g = out.w_g.signals.values;
wg_hat = out.wg_hat.signals.values;
e_g = w_g - wg_hat;

x = out.x.signals.values;
x_hat = out.x_hat.signals.values;
e_x = x - x_hat;

%%%%%%%%%%%%%%%      очистка всего кроме отрисовки          %%%%%%%%%%%%%%%

clear A B B_f C D D_f G_f G_g K K_f;
clear K_g L wf_0 wg0 Y_f Y_g out wf0 x0;
clear A_bar B_bar C_bar desired_poles G n Q Q_inv Y zero_2 zero_1 r;

%%%%%%%%%%%%%%%      для графиков эстетика                  %%%%%%%%%%%%%%%

colors = [0, 0.5, 0.4; 
        0, 0, 0.7; 
        0.8, 0.2, 0.2; 
        0.85, 0.65, 0.0;
          0.30, 0.40, 0.15; 
          0.40, 0.10, 0.45;
          0.60, 0.20, 0.10;
          0.10, 0.45, 0.40];

L = 2.5; F = 15;

addpath('/home/eva/Documents/ITMO/3_course/TAU/lab4/code/config');
