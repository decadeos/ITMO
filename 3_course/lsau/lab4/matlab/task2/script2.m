load('../task2/sim_data.mat');
% print(['-s' gcs], '-dpng', '-r300', '../../images/task2/model.png');
t_load = t; y_load = y;

a2 = 1; a1 = 1; a0 = -2;
k1 = -1.5; k0 = -15;

figure('Color', 'white', 'Position', [100, 100, 900, 400]);
hold on;

TVal = [0.1, 0.3, 0.5];

line_styles = {
    {'Color', [0, 0, 0.7], 'LineStyle', '--', 'LineWidth', 2.5},  % первый: синий пунктир
    {'Color', [0.8, 0.2, 0.2], 'LineStyle', ':', 'LineWidth', 2.5},  % второй: красный точками
    {'Color', [0, 0.5, 0.4], 'LineStyle', '-.', 'LineWidth', 2.5}     % третий: зеленый штрих-пунктир
};

plot(t_load, y_load, '-', 'Color', [0.85, 0.65, 0], 'LineWidth', 3);

for i = 1:length(TVal)
    T = TVal(i);

    assignin('base', 'T', T);
    out = sim('model2');
    t = out.y.time;
    y = out.y.signals.values;

    plot(t, y, 'LineWidth', 2.5, line_styles{i}{:});
end

xlabel('Time');
ylabel('Amplitude');

legendStrings = arrayfun(@(x) sprintf('T=%.2f', x), TVal, 'UniformOutput', false);
legendStrings = [{'Reference differentiation'}, legendStrings]; 
legend(legendStrings, 'Location', 'northeast', 'FontSize', 13);

ax = gca; ax.XTick = 0:1:50; 
ax.LineWidth = 1.5; ax.FontSize = 12;
ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95, 0.95, 0.95]; ax.MinorGridAlpha = 0.2;
grid on; grid minor; box on; grid on;
xlim([-0.01, 7.05]); ylim([-0.27, 0.3]);
% xlim([-0.01, 30.05]); ylim([-0.27, 0.3]);
grid on; grid minor; box on;

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../images/task2/yT.png', 'Resolution', 300);