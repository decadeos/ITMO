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

% Регулятор
K = [-46.28, -233.21, -10984.45, -3688.10];

lam_obs = [-3, -4, -5+1i, -5-1i];  % быстрее регулятора
L = place(A', C', lam_obs)'

x0 = [0.1; 0.2; 0.03; 0.12];   % реальное состояние
f=0;

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

addpath('../../../config');

% % Ошибки
% figure('Position', [100, 100, 900, 350]);
% ax = gca; hold on;
% 
% simOut = sim('nonlinear_closed_observer.slx');
% t = simOut.x.time;
% x = simOut.x.signals.values;
% x_hat = simOut.x_hat.signals.values;
% e = x-x_hat;
% 
% err_names = {'$e_a(t)$', '$e_{\dot{a}}(t)$', '$e_{\varphi}(t)$', '$e_{\dot{\varphi}}(t)$'};
% 
% for j = 1:4
%     plot(t, e(:,j), 'Color', colors(j,:), 'LineWidth', line_width, 'DisplayName', err_names{j});
% end
% 
% xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% ylabel('$e(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% legend('Interpreter', 'latex', 'Location', 'northeast', 'FontSize', font_size_legend);
% setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
% xlim([0,1.5])
% 
% saveas(gcf, fullfile('../../report/images/task3/3_2', 'errors.png'));
% 
% % Оценки состояния
% figure('Position', [100, 100, 900, 350]);
% ax = gca; hold on;
% 
% var_names = {'$a(t)$', '$\dot{a}(t)$', '$\varphi(t)$', '$\dot{\varphi}(t)$' ...
%     '$\hat{a}(t)$', '$\hat{\dot{a}}(t)$', '$\hat{\varphi}(t)$', '$\hat{\dot{\varphi}}(t)$'};
% 
% for j = 1:4
%     plot(t, x(:,j), 'Color', colors(j,:), 'LineWidth', line_width, ...
%          'DisplayName', [var_names{j}]);
%     hold on;
%     plot(t, x_hat(:,j), 'Color', colors(j+4,:), 'LineWidth', line_width, ...
%          'LineStyle', '--', 'DisplayName', [var_names{j+4}]);
% end
% 
% xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% legend('Interpreter', 'latex', 'Location', 'northeast', 'FontSize', font_size_legend, 'NumColumns', 4);
% setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
% 
% y_lim = ylim;
% y_offset = 0.03 * (y_lim(2) - y_lim(1));
% ylim([y_lim(1) - y_offset, y_lim(2) + y_offset]);
% 
% saveas(gcf, fullfile('../../report/images/task3/3_2', 'comparison.png'));


% Синтез пониженого
lam_obs = [-5, -6];
Gamma = diag(lam_obs)
z0 = [-0; -0];

a23 = -beta^2 * g / Meff  
a43 = (M+m) * beta * g / Meff 

syms q11 q13 q21 q23 real
Q_sym = [q11, 1, q13, 0;
         q21, 0, q23, 1];

left = Gamma * Q_sym - Q_sym * A

eq2 = left(:,2) == 0; 
eq4 = left(:,4) == 0; 

sol = solve([eq2; eq4], [q11, q13, q21, q23]);

q11 = double(sol.q11);
q13 = double(sol.q13);
q21 = double(sol.q21);
q23 = double(sol.q23);

Q = [q11, 1, q13, 0;
     q21, 0, q23, 1]

T = [C; Q]
T_inv = inv(T)
Y = (Gamma * Q - Q * A) * pinv(C)


simOut = sim('nonlinear_closed_observer_redused.slx');
t = simOut.x.time;
x = simOut.x.signals.values;
x_hat = simOut.x_hat.signals.values;
e = x-x_hat;


% Ошибки
figure('Position', [100, 100, 900, 350]);
ax = gca; hold on;

err_names = {'$e_a(t)$', '$e_{\dot{a}}(t)$', '$e_{\varphi}(t)$', '$e_{\dot{\varphi}}(t)$'};

for j = 1:4
    if j==3
        plot(t, e(:,j), 'Color', colors(j,:), 'LineWidth', line_width, 'DisplayName', err_names{j}, LineStyle='--');
    else
        plot(t, e(:,j), 'Color', colors(j,:), 'LineWidth', line_width, 'DisplayName', err_names{j}, LineStyle='-');
    end
end

y_lim = ylim;
y_offset = 0.1 * (y_lim(2) - y_lim(1));
ylim([y_lim(1) - y_offset, y_lim(2) + y_offset]);

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
ylabel('$e(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
legend('Interpreter', 'latex', 'Location', 'southeast', 'FontSize', font_size_legend);
setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
xlim([0,1.5])

saveas(gcf, fullfile('../../report/images/task3/3_2', 'errors_red.png'));


% Оценки состояния
figure('Position', [100, 100, 900, 350]);
ax = gca; hold on;

var_names = {'$a(t)$', '$\dot{a}(t)$', '$\varphi(t)$', '$\dot{\varphi}(t)$' ...
    '$\hat{a}(t)$', '$\hat{\dot{a}}(t)$', '$\hat{\varphi}(t)$', '$\hat{\dot{\varphi}}(t)$'};

for j = 1:4
    plot(t, x(:,j), 'Color', colors(j,:), 'LineWidth', line_width, ...
         'DisplayName', [var_names{j}]);
    hold on;
    plot(t, x_hat(:,j), 'Color', colors(j+4,:), 'LineWidth', line_width, ...
         'LineStyle', '--', 'DisplayName', [var_names{j+4}]);
end

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
legend('Interpreter', 'latex', 'Location', 'northeast', 'FontSize', font_size_legend, 'NumColumns', 4);
setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);

y_lim = ylim;
y_offset = 0.03 * (y_lim(2) - y_lim(1));
ylim([y_lim(1) - y_offset, y_lim(2) + y_offset]);

saveas(gcf, fullfile('../../report/images/task3/3_2', 'comparison_red.png'));