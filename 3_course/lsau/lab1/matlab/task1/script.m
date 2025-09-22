% Figure 1: Input signal
figure('Color', 'white', 'Position', [100, 100, 900, 400]);

% Plot input signal
plot(out.u.Time, out.u.Data, ...
    'LineWidth', 2.5, ...
    'Color', [0.8, 0.2, 0.2]);

% Configure axes
ax1 = gca;
ax1.LineWidth = 1.5;
ax1.FontSize = 11;
ax1.FontName = 'DejaVuMathTeXGyre';
ax1.XColor = [0.3, 0.3, 0.3];
ax1.YColor = [0.3, 0.3, 0.3];

% Add soft grid
grid on;
grid minor;
ax1.GridColor = [0.9, 0.9, 0.9];
ax1.GridAlpha = 0.4;
ax1.MinorGridColor = [0.95, 0.95, 0.95];
ax1.MinorGridAlpha = 0.2;

% Axis labels
xlabel('Time', 'FontSize', 13, 'FontWeight', 'normal');
ylabel('Amplitude', 'FontSize', 13, 'FontWeight', 'normal');
legend('u(t)', 'Location', [0.7, 0.65, 0.15, 0.15], 'FontSize', 13);
ylim([0, 1.1]);

% Improve graph appearance
set(gcf, 'Color', 'w');
box on;

% СОХРАНЯЕМ ПЕРВЫЙ ГРАФИК СРАЗУ
exportgraphics(gcf, '../../images/task1/u.png', 'Resolution', 300);
disp('Input signal saved');

% Figure 2: Output signal
figure('Color', 'white', 'Position', [100, 100, 900, 400]);

% Plot output signal
plot(out.y.Time, out.y.Data, ...
    'LineWidth', 2.5, ...
    'Color', [0.0, 0.2, 0.6], ...
    'DisplayName', 'y(t)');

% Добавляем горизонтальную линию
yline(3.5, '--', 'LineWidth', 2, 'Color', [0.5, 0.5, 0.5], ...
    'DisplayName', 'Set value (3.5)');

% Configure axes
ax2 = gca;
ax2.LineWidth = 1.5;
ax2.FontSize = 11;
ax2.FontName = 'DejaVuMathTeXGyre';
ax2.XColor = [0.3, 0.3, 0.3];
ax2.YColor = [0.3, 0.3, 0.3];

% Add soft grid
grid on;
grid minor;
ax2.GridColor = [0.9, 0.9, 0.9];
ax2.GridAlpha = 0.4;
ax2.MinorGridColor = [0.95, 0.95, 0.95];
ax2.MinorGridAlpha = 0.2;

% Axis labels
xlabel('Time', 'FontSize', 13, 'FontWeight', 'normal');
ylabel('Amplitude', 'FontSize', 13, 'FontWeight', 'normal');
ylim([0, 3.8]);
legend('show', 'Location', [0.7, 0.65, 0.15, 0.15], 'FontSize', 13);

% Improve graph appearance
set(gcf, 'Color', 'w');
box on;

% СОХРАНЯЕМ ВТОРОЙ ГРАФИК СРАЗУ
exportgraphics(gcf, '../../images//task1/y.png', 'Resolution', 300);
disp('Output signal saved');


% Узнаем имя текущей модели
model_name = gcs; % Gets current system
disp(['Сохраняем модель: ', model_name]);

% Сохраняем как PNG
print(['-s' model_name], '-dpng', '-r300', '../../images/task1/model.png');
