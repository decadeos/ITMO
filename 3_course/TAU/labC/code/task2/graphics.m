clc;

% Моделирование
simOut = sim('test.slx', 'StopTime', '5');
t = simOut.x.time;

u = simOut.u.signals.values;

f1 = simOut.f1.signals.values;
f2 = simOut.f2.signals.values;
g = simOut.g.signals.values;

x = simOut.x.signals.values;
x_hat = simOut.x_hat.signals.values;
ex = x - x_hat;

w = simOut.w.signals.values;
w_hat = simOut.w_hat.signals.values;
ew = w - w_hat;

y = simOut.y.signals.values;
z = simOut.z.signals.values;


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


u_names = {'$u_1(t)$', '$u_2(t)$'};
z_names = {'$z_1(t)$', '$z_2(t)$'};
y_names = {'$y_1(t)$', '$y_2(t)$'};
g_names = {'$g_1(t)$', '$g_2(t)$'};
f1_names = {'$f_{11}(t)$', '$f_{12}(t)$'};
f2_names = {'$f_{21}(t)$', '$f_{22}(t)$'};
ex_names = {'$e_{x1}(t)$', '$e_{x2}(t)$'};
ew_names = {'$e_{w1}(t)$', '$e_{w2}(t)$', '$e_{w3}(t)$', '$e_{w4}(t)$', '$e_{w5}(t)$', '$e_{w6}(t)$'};

err_names = {'$e_1(t)$', '$e_2(t)$', '$e_3(t)$', '$e_4(t)$'};
var_names = {'$x_1(t)$', '$x_2(t)$', '$x_3(t)$', '$x_4(t)$' ...
    '$\hat{x_1}(t)$', '$\hat{x_2}(t)$', '$\hat{x_3}(t)$', '$\hat{x_4}(t)$'};

folder = '../../report/images/task2';


