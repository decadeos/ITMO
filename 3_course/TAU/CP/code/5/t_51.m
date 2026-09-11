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


w = [1, 3, 6];
A_amp = [0.01, 0.02, 0.015];
phi = [0, pi/6, pi/2];

% Матрица генератора
p_f = 2 * length(w);
G_f = zeros(p_f);
Y_f = zeros(1, p_f);

for i = 1:length(w)
    idx = 2*(i-1) + 1;
    G_f(idx:idx+1, idx:idx+1) = [0, w(i); -w(i), 0];
    Y_f(idx) = A_amp(i) * cos(phi(i));
    Y_f(idx+1) = A_amp(i) * sin(phi(i));
end


n = size(A, 1);     
p = size(G_f, 1);  

cvx_begin sdp quiet
    variable X_f(n, p)
    variable U_f(1, p)
    
    minimize(norm(U_f))
    
    subject to
        X_f * G_f - A * X_f - B * U_f == D * Y_f;
        
        C(2,:) * X_f == zeros(1, p);
cvx_end

K_f = U_f - K * X_f


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

% моделирование
simOut = sim('nonlinear_closed_f.slx', 'StopTime', '35');
t = simOut.x.time;
x = simOut.x.signals.values;
x_lin = simOut.x_lin.signals.values;



% Оценки состояния нелинейная
% figure('Position', [100, 100, 900, 350]);
% ax = gca; hold on;
% 
% var_names = {'$a(t)$', '$\dot{a}(t)$', '$\varphi(t)$', '$\dot{\varphi}(t)$'};
% 
% for j = 1:4
%     plot(t, x(:,j), 'Color', colors(j,:), 'LineWidth', line_width, 'DisplayName', [var_names{j}]);
%     hold on;
% end
% 
% xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% legend('Interpreter', 'latex', 'Location', 'northeast', 'FontSize', font_size_legend, 'NumColumns', 4);
% setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
% saveas(gcf, fullfile('../../report/images/task5/5_1', 'nonlinear_true.png'));
% 
% 
% % Оценки состояния нелинейная
% figure('Position', [100, 100, 900, 350]);
% ax = gca; hold on;
% 
% var_names = {'$a(t)$', '$\dot{a}(t)$', '$\varphi(t)$', '$\dot{\varphi}(t)$'};
% 
% for j = 1:4
%     plot(t, x_lin(:,j), 'Color', colors(j,:), 'LineWidth', line_width, 'DisplayName', [var_names{j}]);
%     hold on;
% end
% 
% xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% legend('Interpreter', 'latex', 'Location', 'northeast', 'FontSize', font_size_legend, 'NumColumns', 4);
% setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
% 
% saveas(gcf, fullfile('../../report/images/task5/5_1', 'linear_true.png'));



% FALSE

w = [5, 10, 15];
A_amp = [3, 4, 5];
phi = [pi/3, pi/6, pi/9];

% Матрица генератора
p_f = 2 * length(w);
G_f = zeros(p_f);
Y_f = zeros(1, p_f);

for i = 1:length(w)
    idx = 2*(i-1) + 1;
    G_f(idx:idx+1, idx:idx+1) = [0, w(i); -w(i), 0];
    Y_f(idx) = A_amp(i) * cos(phi(i));
    Y_f(idx+1) = A_amp(i) * sin(phi(i));
end


n = size(A, 1);     
p = size(G_f, 1);  

cvx_begin sdp quiet
    variable X_f(n, p)
    variable U_f(1, p)
    
    minimize(norm(U_f))
    
    subject to
        X_f * G_f - A * X_f - B * U_f == D * Y_f;
        
        C(2,:) * X_f == zeros(1, p);
cvx_end

K_f = U_f - K * X_f

% моделирование
simOut = sim('nonlinear_closed_f.slx', 'StopTime', '25');
t = simOut.x.time;
x = simOut.x.signals.values;
x_lin = simOut.x_lin.signals.values;

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
saveas(gcf, fullfile('../../report/images/task5/5_1', 'nonlinear_false.png'));


% Оценки состояния нелинейная
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

saveas(gcf, fullfile('../../report/images/task5/5_1', 'linear_false.png'));