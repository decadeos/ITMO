kVal = [150, 40, 7, 3];
t = 0:0.01:10;
g = [t' t'];   

figure('Color', 'white', 'Position', [100, 100, 900, 400]);
hold on;

line_styles = {
    {'Color', [0.85, 0.65, 0], 'LineStyle', '-', 'LineWidth', 2.5}, % Gold
    {'Color', [0, 0.5, 0.4], 'LineStyle', '-', 'LineWidth', 2.5} % green
    {'Color', [0, 0, 0.7], 'LineStyle', '-', 'LineWidth', 2.5},  % blue
    {'Color', [0.8, 0.2, 0.2], 'LineStyle', '-', 'LineWidth', 2.5},  % red
};

plot(t, t, ':', 'LineWidth', 2.5, 'Color', [0.3, 0.3, 0.3]);

for i = 1:length(kVal)
    k = kVal(i);
    assignin('base', 'k', k);
    out = sim('model31');

    t = out.y.time;
    y = out.y.signals.values;

    plot(t, y, line_styles{i}{:});
end

xlabel('Time');
ylabel('y(t)');

legendStrings = arrayfun(@(i) sprintf('k_{%d} = %.0f', i, kVal(i)), 1:length(kVal), 'UniformOutput', false);
legendStrings = [{'g_{2} = t'}, legendStrings]; 
legend(legendStrings, 'Location', 'northwest', 'FontSize', 13, 'NumColumns', 1);


ax = gca; ax.XTick = 0:1:10; 
ax.LineWidth = 1.5; ax.FontSize = 12;
ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95, 0.95, 0.95]; ax.MinorGridAlpha = 0.2;
xlim([-0.01, 4.05]); ylim([-0.1, 3.5]);
grid on; grid minor; box on; grid on;
grid on; grid minor; box on;

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../images/task3/y2.png', 'Resolution', 300);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Color', 'white', 'Position', [100, 100, 900, 400]);
hold on;

for i = 1:length(kVal)
    k = kVal(i);
    assignin('base', 'k', k);
    out = sim('model31');

    t = out.e.time;
    e = out.e.signals.values;
    plot(t, e, line_styles{i}{:});
end

xlabel('Time');
ylabel('e(t)');

legendStrings = cell(length(kVal), 1);
for i = 1:length(kVal)
    legendStrings{i} = sprintf('e_{%d}', i);
end
legend(legendStrings, 'Location', 'northwest', 'FontSize', 13, 'NumColumns', 1);

ax = gca; ax.XTick = 0:1:10; 
ax.LineWidth = 1.5; ax.FontSize = 12;
ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95, 0.95, 0.95]; ax.MinorGridAlpha = 0.2;
xlim([-0.01, 4.05]); ylim([-0.1, 1.55]);
grid on; grid minor; box on; grid on;
grid on; grid minor; box on;

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../images/task3/e2.png', 'Resolution', 300);