% u
% u_fig = figure('Position', [100, 100, 900, 350]); ax = gca; hold on;
% 
% for j = 1:2
%     plot(t, u(:,j), 'Color', colors(j+1,:), 'LineWidth', line_width, 'DisplayName', u_names{j}); hold on;
% end
% 
% xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% ylabel('$u(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% legend('Location', 'southeast', 'FontSize', font_size_legend, 'Interpreter', 'latex', NumColumns=2);
% setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
% filename = fullfile(folder, sprintf('u.png'));
% saveas(u_fig, filename); close(u_fig);


% z
% z_fig = figure('Position', [100, 100, 900, 350]); ax = gca; hold on;
% 
% for j = 1:2
%     plot(t, z(:,j), 'Color', colors(j+1,:), 'LineWidth', line_width, 'DisplayName', z_names{j}); hold on;
% end
% 
% xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% ylabel('$z(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% legend('Location', 'southeast', 'FontSize', font_size_legend, 'Interpreter', 'latex', NumColumns=2);
% setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
% filename = fullfile(folder, sprintf('z.png'));
% saveas(z_fig, filename); close(z_fig);



% y
% y_fig = figure('Position', [100, 100, 900, 350]); ax = gca; hold on;
% 
% for j = 1:2
%     plot(t, y(:,j), 'Color', colors(j+1,:), 'LineWidth', line_width, 'DisplayName', y_names{j}); hold on;
% end
% 
% xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% ylabel('$y(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% legend('Location', 'southeast', 'FontSize', font_size_legend, 'Interpreter', 'latex', NumColumns=2);
% setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
% filename = fullfile(folder, sprintf('y.png'));
% saveas(y_fig, filename); 


% g
% g_fig = figure('Position', [100, 100, 900, 350]); ax = gca; hold on;
% 
% for j = 1:2
%     plot(t, g(:,j), 'Color', colors(j+1,:), 'LineWidth', line_width, 'DisplayName', g_names{j}); hold on;
% end
% 
% xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% ylabel('$g(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% legend('Location', 'southeast', 'FontSize', font_size_legend, 'Interpreter', 'latex', NumColumns=2);
% setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
% y_lim = ylim;
% y_offset = 0.2* (y_lim(2) - y_lim(1));
% ylim([y_lim(1)-y_offset, y_lim(2) + y_offset*0.1]);
% filename = fullfile(folder, sprintf('g.png'));
% saveas(g_fig, filename); 


% f1
% f1_fig = figure('Position', [100, 100, 900, 350]); ax = gca; hold on;
% 
% for j = 1:2
%     plot(t, f1(:,j), 'Color', colors(j+1,:), 'LineWidth', line_width, 'DisplayName', f1_names{j}); hold on;
% end
% 
% xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% ylabel('$f_1(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% legend('Location', 'southeast', 'FontSize', font_size_legend, 'Interpreter', 'latex', NumColumns=2);
% setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
% y_lim = ylim;
% y_offset = 0.2* (y_lim(2) - y_lim(1));
% ylim([y_lim(1)-y_offset, y_lim(2) + y_offset*0.1]);
% filename = fullfile(folder, sprintf('f1.png'));
% saveas(f1_fig, filename); 



% f2
% f2_fig = figure('Position', [100, 100, 900, 350]); ax = gca; hold on;
% 
% for j = 1:2
%     plot(t, f2(:,j), 'Color', colors(j+1,:), 'LineWidth', line_width, 'DisplayName', f2_names{j}); hold on;
% end
% 
% xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% ylabel('$f_2(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% legend('Location', 'southeast', 'FontSize', font_size_legend, 'Interpreter', 'latex', NumColumns=2);
% setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
% y_lim = ylim;
% y_offset = 0.2* (y_lim(2) - y_lim(1));
% ylim([y_lim(1)-y_offset, y_lim(2) + y_offset*0.1]);
% filename = fullfile(folder, sprintf('f2.png'));
% saveas(f2_fig, filename); 



% x / x_hat
% for i = 1:2
%     fig = figure('Position', [100, 100, 900, 350]);
%     ax = gca; hold on;
% 
%     plot(t, x(:,i), 'Color', colors(2,:), 'LineWidth', line_width, 'DisplayName', sprintf('$x_%d(t)$', i));
%     plot(t, x_hat(:,i), 'Color', colors(3,:), 'LineWidth', line_width, 'DisplayName', sprintf('$\\hat{x}_%d(t)$', i), 'LineStyle', '--');
% 
%     xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
%     ylabel(sprintf('$x_%d(t)$', i), 'Interpreter', 'latex', 'FontSize', font_size_label);
%     legend('Location', 'northeast', 'FontSize', font_size_legend, 'Interpreter', 'latex', 'NumColumns', 2);
%     setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
%     filename = fullfile(folder, sprintf('x%d.png', i));
%     saveas(fig, filename); close(fig);
% end



% w / w_hat
% for i = 1:6
%     fig = figure('Position', [100, 100, 900, 350]); ax = gca; hold on;
% 
%     plot(t, w(:,i), 'Color', colors(2,:), 'LineWidth', line_width, 'DisplayName', sprintf('$w_%d(t)$', i));
%     plot(t, w_hat(:,i), 'Color', colors(3,:), 'LineWidth', line_width, 'DisplayName', sprintf('$\\hat{w}_%d(t)$', i), 'LineStyle', '--');
% 
%     xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
%     ylabel(sprintf('$w_%d(t)$', i), 'Interpreter', 'latex', 'FontSize', font_size_label);
%     legend('Location', 'southeast', 'FontSize', font_size_legend, 'Interpreter', 'latex', 'NumColumns', 2);
%     setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
% 
%     y_lim = ylim;
%     y_offset = 0.25* (y_lim(2) - y_lim(1));
%     ylim([y_lim(1)-y_offset, y_lim(2) + y_offset*0.1]);
% 
%     filename = fullfile(folder, sprintf('w%d.png', i));
%     saveas(fig, filename); close(fig);
% end


% ex
% ex_fig = figure('Position', [100, 100, 900, 350]); ax = gca; hold on;
% 
% for j = 1:2
%     plot(t, ex(:,j), 'Color', colors(j+1,:), 'LineWidth', line_width, 'DisplayName', ex_names{j}); hold on;
% end
% 
% xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% ylabel('$e_x(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% legend('Location', 'southeast', 'FontSize', font_size_legend, 'Interpreter', 'latex', NumColumns=2);
% setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
% filename = fullfile(folder, sprintf('ex.png'));
% saveas(ex_fig, filename); 


% ew
% ew_fig = figure('Position', [100, 100, 900, 350]); ax = gca; hold on;
% 
% for j = 1:6
%     plot(t, ew(:,j), 'Color', colors(j+1,:), 'LineWidth', line_width, 'DisplayName', ew_names{j}); hold on;
% end
% 
% xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% ylabel('$e_w(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% legend('Location', 'northeast', 'FontSize', font_size_legend, 'Interpreter', 'latex', NumColumns=2);
% setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
% filename = fullfile(folder, sprintf('ew.png'));
% saveas(ew_fig, filename); 