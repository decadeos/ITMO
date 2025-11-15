figure('Position', [100 100 900 400], 'Color','white');
fplot(@(x) 0.5,[-2 -1], 'Color', [0.8 0.2 0.2], 'LineStyle', '-', 'LineWidth', 2.5) hold on
fplot(@(x) -x-0.5,[-1 1.5], 'Color', [0.8 0.2 0.2], 'LineStyle', '-', 'LineWidth', 2.5)
fplot(@(x) x-3.5,[1.5 4], 'Color', [0.8 0.2 0.2], 'LineStyle', '-', 'LineWidth', 2.5)

ax = gca; ax.LineWidth = 1.5; ax.FontSize = 13;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
grid on; grid minor; box on; ylim([-2.5, 1])

xlabel('t'); ylabel('x(t)');
legend('x(t)', 'Location','northeast','FontSize',15);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../images/task1/lines.png', 'Resolution', 500);