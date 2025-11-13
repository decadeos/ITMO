K = 1/71; T = sqrt(14/71);
sys = tf(1, [14 0 71]);
w = logspace(-1, 3, 500);

phi_theory = zeros(size(w));
phi_theory(w > 1/T) = -pi;  
[mag, phase] = bode(sys, w);
phase = squeeze(phase);
phi_deg = phi_theory * 180/pi;

figure('Position', [100 100 900 400], 'Color','white');
plot(w, phi_deg, 'Color', [0.85, 0.65, 0], 'LineStyle', '-', 'LineWidth', 2.5); 
hold on;
plot(w, phase, 'Color', [0, 0.5, 0.4], 'LineStyle', '--', 'LineWidth', 2.5);

ax = gca; ax.LineWidth = 1.5; ax.FontSize = 13;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
grid on; grid minor; box on; xlim([-0.01, 10]); ylim([-190, 10])

xlabel('\omega'); 
ylabel('φ(\omega)');
legend('φ_{theor}', 'φ_{sys}', 'Location','northeast','FontSize',15);
exportgraphics(gcf, '../../../images/task4/freq/fch4.png', 'Resolution', 500);