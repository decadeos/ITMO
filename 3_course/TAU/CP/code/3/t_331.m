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

KL_array = {
    [-2, -3, -1+0.5i, -1-0.5i], [-1, -2, -3+1i, -3-1i];   % 1. Равны по силе
    [-8, -10, -4+3i, -4-3i], [-2, -1, -1+0.5i, -1-0.5i]; % 2. Рег > Набл
    [-1, -0.5, -0.5+0.2i, -0.5-0.2i], [-5, -6, -12+2i, -12-2i]; % 3. Рег < Набл
    [-0.1, -0.5, -0.5+0.1i, -0.5-0.1i], [-0.5, -1, -0.1+1i, -0.1-1i]; % равны, не справились
};


% config
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

for i = 1:4
    K_spec = KL_array{i, 1};
    L_spec = KL_array{i, 2};
    
    K = acker(A, B, K_spec)
    L = place(A', C', L_spec)'

    simOut = sim('nonlinear_closed_out.slx');
    t = simOut.x.time;
    x = simOut.x.signals.values;
    x_hat = simOut.x_hat.signals.values;
    e = x - x_hat;

    err_names = {'$e_a(t)$', '$e_{\dot{a}}(t)$', '$e_{\varphi}(t)$', '$e_{\dot{\varphi}}(t)$'};

    fig_err = figure('Position', [100, 100, 900, 350]);
    ax = gca; hold on;

    for j = 1:4
        plot(t, e(:,j), 'Color', colors(j,:), 'LineWidth', line_width, 'DisplayName', err_names{j});
    end

    xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    ylabel('$e(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    if i ~= 4    
        legend('Interpreter', 'latex', 'Location', 'northeast', 'FontSize', font_size_legend);
    else
        legend('Interpreter', 'latex', 'Location', 'southwest', 'FontSize', font_size_legend);
    end
    setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);

    xlim([0,5]); y_lim = ylim;
    y_offset = 0.05 * (y_lim(2) - y_lim(1));
    ylim([y_lim(1) - y_offset, y_lim(2) + y_offset]);

    saveas(gcf, fullfile('../../report/images/task3/3_31', sprintf('errors_%d.png', i)));



    % Оценки состояния
    fig_state = figure('Position', [100, 100, 900, 350]);
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
    if i ~= 4    
        legend('Interpreter', 'latex', 'Location', 'northeast', 'FontSize', font_size_legend, NumColumns=4);
    else
        legend('Interpreter', 'latex', 'Location', 'southwest', 'FontSize', font_size_legend, NumColumns=4);
    end
    setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);

    y_lim = ylim;
    y_offset = 0.03 * (y_lim(2) - y_lim(1));
    ylim([y_lim(1) - y_offset, y_lim(2) + y_offset*12]);

    saveas(gcf, fullfile('../../report/images/task3/3_31', sprintf('comparison_%d.png', i)));




end