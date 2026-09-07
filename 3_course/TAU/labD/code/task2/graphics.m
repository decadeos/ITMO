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
font_size_legend = 17;

addpath('../../../config');

err_names = {'$e_1(t)$', '$e_2(t)$', '$e_3(t)$', '$e_4(t)$'};
var_names = {'$x_1(t)$', '$x_2(t)$', '$x_3(t)$', '$x_4(t)$' ...
    '$\hat{x_1}(t)$', '$\hat{x_2}(t)$', '$\hat{x_3}(t)$', '$\hat{x_4}(t)$'};

folder = '../../report/images/task2';

for i = 1:4

    e_fig = figure('Position', [100, 100, 900, 350]);
    ax = gca; hold on;

    L = L_cell{i};

    simOut = sim('closed_observer.slx', 'StopTime', '15');
    t = simOut.x.time;
    x = simOut.x.signals.values;
    x_hat = simOut.x_hat.signals.values;
    e = x-x_hat;

    for j = 1:4
        plot(t, e(:,j), 'Color', colors(j,:), 'LineWidth', line_width, 'DisplayName', err_names{j});
    end

    xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    ylabel('$e(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    legend('Location', 'southeast', 'FontSize', font_size_legend, 'Interpreter', 'latex', NumColumns=2);
    setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);

    y_lim = ylim;
    y_offset = 0.2* (y_lim(2) - y_lim(1));
    ylim([y_lim(1)-y_offset, y_lim(2) + y_offset*0.1]);

    filename = fullfile(folder, sprintf('e_%d.png', i));
    saveas(e_fig, filename);
    close(e_fig);


    x_fig = figure('Position', [100, 100, 900, 350]);
    ax = gca; hold on;

    for j = 1:4
        plot(t, x(:,j), 'Color', colors(j,:), 'LineWidth', line_width, ...
             'DisplayName', [var_names{j}]);
        plot(t, x_hat(:,j), 'Color', colors(j+4,:), 'LineWidth', line_width, ...
             'LineStyle', '--', 'DisplayName', [var_names{j+4}]);
    end

    xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    legend('Interpreter', 'latex', 'Location', 'northeast', 'FontSize', font_size_legend, 'NumColumns', 4);
    setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);

    y_lim = ylim;
    y_offset = 0.4* (y_lim(2) - y_lim(1));
    ylim([y_lim(1), y_lim(2) + y_offset]);

    filename = fullfile(folder, sprintf('x_compare_%d.png', i));
    saveas(x_fig, filename);
    close(x_fig);

end