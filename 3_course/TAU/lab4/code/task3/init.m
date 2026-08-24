clear all; clc; close all;

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

Q = [0.2000    0.1724   -0.0690;
    1.1667    1.0500   -0.3500;
    1.1429    1.0566   -0.3019;];

Q_inv = inv(Q);


%%%%%%%%%%%%%%
C_st = [0  0 -1;
       -1  0 -1];

G_st = diag([-1, -2, -3, -4]);
Y_st = Y_f;

Y_st = [1 2 3 4; 5 6 7 8];

Q_st = lyap(-G_f', G_st, -(Y_f' * Y_st))
Q_st_inv = inv(Q_st);

L_st = -(Y_st * inv(Q_st))'

F = G_f - L_st * Y_f

% h = get_param(gcs, 'Handle');
% print(h, '../../report/images/task3/model31.png', '-dpng', '-r300');

out = sim('model31');

% Данные из воркспейса

% t = out.y.time;
% 
% y = out.y.signals.values;
% u = out.u.signals.values;
% g = out.g.signals.values;
% e = g - y;
% 
% w_f = out.w_f.signals.values;
% wf_hat = out.wf_hat.signals.values;
% e_f = w_f - wf_hat;
% 
% x = out.x.signals.values;

%%%%%%%%%%%%%%%      очистка всего кроме отрисовки          %%%%%%%%%%%%%%%

clear A B B_f C D D_f G_f G_g K K_f L F;
clear K_g L wf_0 wg0 Y_g out wf0 x0 Y_f Y_st;
clear C_st G G_st L_st Q Q_st_inv Q_inv Q_st_inv Y Q_st;

%%%%%%%%%%%%%%%      для графиков эстетика                  %%%%%%%%%%%%%%%

colors = [0, 0.5, 0.4; 
        0, 0, 0.7; 
        0.8, 0.2, 0.2; 
        0.85, 0.65, 0.0;
          0.30, 0.40, 0.15; 
          0.40, 0.10, 0.45;
          0.60, 0.20, 0.10;
          0.10, 0.45, 0.40];

L_g = 2.5; F_g = 15;

addpath('/home/eva/Documents/ITMO/3_course/TAU/lab4/code/config');