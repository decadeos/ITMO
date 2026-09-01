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
D = zeros(2,1);

% НУ
x0_list = {
    [0.02; 0; 0; 0],
    [0; 0.1; 0; 0],
    [0; 0; 0.02; 0],
    [0; 0; 0; 0.1],
    [0.02; 0.1; 0.02; 0.1]
};

% Время
time_intervals = {[0, 0.3], [0, 3]};
interval_suffix = {'1', '2'};

% Красота
colors = [0, 0.5, 0.4; 
          0, 0, 0.7; 
          0.8, 0.2, 0.2; 
          0.85, 0.65, 0.0];
line_width = 2.5;
font_size_label = 15;
font_size_legend = 17;

addpath('../../../config');

% % Цикл по
% for i = 1:length(x0_list) % НУ
%     for t_idx = 1:length(time_intervals) % Времени
%         tspan = time_intervals{t_idx};
%         x0 = x0_list{i};
% 
%         % Линейная модель
%         sys_lin = ss(A, B, C, D);
%         [~, t_lin, x_lin] = initial(sys_lin, x0, tspan);
% 
%         % Нелинейная модель
%         u = 0; f = 0;
%         [t_nlin, x_nlin] = ode45(@(t,x) nonlinear_model(t, x, u, f, M, m, beta, J, l, g), tspan, x0);
% 
%         var_names = {'a', 'v', 'phi', 'w'};
%         y_labels = {'$a(t)$', '$\dot{a}(t)$', '$\varphi(t)$', '$\dot{\varphi}(t)$'};
%         y_data_lin = {x_lin(:,1), x_lin(:,2), x_lin(:,3), x_lin(:,4)};
%         y_data_nlin = {x_nlin(:,1), x_nlin(:,2), x_nlin(:,3), x_nlin(:,4)};
% 
%         for j = 1:4
%             figure('Position', [100, 100, 900, 350]);
%             ax = gca;
% 
%             plot(t_lin, y_data_lin{j}, 'Color', colors(2,:), 'LineWidth', line_width); hold on;
%             plot(t_nlin, y_data_nlin{j}, 'Color', colors(3,:), 'LineWidth', line_width, 'LineStyle', '--');
% 
%                 % Добавляю ОФСЕТИК в процентиках на OY
%             y_lim = ylim;
%             y_offset = 0.45 * (y_lim(2) - y_lim(1));
%             ylim([y_lim(1) - y_offset, y_lim(2) + y_offset]);
% 
%             xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
%             ylabel(y_labels{j}, 'Interpreter', 'latex', 'FontSize', font_size_label);
%             legend('$linear$', '$nonlinear$', 'Interpreter', 'latex', 'Location', 'best', 'FontSize', font_size_legend);
% 
%             setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
% 
%             filename = sprintf('../../report/images/task2/%s_%d_%s.png', var_names{j}, i, interval_suffix{t_idx});
%             saveas(gcf, filename);
%             close(gcf);
%         end
%     end
% end