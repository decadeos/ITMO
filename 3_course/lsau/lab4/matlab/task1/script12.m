a2 = 1; a1 = 1; a0 = -2;
k1 = -1.5; k0 = -15;

out = sim('model1');
% print(['-s' gcs], '-dpng', '-r300', '../../images/task1/model.png');

t = out.y.time;
y = out.y.signals.values;

figure('Color', 'white', 'Position', [100, 100, 900, 400]);

plot(t,y, ...
    'LineWidth', 2.5, ...
    'Color', [0.0, 0.0, 0.7]);

ylim([-0.2, 0.1]); xlim([0, 7.05]); 
xlabel('Time'); ylabel('Amplitude');
legend('y_{zamk}(t)', 'Location', 'northeast', 'FontSize', 15)

ax = gca; ax.XTick = 0:1:10; 
ax.LineWidth = 1.5; ax.FontSize = 12;
ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95, 0.95, 0.95]; ax.MinorGridAlpha = 0.2;
grid on; grid minor; box on; grid on;

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../images/task1/y.png', 'Resolution', 300);