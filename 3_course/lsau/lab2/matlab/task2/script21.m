% Параметры
T2 = 1/6.5;          % фиксируем T2
T1 = linspace(0.01, 0.5, 200);  % диапазон T1 > 0

% Граница устойчивости
K = (T1 + T2) ./ (T1 .* T2);

% Рисуем график
figure('Color', 'white', 'Position', [100, 100, 900, 600]);

plot(T1, K, 'LineWidth', 2.5, 'Color', [0, 0, 0.65]);
hold on
% Для примера можно добавить горизонтальную линию с K=12.5 (из твоих данных)
yline(12.5, '--', 'LineWidth', 2.5, 'Color', [0.8, 0.2, 0.2]);
hold off

ax = gca;
ax.LineWidth = 1.5;
ax.FontSize = 20;
ax.FontName = 'DejaVuMathTeXGyre';
ax.XColor = [0.3, 0.3, 0.3];
ax.YColor = [0.3, 0.3, 0.3];
grid on; grid minor;
ax.GridColor = [0.9, 0.9, 0.9];
ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95, 0.95, 0.95];
ax.MinorGridAlpha = 0.2;

xlabel('$T_1$', 'FontSize', 23, 'FontWeight', 'normal', 'Interpreter', 'latex');
ylabel('$K$', 'FontSize', 23, 'FontWeight', 'normal', 'Interpreter', 'latex');

legend({'$T_{\mathrm{1}}$, ($T_{\mathrm{2}}$ - fixed)', '$K=12.5$'}, 'Interpreter', 'latex', 'Location', 'northeast', 'FontSize', 23);

box on;

% Сохраняем
exportgraphics(gcf, '../../images/task2/T1.png', 'Resolution', 400);
