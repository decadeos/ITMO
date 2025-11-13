K = 3.254; T = 0.094;
sys = tf(K, [T 1]);
w = logspace(-1, 3, 500);

phi_theory = -atan(w*T);
[mag, phase] = bode(sys, w);
phase = squeeze(phase);
phi_deg = phi_theory * 180/pi;

figure('Position', [100 100 900 400], 'Color','white');
semilogx(w, phi_deg, 'Color', [0.85, 0.65, 0], 'LineStyle', '-', 'LineWidth', 2.5); 
hold on;
semilogx(w, phase, 'Color', [0, 0.5, 0.4], 'LineStyle', '--', 'LineWidth', 2.5);

ax = gca; ax.LineWidth = 1.5; ax.FontSize = 13;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
grid on; grid minor; box on; ylim([-95, 1]);

xlabel('\omega'); 
ylabel('φ(\omega)');
legend('φ_{theor}', 'φ_{sys}', 'Location','northeast','FontSize',15);
exportgraphics(gcf, '../../../images/task1/freq/lfch1.png', 'Resolution', 500);