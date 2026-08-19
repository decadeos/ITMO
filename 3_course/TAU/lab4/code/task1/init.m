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
K_g = [0.0703124999999999       -0.0561558901682905        0.0658104517271922];

K_f = [4.67331092826515         0.939042762776683         -2.71036315323295         -1.34100974313552];


% Олеся
% K = [-6.191 0.420 -6.191];
% K_g = [0.2429 0.2213 0.1346];
% 
% K_f = [-3.81490665 -0.65211419  3.55149267 -1.74197164];
% Kf = [1.8884, 1.1542, -1.4318, -2.4429]


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

%%%%%%%%%%%%%%%      очистка                                %%%%%%%%%%%%%%%

% clear A B B_f bool_K bool_K_f bool_K_g C D D_f G_f G_g K K_f;
% clear K_g L wf_0 wg0 Y_f Y_g out wf0 x0;

%%%%%%%%%%%%%%%      цвета в ините                          %%%%%%%%%%%%%%%

colors = [0, 0.5, 0.4; 
        0, 0, 0.7; 
        0.8, 0.2, 0.2; 
        0.85, 0.65, 0.0]; 
L = 2.5; F = 15;


