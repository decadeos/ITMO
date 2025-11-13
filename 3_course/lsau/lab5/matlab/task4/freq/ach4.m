K = 1/71; T = sqrt(14/71);
sys = tf(1, [14 0 71]);

w = 0:0.01:10;
A_theory = K ./ abs(1-w.^2*T^2);

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
grid on; grid minor; box on; xlim([-0.1, 10]); ylim([-0.1, 8.1]);

xlabel('\omega'); ylabel('A(\omega)');
legend('\omega_{theor}', '\omega_{sys}', 'Location','northeast','FontSize',15);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../../images/task4/freq/ach4.png', 'Resolution', 500);