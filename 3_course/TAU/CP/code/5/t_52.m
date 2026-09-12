clear; clc; close all;

% Параметры
M = 658.36;
m1 = 15.66;
m2 = 14.80;
l = 1.77;
g = 9.81;

m = m1 + m2;
lc = l * (m1/2 + m2) / m;
beta = m * lc;
J = (1/3)*m1*l^2 + m2*l^2;
Meff = (M + m)*J - beta^2;

% Линейная
A = [0, 1, 0, 0;
     0, 0, -beta^2 * g / Meff, 0; 
     0, 0, 0, 1;
     0, 0, (M+m) * beta * g / Meff, 0];

B = [0; J/Meff; 0; -beta/Meff];
C = [1, 0, 0, 0;
     0, 0, 1, 0];
D = [0; -0.001; 0; (M+m)/Meff];

x0 = [0.1; 0.2; 0.03; 0.12];  
K = [-46.28, -233.21, -10984.45, -3688.10];




% ===== Генератор задающего воздействия =====
nu    = [1, 2, 3];
B_amp = [0.02, 0.04, 0.05];
psi   = [pi/2, pi/4, pi/5];
N_harm = length(nu);

% --- Матрица Gamma (блочно-диагональная) ---
G_g = zeros(2*N_harm);
for i = 1:N_harm
    idx = (2*i-1):(2*i);
    G_g(idx, idx) = [0, nu(i); -nu(i), 0];
end

% --- Матрица выхода генератора ---
Y_g = zeros(1, 2*N_harm);
for i = 1:N_harm
    Y_g(2*i-1) = B_amp(i);   % g_i = B_i * w_{i,1}
    Y_g(2*i)   = 0;
end

% --- Начальные условия ---
w0 = zeros(2*N_harm, 1);
for i = 1:N_harm
    w0(2*i-1) = sin(psi(i));
    w0(2*i)   = cos(psi(i));
end



Cphi = [0 0 1 0];          % следим за phi = x3
n = 4; q = 6;              % dim(x), dim(w)

% CVX
cvx_begin quiet
    variables Xg(n,q) Ug(1,q)
    Xg*G_g == A*Xg + B*Ug;
    Cphi*Xg == Y_g;
cvx_end
Kg = Ug + K*Xg;



% Красота
colors = [0, 0.5, 0.4;    
          0, 0, 0.7;        
          0.8, 0.2, 0.2;    
          0.85, 0.65, 0.0;
          0.30, 0.40, 0.15; 
          0.40, 0.10, 0.45;
          0.60, 0.20, 0.10;
          0.10, 0.45, 0.40];

line_width = 2.5;
font_size_label = 15;
font_size_legend = 17;

var_names = {'a', 'v', 'phi', 'w'};
y_labels = {'$a(t)$', '$\dot{a}(t)$', '$\varphi(t)$', '$\dot{\varphi}(t)$'};

addpath('../../../config');

simOut = sim('nonlinear_closed_g.slx', 'StopTime', '20');
t = simOut.x.time;
x = simOut.x.signals.values;
x_lin = simOut.x_lin.signals.values;

gg = simOut.gg.signals.values;
phi_nlin = simOut.x.signals.values(:, 3);
phi_lin = simOut.x_lin.signals.values(:, 3);

e_lin    = gg - phi_lin;      % ошибка линейной модели
e_nonlin = gg - phi_nlin;     % ошибка нелинейной модели


% Оценки состояния нелинейная
figure('Position', [100, 100, 900, 350]);
ax = gca; hold on;

var_names = {'$a(t)$', '$\dot{a}(t)$', '$\varphi(t)$', '$\dot{\varphi}(t)$'};

for j = 1:4
    plot(t, x(:,j), 'Color', colors(j,:), 'LineWidth', line_width, 'DisplayName', [var_names{j}]);
    hold on;
end

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
legend('Interpreter', 'latex', 'Location', 'northeast', 'FontSize', font_size_legend, 'NumColumns', 4);
setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
saveas(gcf, fullfile('../../report/images/task5/5_2', 'nonlinear_true.png'));


% Оценки состояния линейная
figure('Position', [100, 100, 900, 350]);
ax = gca; hold on;

