K = 3.254; T = 0.144; xi = 0.33;
sys = tf(K, [T^2 2*xi*T 1]);
w = logspace(-1, 3, 500);

a = zeros(size(w));
a(w > 1/T) = 1;
phi_theory = -a*pi - atan( (2*xi*T.*w) ./ (1 - (w*T).^2) );
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

xlabel('\omega'); 
ylabel('φ(\omega)');
legend('φ_{theor}', 'φ_{sys}', 'Location','northeast','FontSize',15);
exportgraphics(gcf, '../../../images/task2/freq/lfch2.png', 'Resolution', 500);