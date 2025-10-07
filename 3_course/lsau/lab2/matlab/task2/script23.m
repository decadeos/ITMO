% Очистка workspace и закрытие всех графиков
clear; close all; clc;

% Создание папки для сохранения изображений, если её нет
if ~exist('../images/task2', 'dir')
    mkdir('../images/task2');
end

% Номинальные параметры
T1_nom = 1/6;
T2_nom = 1/6.5;

% Параметры для трех случаев устойчивости
params = [
    5, T1_nom, T2_nom;          % устойчивый случай
    12.5, T1_nom, T2_nom;       % на границе устойчивости
    20, T1_nom, T2_nom          % неустойчивый случай
];

%% ФИГУРА 1: Устойчивая система (K=4)
figure('Color', 'white', 'Position', [100, 100, 1100, 400]);

K = params(1, 1);
T1 = params(1, 2);
T2 = params(1, 3);

% Передаточная функция
num_open = K;
den_open = conv(conv([T1 1], [T2 1]), [1 0]);
W_open = tf(num_open, den_open);
W_closed = feedback(W_open, 1);

% Моделирование
t = linspace(0, 8, 2000);
[y, t_step] = step(W_closed, t);

plot(t_step, y, 'LineWidth', 2.5, 'Color', [0, 0, 0.65]);

ax = gca;
ax.LineWidth = 1.5;
ax.FontSize = 11;
ax.FontName = 'DejaVuMathTeXGyre';
ax.XColor = [0.3, 0.3, 0.3];
ax.YColor = [0.3, 0.3, 0.3];
grid on; grid minor;
ax.GridColor = [0.9, 0.9, 0.9];
ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95, 0.95, 0.95];
ax.MinorGridAlpha = 0.2;
xlabel('Time', 'FontSize', 15, 'FontWeight', 'normal');
ylabel('Amplitude', 'FontSize', 15, 'FontWeight', 'normal');

legend({'$y(t)$'}, 'Interpreter', 'latex', 'Location', 'southeast', 'FontSize', 15);

xlim([0, 5]);
ylim([0, 1.5]);
box on;

exportgraphics(gcf, '../../images/task2/y1.png', 'Resolution', 300);

%% ФИГУРА 2: Система на границе устойчивости (K=12.5)
figure('Color', 'white', 'Position', [100, 100, 1100, 400]);

K = params(2, 1);
T1 = params(2, 2);
T2 = params(2, 3);

% Передаточная функция
num_open = K;
den_open = conv(conv([T1 1], [T2 1]), [1 0]);
W_open = tf(num_open, den_open);
W_closed = feedback(W_open, 1);

% Моделирование
t = linspace(0, 15, 2500);
[y, t_step] = step(W_closed, t);

plot(t_step, y, 'LineWidth', 2.5, 'Color', [0.8, 0.2, 0.2]);

ax = gca;
ax.LineWidth = 1.5;
ax.FontSize = 11;
ax.FontName = 'DejaVuMathTeXGyre';
ax.XColor = [0.3, 0.3, 0.3];
ax.YColor = [0.3, 0.3, 0.3];
grid on; grid minor;
ax.GridColor = [0.9, 0.9, 0.9];
ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95, 0.95, 0.95];
ax.MinorGridAlpha = 0.2;
xlabel('Time', 'FontSize', 15, 'FontWeight', 'normal');
ylabel('Amplitude', 'FontSize', 15, 'FontWeight', 'normal');

legend({'$y(t)$'}, 'Interpreter', 'latex', 'Location', 'southeast', 'FontSize', 15);

xlim([0, 5]);
ylim([-0.5, 2.5]);
box on;

exportgraphics(gcf, '../../images/task2/y2.png', 'Resolution', 300);

%% ФИГУРА 3: Неустойчивая система (K=20)
figure('Color', 'white', 'Position', [100, 100, 1100, 400]);

K = params(3, 1);
T1 = params(3, 2);
T2 = params(3, 3);

% Передаточная функция
num_open = K;
den_open = conv(conv([T1 1], [T2 1]), [1 0]);
W_open = tf(num_open, den_open);
W_closed = feedback(W_open, 1);

% Моделирование
t = linspace(0, 6, 1500);
[y, t_step] = step(W_closed, t);

plot(t_step, y, 'LineWidth', 2.5, 'Color', [0.2, 0.6, 0.2]);

ax = gca;
ax.LineWidth = 1.5;
ax.FontSize = 11;
ax.FontName = 'DejaVuMathTeXGyre';
ax.XColor = [0.3, 0.3, 0.3];
ax.YColor = [0.3, 0.3, 0.3];
grid on; grid minor;
ax.GridColor = [0.9, 0.9, 0.9];
ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95, 0.95, 0.95];
ax.MinorGridAlpha = 0.2;
xlabel('Time', 'FontSize', 15, 'FontWeight', 'normal');
ylabel('Amplitude', 'FontSize', 15, 'FontWeight', 'normal');

legend({'$y(t)$'}, 'Interpreter', 'latex', 'Location', 'southeast', 'FontSize', 15);

xlim([0, 5]);
ylim([-20, 30]);
box on;

exportgraphics(gcf, '../../images/task2/y3.png', 'Resolution', 300);

fprintf('Все три графика сохранены:\n');
fprintf('- stable_system.png: K=4 (устойчивая)\n');
fprintf('- critical_system.png: K=12.5 (граница устойчивости)\n');
fprintf('- unstable_system.png: K=20 (неустойчивая)\n');