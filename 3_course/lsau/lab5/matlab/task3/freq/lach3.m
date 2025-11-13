K = 1/419;
sys = tf(K, [1 0]);
w = logspace(-1, 3, 500);

A_theory = K ./ w;
A_dB = 20*log10(A_theory);

[mag, phase] = bode(sys, w);
mag = squeeze(mag);
mag_dB = 20*log10(mag);

figure('Position', [100 100 900 400], 'Color','white');
semilogx(w, A_dB,  'Color', [0.85, 0.65, 0], 'LineStyle', '-', 'LineWidth', 2.5);
hold on;
semilogx(w, mag_dB, 'Color', [0, 0.5, 0.4], 'LineStyle', '--', 'LineWidth', 2.5);

ax = gca; ax.LineWidth = 1.5; ax.FontSize = 13;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
grid on; grid minor; box on; xlim([0, 10]);

xlabel('\omega'); ylabel('L(\omega)');
legend('L_{theor}', 'L_{sys}', 'Location','northeast','FontSize',15);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../../images/task3/freq/lach3.png', 'Resolution', 500);