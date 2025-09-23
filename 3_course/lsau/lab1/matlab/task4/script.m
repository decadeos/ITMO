figure('Color', 'white', 'Position', [100, 100, 900, 400]);
mySim = sim('model');

plot(mySim.y1.time, mySim.y1.signals.values, ...
    'LineWidth', 2.5, 'Color', [0, 0, 0.65]); % y1 
hold on
plot(mySim.y2.time, mySim.y2.signals.values, ...
    'LineWidth', 2.5, 'Color', [0.8, 0.2, 0.2]); % y2 
hold off

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

xlabel('Time', 'FontSize', 13, 'FontWeight', 'normal');
ylabel('Amplitude', 'FontSize', 13, 'FontWeight', 'normal');
legend({'y_1(t)', 'y_2(t)'}, 'Location', 'northeast', 'FontSize', 13);

set(gcf, 'Color', 'w');
box on;

exportgraphics(gcf, '../../images/task4/y.png', 'Resolution', 300);
disp('Output signals y1 and y2 plot saved');

