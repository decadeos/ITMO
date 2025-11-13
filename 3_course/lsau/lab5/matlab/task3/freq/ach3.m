K = 1/419;
sys = tf(K, [1 0]);
w = logspace(-1, 3, 1000);
A_theory = K ./ w;

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
grid on; grid minor; box on; ylim([-0.005, 0.025]); xlim([0, 10]);

xlabel('\omega'); ylabel('A(\omega)');
legend('\omega_{theor}', '\omega_{sys}', 'Location','northeast','FontSize',15);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../../images/task3/freq/ach3.png', 'Resolution', 500);