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

lamJe_list = {
    [-0.5, -0.7, -1+0.5i, -1-0.5i], % 2. Слабый регулятор
    [-1.5, -2, -3+1i, -3-1i], % 3. Средний регулятор
    [-15, -10, -8+2i, -8-2i]}; % 4. Сильный 


% Отрисовка

x0 = [0.1; 0.2; 0.03; 0.12];

t = [0, 15];

colors = [0, 0.5, 0.4;    
          0, 0, 0.7;        
          0.8, 0.2, 0.2;    
          0.85, 0.65, 0.0];

line_width = 2.5;
font_size_label = 15;
font_size_legend = 17;

addpath('../../../config');


for i = 1:3
    lamJe = lamJe_list{i};
    K = acker(A, B, lamJe)

    if i == 3
        f = 0;
        simOut = sim('nonlinear_closed');
        t = simOut.x.time;
        x = simOut.x.signals.values;
    else
        [t, x] = ode45(@(t, x) nonlinear_model_closed(t, x, K, M, m, beta, J, l, g), t, x0);
    end

    figure('Position', [100, 100, 900, 350]);
    ax = gca; hold on;

    % Переменные
    var_names = {'$a(t)$', '$\dot{a}(t)$', '$\varphi(t)$', '$\dot{\varphi}(t)$'};
    colors_var = [colors(1,:); colors(2,:); colors(3,:); colors(4,:)];

    for j = 1:4
        plot(t, x(:,j), 'Color', colors_var(j,:), 'LineWidth', line_width, 'DisplayName', var_names{j})
    end

   % Добавляю ОФСЕТИК в процентиках на OY
    y_lim = ylim;
    
    if i == 3
        % Только вверх, без нижнего отступа
        ylim([y_lim(1), y_lim(2) + 0.2*(y_lim(2)-y_lim(1))]);
    else
        % Симметричный отступ 5%
        y_offset = 0.05 * (y_lim(2) - y_lim(1));
        ylim([y_lim(1) - y_offset, y_lim(2) + y_offset]);
    end

    xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    legend('Interpreter', 'latex', 'Location', 'northeast', 'FontSize', font_size_legend, NumColumns=2);

    setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);

    % Сохранение
    folder = '../../report/images/task3/3_12';
    filename = fullfile(folder, sprintf('state_%d.png', i));
    saveas(gcf, filename);
    close(gcf);
end
