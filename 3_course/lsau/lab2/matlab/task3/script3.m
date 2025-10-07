% --- Исходные данные ---
A = [  0  4   0   0;
      -4  0   0   0;
       0  0  -8   5;
       0  0  -5  -8 ];

x0 = [1; 0; 1; 0];
C = [1 0 1 0];

% Временной вектор
t = linspace(0, 10, 1000);

% Предвыделение массива для результата
g_output = zeros(size(t));

% Вычисление g(t) = C * expm(A * t) * x0
for i = 1:length(t)
    g_output(i) = C * expm(A * t(i)) * x0;
end

% --- Заданный желаемый сигнал ---
g_desired = cos(4 * t) + exp(-8 * t) .* cos(5 * t);

% --- График g(t) и gж(t)
figure('Color', 'white', 'Position', [100, 100, 1100, 400]);

plot(t, g_output, 'LineWidth', 2.5, 'Color', [0, 0, 0.65]);
hold on
plot(t, g_desired, '--', 'LineWidth', 2.5, 'Color', [0.8, 0.2, 0.2]);
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

legend({'$g(t)$', '$g_{\mathrm{*}}(t)$'}, ...
    'Interpreter', 'latex', ...
    'FontSize', 15, ...
    'Location', 'northeast');

box on;

exportgraphics(gcf, '../../images/task3/g.png', 'Resolution', 300);

% --- График ошибки
e = g_desired - g_output;

figure('Color', 'white', 'Position', [100, 100, 1100, 400]);

plot(t, e, 'LineWidth', 2.5, 'Color', [0.3, 0.3, 0.3]);

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
ylabel('Error', 'FontSize', 15, 'FontWeight', 'normal');

legend({'$e = g_{\mathrm{*}}(t) - g(t)$'}, ...
    'Interpreter', 'latex', ...
    'Location', 'northeast', ...
    'FontSize', 15);

box on;

exportgraphics(gcf, '../../images/task3/e.png', 'Resolution', 300);


