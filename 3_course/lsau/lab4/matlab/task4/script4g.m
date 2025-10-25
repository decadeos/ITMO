t = 0:0.01:11;
g1 = 4 * ones(size(t));
g2 = t;
g3 = 0.25 * t .* t;

figure('Color', 'white', 'Position', [100, 100, 900, 400]);
hold on;

line_styles = {
    {'Color', [0.85, 0.65, 0], 'LineStyle', '-', 'LineWidth', 2.5}, % Gold
    {'Color', [0, 0.5, 0.4], 'LineStyle', '-', 'LineWidth', 2.5} % green
    {'Color', [0, 0, 0.7], 'LineStyle', '-', 'LineWidth', 2.5},  % blue
    {'Color', [0.8, 0.2, 0.2], 'LineStyle', '-', 'LineWidth', 2.5},  % red
};
plot(t, g1, line_styles{3}{:}); 
plot(t, g2, line_styles{4}{:});
plot(t, g3, line_styles{2}{:});

xlabel('Time');
ylabel('g(t)');

legendStrings = {'g_1 = 4', 'g_2 = t', 'g_3 = 0.25t^2'};
legend(legendStrings, 'Location', 'southeast', 'FontSize', 13);

ax = gca; ax.XTick = 0:1:10; 
ax.LineWidth = 1.5; ax.FontSize = 12;
ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95, 0.95, 0.95]; ax.MinorGridAlpha = 0.2;
xlim([-0.01, 7.05]); ylim([-0.1, 5.5]);
grid on; grid minor; box on; grid on;
grid on; grid minor; box on;

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../images/task4/g1.png', 'Resolution', 300);