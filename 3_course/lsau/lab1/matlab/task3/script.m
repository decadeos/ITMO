%% Фигура 1: сигналы y1 и y2
figure('Color', 'white', 'Position', [100, 100, 900, 400]);

plot(mySim.y1.time, mySim.y1.signals.values, ...
    'LineWidth', 2.5, 'Color', [0, 0, 0.65]); % y1 
hold on
plot(mySim.y2.time, mySim.y2.signals.values, ...
    'LineWidth', 2.5, 'Color', [0.8, 0.2, 0.2]); % y2 
hold off

ax1 = gca;
ax1.LineWidth = 1.5;
ax1.FontSize = 11;
ax1.FontName = 'DejaVuMathTeXGyre';
ax1.XColor = [0.3, 0.3, 0.3];
ax1.YColor = [0.3, 0.3, 0.3];

grid on; grid minor;
ax1.GridColor = [0.9, 0.9, 0.9];
ax1.GridAlpha = 0.4;
ax1.MinorGridColor = [0.95, 0.95, 0.95];
ax1.MinorGridAlpha = 0.2;

xlabel('Time', 'FontSize', 13, 'FontWeight', 'normal');
ylabel('Amplitude', 'FontSize', 13, 'FontWeight', 'normal');
legend({'y1(t)', 'y2(t)'}, 'Location', 'southeast', 'FontSize', 13);

set(gcf, 'Color', 'w');
box on;

exportgraphics(gcf, '../../images/task3/y.png', 'Resolution', 300);
disp('Figure 1 (y1 and y2) saved');

% Фигура 2: сигналы sin и u
figure('Color', 'white', 'Position', [200, 200, 900, 400]);

plot(out.sin.time, out.sin.signals.values, ...
    'LineWidth', 2.5, 'Color', [0.8, 0.2, 0.2]); % sin 
hold on
plot(out.u.time, out.u.signals.values, ...
    'LineWidth', 2.5, 'Color', [0, 0, 0.65]); % u 
hold off

ax2 = gca;
ax2.LineWidth = 1.5;
ax2.FontSize = 11;
ax2.FontName = 'DejaVuMathTeXGyre';
ax2.XColor = [0.3, 0.3, 0.3];
ax2.YColor = [0.3, 0.3, 0.3];
ylim([-1.1, 1.1]);
grid on; grid minor;
ax2.GridColor = [0.9, 0.9, 0.9];
ax2.GridAlpha = 0.4;
ax2.MinorGridColor = [0.95, 0.95, 0.95];
ax2.MinorGridAlpha = 0.2;

xlabel('Time', 'FontSize', 13, 'FontWeight', 'normal');
ylabel('Amplitude', 'FontSize', 13, 'FontWeight', 'normal');
legend({'sin(t)', '1(t)'}, 'Location', 'southeast', 'FontSize', 13);

set(gcf, 'Color', 'w');
box on;

exportgraphics(gcf, '../../images/task3/u.png', 'Resolution', 300);
disp('Figure 2 (sin and u) saved');
