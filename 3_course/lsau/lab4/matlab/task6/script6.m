clear; clc; close all;

W = tf([3],[1 7.5 2]); 

num_H = [6.34375 8.6328125 4.07820638020833];
den_H = [1 0 0.0625];
H = tf(num_H, den_H);

sys_cl = feedback(W*H, 1); 

A = 4;
w = 0.25;
t_sim = (0:0.01:40)';
g = A * sin(w * t_sim);

[y, t] = lsim(sys_cl, g, t_sim);

%% --- График g(t) и y(t) ---
figure('Position', [100 100 900 400]);
plot(t, g, 'Color', [0.8 0.2 0.2], 'LineStyle', '-', ...
    'LineWidth', 2.5, 'DisplayName', 'g(t)');
hold on;
plot(t, y, 'Color', [0, 0, 0.7], 'LineStyle', '--', ...
    'LineWidth', 2.5, 'DisplayName', 'y(t)');

ax = gca; 
ax.LineWidth = 1.5; 
ax.FontSize = 12;
ax.XColor = [0.3 0.3 0.3]; 
ax.YColor = [0.3 0.3 0.3];
ax.GridColor = [0.9 0.9 0.9]; 
ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; 
ax.MinorGridAlpha = 0.2;
grid on; grid minor; box on; ylim([-6, 6]);

xlabel('Time');
ylabel('Amplitude');
legend('Location','northeast','FontSize',13,'NumColumns',1);

%% --- Относительная ошибка e_{отн}(t) = (g - y) / g ---
e_rel = (g - y) ./ g;         % без модуля
e_rel(~isfinite(e_rel)) = NaN; % убираем деление на ноль возле g=0

% Условие окончания переходного процесса: |e_rel| < 0.05
tp_index = find(abs(e_rel) < 0.05, 1, 'first');
if ~isempty(tp_index)
    tp_fact = t(tp_index);
else
    tp_fact = NaN;
end
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
%% --- График относительной ошибки ---
figure('Position', [150 150 900 400]);
hold on;

% Полоса допуска ±5%
fill([t; flipud(t)], [0.05*ones(size(t)); -0.05*ones(size(t))], ...
     [1 0.6 0.6], 'FaceAlpha', 0.4, 'EdgeColor', 'none', ...
     'DisplayName', '±5% region');

% График относительной ошибки
plot(t, e_rel, 'Color', [0, 0.5, 0.4], 'LineStyle', '-', ...
    'LineWidth', 2.5, 'DisplayName', 'e_{rel}(t)');

% Вертикальная линия t_p (если найден)
if ~isnan(tp_fact)
    % точка соприкосновения
    y_tp = e_rel(tp_index);

    % продлеваем линию от нижней границы области до e_rel(tp)
    y_min = -1.05; % нижняя граница красной зоны
    line([tp_fact tp_fact], [y_min y_tp], ...
        'Color', 'k', 'LineStyle', '--', 'LineWidth', 1.5, 'DisplayName', 't_p = 1.45');

    % подпись под осью X
    text(tp_fact, -0.35, sprintf('t_p'), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'top', ...
        'FontSize', 12, 'FontAngle', 'italic');
end

% Оформление
ax = gca; 
ax.LineWidth = 1.5; 
ax.FontSize = 12;
ax.XColor = [0.3 0.3 0.3]; 
ax.YColor = [0.3 0.3 0.3];
ax.GridColor = [0.9 0.9 0.9]; 
ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; 
ax.MinorGridAlpha = 0.2;

grid on; grid minor; box on; 
xlabel('Time');
ylabel('e_{rel}(t)');
ylim([-0.3, 1.05]); xlim([0, 10]);
legend('Location','northeast','FontSize',13,'NumColumns',1);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../images/task6/e.png', 'Resolution', 300);