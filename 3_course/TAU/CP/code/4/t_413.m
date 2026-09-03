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

f = 0;
a = 3;

% синтез

cvx_begin sdp
  variable P(4,4) symmetric
  variable Y(1,4)

  minimize(norm(Y));

  P >= 0.0001*eye(4);
  P*A' + A*P + 2*a*P + Y'*B' + B*Y <= 0;
cvx_end

K = -Y * inv(P)

eig(A - B*K)

x0_list = {
    % Узбек
    
    [0; 0; 0.1; 0], % 1. Только отклонение маятника
    [0; 0; 0; 0.15], % 2. Только угловая скорость маятник
    [0.1; 0.1; 0.1; 0.1], % 3. Полностью ненулевые
    
    % Не узбег =(
    
    [0; 0; 1.2; 0], % 4. Слишком большой угол
    [0.5; 0; 1.0; 0], % 5. Большой угол + большая скорость тележки
    [0; 0; 1; 2] % 6. Большая угловая скорость + большой угол
};

% красота

colors = [0, 0.5, 0.4;    
          0, 0, 0.7;        
          0.8, 0.2, 0.2;    
          0.85, 0.65, 0.0];
line_width = 2.5;
font_size_label = 15;
font_size_legend = 17;

addpath('../../../config');


% отрисовка

for i = 1:length(x0_list)

    x0 = x0_list{i};

    if i >= 4
        simOut = sim('nonlinear_closed.slx', 'StopTime', '0.1');
    else
        simOut = sim('nonlinear_closed.slx', 'StopTime', '5');
    end

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

    xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    legend('Interpreter', 'latex', 'Location', 'north', 'FontSize', font_size_legend, NumColumns=2);
    setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);


    y_lim = ylim;
    y_offset = 0.1 * (y_lim(2) - y_lim(1));
    ylim([y_lim(1) - y_offset, y_lim(2) + y_offset]);


    % Сохранение
    folder = '../../report/images/task4/4_13';
    filename = fullfile(folder, sprintf('state_%d.png', i));
    saveas(gcf, filename);
    close(gcf);
end