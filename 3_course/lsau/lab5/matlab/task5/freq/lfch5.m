kp = 16853/1296; ki = 1/(16853*419*10^-6);
num = [kp ki]; den = [1 0]; sys = tf(num, den);
w = logspace(-5, 3, 500);

phi_theory = -atan( ki ./ (kp .* w) );
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
grid on; grid minor; box on; 
xlim([-0.05, 10]);ylim([-91, 1]);
yticks(-90:15:0);

xlabel('\omega'); 
ylabel('φ(\omega)');
legend('φ_{theor}', 'φ_{sys}', 'Location','northeast','FontSize',15);
exportgraphics(gcf, '../../../images/task5/freq/lfch5.png', 'Resolution', 500);