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

x0 = [0.1; 0.2; 0.03; 0.12];  
f = 0;

K = 1.0e+05 *[-0.7358   -0.5165   -2.4382   -0.9334];
L = [11.3127   -0.4097;
   39.1565   -1.7601;
    0.4097   11.3127;
    1.3818   45.6631];

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


% моделирование
simOut = sim('nonlinear_closed_out.slx', 'StopTime', '5');
t = simOut.x.time;
x = simOut.x.signals.values;
x_hat = simOut.x_hat.signals.values;
e = x-x_hat;

% Ошибки
figure('Position', [100, 100, 900, 350]);
ax = gca; hold on;

err_names = {'$e_a(t)$', '$e_{\dot{a}}(t)$', '$e_{\varphi}(t)$', '$e_{\dot{\varphi}}(t)$'};

for j = 1:4
    plot(t, e(:,j), 'Color', colors(j,:), 'LineWidth', line_width, 'DisplayName', err_names{j});
end

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
ylabel('$e(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
legend('Interpreter', 'latex', 'Location', 'northeast', 'FontSize', font_size_legend);
setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);

y_lim = ylim;
y_offset = 0.03 * (y_lim(2) - y_lim(1));
ylim([y_lim(1) - y_offset, y_lim(2) + y_offset]);

saveas(gcf, fullfile('../../report/images/task4/4_3', 'errors.png'));

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

saveas(gcf, fullfile('../../report/images/task4/4_3', 'comparison.png'));