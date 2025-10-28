t = 0:0.01:40;
g2 = t;
g4 = 4 * sin(0.25 * t);

figure('Color', 'white', 'Position', [100, 100, 900, 400]);
hold on;

line_styles = {
    {'Color', [0.85, 0.65, 0], 'LineStyle', '-', 'LineWidth', 2.5}, % Gold
    {'Color', [0, 0.5, 0.4], 'LineStyle', '-', 'LineWidth', 2.5} % green
    {'Color', [0, 0, 0.7], 'LineStyle', '-', 'LineWidth', 2.5},  % blue
    {'Color', [0.8, 0.2, 0.2], 'LineStyle', '-', 'LineWidth', 2.5},  % red
};

plot(t, g2, line_styles{4}{:});
plot(t, g4, line_styles{1}{:});

xlabel('Time');
ylabel('g(t)');

legendStrings = {'g_2 = t', 'g_4 = 4 sin(0.25t)'};
legend(legendStrings, 'Location', 'east', 'FontSize', 13);

ax = gca;
ax.LineWidth = 1.5; ax.FontSize = 12;
ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95, 0.95, 0.95]; ax.MinorGridAlpha = 0.2;
% xlim([-0.01, 7.05]); ylim([-0.1, 5.5]);
grid on; grid minor; box on; grid on;
grid on; grid minor; box on;

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../images/task5/g1.png', 'Resolution', 300);