var_names = {'$a(t)$', '$\dot{a}(t)$', '$\varphi(t)$', '$\dot{\varphi}(t)$'};

for j = 1:4
    plot(t, x_lin(:,j), 'Color', colors(j,:), 'LineWidth', line_width, 'DisplayName', [var_names{j}]);
    hold on;
end

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
legend('Interpreter', 'latex', 'Location', 'northeast', 'FontSize', font_size_legend, 'NumColumns', 4);
setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
saveas(gcf, fullfile('../../report/images/task5/5_2', 'linear_true.png'));


% y, y_lin, g

figure('Position', [100, 100, 900, 350]);
ax = gca; hold on;

var_names = {'$g(t)$','$y_{lin}(t)$', '$$y_{nonlin}(t)$'};

plot(t, gg, 'Color', colors(3,:), 'LineWidth', line_width, 'DisplayName', [var_names{1}]); hold on;
plot(t, phi_lin, 'Color', colors(1,:), 'LineWidth', line_width, 'DisplayName', [var_names{2}], 'LineStyle',':'); hold on;
plot(t, phi_nlin, 'Color', colors(2,:), 'LineWidth', line_width, 'DisplayName', [var_names{3}], 'LineStyle','--'); 

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
ylabel('$y(t), g(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
legend('Interpreter', 'latex', 'Location', 'northeast', 'FontSize', font_size_legend, 'NumColumns', 3);
setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
saveas(gcf, fullfile('../../report/images/task5/5_2', 'yg_true.png'));


% e, e_lin
figure('Position', [100, 100, 900, 350]);
ax = gca; hold on;

err_names = {'$e_{lin}(t) = g(t) - y_{lin}(t)$', '$e_{nonlin}(t) = g(t) - y_{nonlin}(t)$'};

plot(t, e_lin,    'Color', colors(3,:), 'LineWidth', line_width, 'DisplayName', err_names{1}); hold on;
plot(t, e_nonlin, 'Color', colors(2,:), 'LineWidth', line_width, 'DisplayName', err_names{2}, 'LineStyle','--');

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
ylabel('$e(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
legend('Interpreter', 'latex', 'Location', 'northeast', 'FontSize', font_size_legend, 'NumColumns', 2);
setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
saveas(gcf, fullfile('../../report/images/task5/5_2', 'error_true.png'));




% FALSE 


% ===== Генератор задающего воздействия =====
nu    = [10, 20, 30];
B_amp = [0.2, 0.4, 0.5];
psi   = [pi/2, pi/4, pi/5];
N_harm = length(nu);

% --- Матрица Gamma (блочно-диагональная) ---
G_g = zeros(2*N_harm);
for i = 1:N_harm
    idx = (2*i-1):(2*i);
    G_g(idx, idx) = [0, nu(i); -nu(i), 0];
end

% --- Матрица выхода генератора ---
Y_g = zeros(1, 2*N_harm);
for i = 1:N_harm
    Y_g(2*i-1) = B_amp(i);   % g_i = B_i * w_{i,1}
    Y_g(2*i)   = 0;
end

% --- Начальные условия ---
w0 = zeros(2*N_harm, 1);
for i = 1:N_harm
    w0(2*i-1) = sin(psi(i));
    w0(2*i)   = cos(psi(i));
end



Cphi = [0 0 1 0];          % следим за phi = x3
n = 4; q = 6;              % dim(x), dim(w)

% CVX
cvx_begin quiet
    variables Xg(n,q) Ug(1,q)
    Xg*G_g == A*Xg + B*Ug;
    Cphi*Xg == Y_g;
cvx_end
Kg = Ug + K*Xg;



% Красота
colors = [0, 0.5, 0.4;    
          0, 0, 0.7;        
          0.8, 0.2, 0.2;    
          0.85, 0.65, 0.0;
          0.30, 0.40, 0.15; 
          0.40, 0.10, 0.45;
          0.60, 0.20, 0.10;
          0.10, 0.45, 0.40];

line_width = 2.5;
font_size_label = 15;
font_size_legend = 17;

var_names = {'a', 'v', 'phi', 'w'};
y_labels = {'$a(t)$', '$\dot{a}(t)$', '$\varphi(t)$', '$\dot{\varphi}(t)$'};

addpath('../../../config');

simOut = sim('nonlinear_closed_g.slx', 'StopTime', '2');
t = simOut.x.time;
x = simOut.x.signals.values;
x_lin = simOut.x_lin.signals.values;

gg = simOut.gg.signals.values;
phi_nlin = simOut.x.signals.values(:, 3);
phi_lin = simOut.x_lin.signals.values(:, 3);

e_lin    = gg - phi_lin;      % ошибка линейной модели
e_nonlin = gg - phi_nlin;     % ошибка нелинейной модели


% Оценки состояния нелинейная
figure('Position', [100, 100, 900, 350]);
ax = gca; hold on;

var_names = {'$a(t)$', '$\dot{a}(t)$', '$\varphi(t)$', '$\dot{\varphi}(t)$'};

for j = 1:4
    plot(t, x(:,j), 'Color', colors(j,:), 'LineWidth', line_width, 'DisplayName', [var_names{j}]);
    hold on;
end

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
legend('Interpreter', 'latex', 'Location', 'southeast', 'FontSize', font_size_legend, 'NumColumns', 4);
setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
y_lim = ylim;
y_offset = 0.2* (y_lim(2) - y_lim(1));
ylim([y_lim(1)-y_offset, y_lim(2) + y_offset*0.1]);
saveas(gcf, fullfile('../../report/images/task5/5_2', 'nonlinear_false.png'));


% Оценки состояния линейная
figure('Position', [100, 100, 900, 350]);
ax = gca; hold on;

var_names = {'$a(t)$', '$\dot{a}(t)$', '$\varphi(t)$', '$\dot{\varphi}(t)$'};

for j = 1:4
    plot(t, x_lin(:,j), 'Color', colors(j,:), 'LineWidth', line_width, 'DisplayName', [var_names{j}]);
    hold on;
end

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
legend('Interpreter', 'latex', 'Location', 'southeast', 'FontSize', font_size_legend, 'NumColumns', 4);
y_lim = ylim;
y_offset = 0.2* (y_lim(2) - y_lim(1));
ylim([y_lim(1)-y_offset, y_lim(2) + y_offset*0.1]);
setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);

saveas(gcf, fullfile('../../report/images/task5/5_2', 'linear_false.png'));


% y, y_lin, g

figure('Position', [100, 100, 900, 350]);
ax = gca; hold on;

var_names = {'$g(t)$','$y_{lin}(t)$', '$$y_{nonlin}(t)$'};

plot(t, gg, 'Color', colors(3,:), 'LineWidth', line_width, 'DisplayName', [var_names{1}]); hold on;
plot(t, phi_lin, 'Color', colors(1,:), 'LineWidth', line_width, 'DisplayName', [var_names{2}]); hold on;
plot(t, phi_nlin, 'Color', colors(2,:), 'LineWidth', line_width, 'DisplayName', [var_names{3}]); 

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
ylabel('$y(t), g(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
legend('Interpreter', 'latex', 'Location', 'northeast', 'FontSize', font_size_legend, 'NumColumns', 3);
setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
saveas(gcf, fullfile('../../report/images/task5/5_2', 'yg_false.png'));


% e, e_lin
figure('Position', [100, 100, 900, 350]);
ax = gca; hold on;

err_names = {'$e_{lin}(t) = g(t) - y_{lin}(t)$', '$e_{nonlin}(t) = g(t) - y_{nonlin}(t)$'};

plot(t, e_lin,    'Color', colors(3,:), 'LineWidth', line_width, 'DisplayName', err_names{1}); hold on;
plot(t, e_nonlin, 'Color', colors(2,:), 'LineWidth', line_width, 'DisplayName', err_names{2});

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
ylabel('$e(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
legend('Interpreter', 'latex', 'Location', 'southeast', 'FontSize', font_size_legend, 'NumColumns', 2);
setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
y_lim = ylim;
y_offset = 0.2* (y_lim(2) - y_lim(1));
ylim([y_lim(1)-y_offset, y_lim(2) + y_offset*0.1]);
saveas(gcf, fullfile('../../report/images/task5/5_2', 'error_false.png'));
