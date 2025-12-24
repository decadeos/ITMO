kp = 16853/1296; ki = 1/(16853*419*10^-6);
num = [kp ki]; den = [1 0]; sys = tf(num, den);
w = logspace(-5, 3, 500);

A_theory = sqrt( kp^2 + (ki./w).^2 );
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
% exportgraphics(gcf, '../../../images/task5/freq/lach5.png', 'Resolution', 500);