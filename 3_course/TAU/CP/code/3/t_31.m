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

lamJe = [-0.5, -0.7, -1+0.5j, -1-0.5j]

G = [-0.5 0 0 0;
     0 -0.7 0 0;
     0 0 -1 -0.5;
     0 0 0.5 -1]

D_poly = poly(G)
D_A = D_poly(1)*A^4 + D_poly(2)*A^3 + D_poly(3)*A^2 + D_poly(4)*A + D_poly(5)*eye(4)

U = ctrb(A, B)

K = [0 0 0 1] * inv(U) * D_A

% тестирование:
K2 = acker(A, B, lamJe)

A_cl = A - B*K2;
eig(A_cl)

% Отрисовка

x0_list = {
    [0; 0; 0.05; 0],        % 1 только отклонение маятника
    [0; 0; 0; 0.15],         % 2 только угловая скорость
    [0.1; 0.2; 0.03; 0.12]  % 3 полностью ненулевые
};

f = 0;

colors = [0, 0.5, 0.4;    
          0, 0, 0.7;        
          0.8, 0.2, 0.2;    
          0.85, 0.65, 0.0];
line_width = 2.5;
font_size_label = 15;
font_size_legend = 17;

addpath('../../../config');


for i = 1:length(x0_list)
    x0 = x0_list{i};
    
    simOut = sim('nonlinear_closed');
    t = simOut.x.time;
    x = simOut.x.signals.values;

    figure('Position', [100, 100, 900, 350]);
    ax = gca; hold on;
    
    % Переменные
    var_names = {'$a(t)$', '$\dot{a}(t)$', '$\varphi(t)$', '$\dot{\varphi}(t)$'};
    colors_var = [colors(1,:); colors(2,:); colors(3,:); colors(4,:)];
    
    for j = 1:4
        plot(t, x(:,j), 'Color', colors_var(j,:), 'LineWidth', line_width, 'DisplayName', var_names{j});
    end

    % Добавляю ОФСЕТИК в процентиках на OY
    y_lim = ylim;
    y_offset = 0.05 * (y_lim(2) - y_lim(1));
    ylim([y_lim(1) - y_offset, y_lim(2) + y_offset]);
    
    xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    legend('Interpreter', 'latex', 'Location', 'northeast', 'FontSize', font_size_legend);
    
    setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
    
    % Сохранение
    folder = '../../report/images/task3/3_1';
    filename = fullfile(folder, sprintf('state_%d.png', i));
    saveas(gcf, filename);
    close(gcf);
end
