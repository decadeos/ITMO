a1 = 12.5;
a0 = 39;

a1 = 5.8;
a0 = 57.41;

a1 = 0.0;
a0 = 361;

a1 = -1.8;
a0 = 49.81;

a1 = -12.5;
a0 = 39;

a1 = 0.0;
a0 = -3.24;

model = sim('model1')

relativePath = fullfile('../../images/task1', 'model1.png');
print('-smodel1', '-dpng', '-r300', relativePath)

t = model.y.time;               % вектор времени
y = model.y.signals.values;    % значения сигнала
y2 = 13 * exp(-6 * t) - 12 * exp(-6.5 * t);
y2 = exp(-2.9 * t) .* (cos(7 * t) + (29/70) * sin(7 * t));
y2 = cos(19 * t);
y2 = exp(0.9 * t) .* (0.05 * cos(7 * t) - (45 / 7000) * sin(7 * t));
y2 = 0.65 * exp(6 * t) - 0.6 * exp(6.5 * t);
y2 = (1/36) * exp(1.8 * t) - (1/36) * exp(-1.8 * t);

figure('Color', 'white', 'Position', [100, 100, 1100, 400]);

plot(t, y, 'LineWidth', 2.5, 'Color', [0, 0, 0.65]);
hold on
plot(t, y2, '--', 'LineWidth', 2.5, 'Color', [0.8, 0.2, 0.2]);  % вторая функция пунктиром
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
xlabel('Time', 'FontSize', 15, 'FontWeight', 'normal');
ylabel('Amplitude', 'FontSize', 15, 'FontWeight', 'normal');

legend({'$y_{\mathrm{simulink}}(t)$', '$y_{\mathrm{analytical}}(t)$'}, 'Interpreter', 'latex', 'Location', 'southwest', 'FontSize', 15);

box on;

% Сохраняем картинку с высоким разрешением
exportgraphics(gcf, '../../images/task1/y6.png', 'Resolution', 300);
