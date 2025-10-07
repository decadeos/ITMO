% График K(T2) при фиксированном T1
T1 = 1/6;                 % фиксируем T1
T2 = linspace(0.01, 0.5, 200);

K = (T1 + T2) ./ (T1 .* T2);

figure('Color', 'white', 'Position', [100, 100, 900, 600]);
plot(T2, K, 'LineWidth', 2.5, 'Color', [0, 0, 0.65]);
hold on
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

xlabel('$T_2$', 'FontSize', 23, 'FontWeight', 'normal', 'Interpreter', 'latex');
ylabel('$K$', 'FontSize', 23, 'FontWeight', 'normal', 'Interpreter', 'latex');

legend({'$T_{\mathrm{2}}$, ($T_{\mathrm{1}}$ - fixed)', '$K=12.5$'}, 'Interpreter', 'latex', 'Location', 'northeast', 'FontSize', 23);

box on;

exportgraphics(gcf, '../../images/task2/T2.png', 'Resolution', 300);
