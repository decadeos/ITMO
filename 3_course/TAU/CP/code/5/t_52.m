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


nu = [0.1, 0.2, 0.3];
B_amp = [0.1, 0.1, 0.1];
psi = [0, pi/6, pi/4];

% Генератор
p_g = 2 * length(nu);
G_g = zeros(p_g);
Y_g = zeros(1, p_g);
w_g0 = zeros(p_g, 1);

for i = 1:length(nu)
    idx = 2*(i-1) + 1;
    G_g(idx:idx+1, idx:idx+1) = [0, nu(i); -nu(i), 0];
    Y_g(idx:idx+1) = [B_amp(i)*cos(psi(i)), B_amp(i)*sin(psi(i))];
    w_g0(idx:idx+1) = [0; 1];      % тогда gg = Y_g*w = A_i*sin(nu_i*t + psi_i)
end


n = size(A, 1);
p = size(G_g, 1);

cvx_begin sdp quiet
    variable X_g(n, p)
    variable U_g(1, p)
    
    minimize(norm(U_g))
    
    subject to
        X_g * G_g - A * X_g - B * U_g == zeros(n, p);
        
        C(2,:) * X_g == Y_g; 
cvx_end

K_g = (U_g - K * X_g);

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
phi_lin = simOut.x_lin.signals.values(:, 3) / 3;


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

var_names = {'$y_{lin}(t)$', '$$y_{nonlin}(t)$', '$g(t)$'};

plot(t, phi_lin, 'Color', colors(1,:), 'LineWidth', line_width, 'DisplayName', [var_names{1}]); hold on;
plot(t, phi_nlin, 'Color', colors(2,:), 'LineWidth', line_width, 'DisplayName', [var_names{2}]); hold on;
plot(t, gg, 'Color', colors(3,:), 'LineWidth', line_width, 'DisplayName', [var_names{3}]);

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
ylabel('$y(t), g(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
legend('Interpreter', 'latex', 'Location', 'northeast', 'FontSize', font_size_legend, 'NumColumns', 3);
setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
