clc;

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
font_size_legend = 15;

addpath('../../../config');

% J

% J_fig = figure('Position', [100, 100, 900, 350]);
% ax = gca; hold on;
% 
% var_names = {'$(Q_0, R_0)$', '$(\alpha Q_0, R_0)$', '$(Q_0, \alpha R_0)$', '$(\alpha Q_0, \alpha R_0)$'};
% 
% for j = 1:4
%     plot(t_vec, J_cell{j}, 'Color', colors(j,:), 'LineWidth', line_width, 'DisplayName', [var_names{j}]);
%     hold on;
%     yline(Jmin_vec(j), '--', 'Color', colors(j+4,:), 'LineWidth', line_width, ...
%           'DisplayName', sprintf('$J_{min} = %.1f$', Jmin_vec(j)));
%     hold on;
% end
% 
% xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% ylabel('$J$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% legend('Location', 'northeast', 'FontSize', font_size_legend, 'Interpreter', 'latex', NumColumns=4);
% setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
% 
% y_lim = ylim;
% y_offset = 0.3 * (y_lim(2) - y_lim(1));
% ylim([y_lim(1), y_lim(2) + y_offset]);
% 
% saveas(J_fig, fullfile('../../report/images/task1', 'J.png')); close(J_fig);



% u

% u_fig = figure('Position', [100, 100, 900, 350]);
% ax = gca; hold on;
% var_names = {'$u_1(t)$', '$u_2(t)$', '$u_3(t)$', '$u_4(t)$'};
% 
% for j = 1:4
%     K = K_cell{j};
%     simOut = sim('closed.slx', 'StopTime', '2');
%     t = simOut.u.time;
%     u = simOut.u.signals.values;
% 
%     if j == 4, line_style = '--'; else, line_style = '-'; end
% 
%     plot(t, u, 'Color', colors(j,:), 'LineWidth', line_width, 'DisplayName', [var_names{j}], 'LineStyle',line_style);
%     hold on;
% 
% end
% 
% xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% ylabel('$u(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% legend('Location', 'southeast', 'FontSize', font_size_legend+2, 'Interpreter', 'latex');
% setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
% saveas(u_fig, fullfile('../../report/images/task1', 'u.png')); close(u_fig);




% x

var_names = {'$x_1(t)$', '$x_2(t)$', '$x_3(t)$'};

for i = 1:4
    x_fig = figure('Position', [100, 100, 900, 350]);
    ax = gca; hold on;

    K = K_cell{i};
    simOut = sim('closed.slx', 'StopTime', '2');
    t = simOut.u.time;
    x = simOut.x.signals.values;

    for j = 1:3
        plot(t, x(:,j), 'Color', colors(j,:), 'LineWidth', line_width, 'DisplayName', [var_names{j}]);
        hold on;
    end

    xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    legend('Location', 'northeast', 'FontSize', font_size_legend+2, 'Interpreter', 'latex');
    setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);

    y_lim = ylim;
    y_offset = 0.1* (y_lim(2) - y_lim(1));
    ylim([y_lim(1), y_lim(2) + y_offset]);

    filename = sprintf('../../report/images/task1/x_%d.png', i);
    saveas(x_fig, filename); close(x_fig);
end


