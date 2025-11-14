K = 3.254; T = 0.094;
sys = tf(K, [T 1]);
w = logspace(-1, 3, 500);
A_theory = K ./ sqrt(1 + (w*T).^2);

[mag, phase] = bode(sys, w);
mag = squeeze(mag);

figure('Position', [100 100 900 400], 'Color','white');
plot(w, A_theory,  'Color', [0.85, 0.65, 0], 'LineStyle', '-', 'LineWidth', 2.5);
hold on;
plot(w, mag, 'Color', [0, 0.5, 0.4], 'LineStyle', '--', 'LineWidth', 2.5);

ax = gca; ax.LineWidth = 1.5; ax.FontSize = 13;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
grid on; grid minor; box on; ylim([-0.1, 3.5]);

xlabel('\omega'); ylabel('A(\omega)');
legend('A_{theor}', 'A_{sys}', 'Location','northeast','FontSize',15);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../../images/task1/freq/ach1.png', 'Resolution', 500);