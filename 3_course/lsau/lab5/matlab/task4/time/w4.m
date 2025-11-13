K = 1/71; T = sqrt(14/71);
sys = tf(1, [14 0 71]);
t = 0:0.001:7;

h_theory = (K/T) * sin(t/T);
[h_sys, t_sys] = impulse(sys, t);

figure('Position', [100 100 900 400], 'Color','white');
plot(t, h_theory, 'Color', [0, 0, 0.7], 'LineStyle', '-', 'LineWidth', 2.5); 
hold on;
plot(t_sys, h_sys, 'Color', [0.8 0.2 0.2], 'LineStyle', '--', 'LineWidth', 2.5);

ax = gca; ax.LineWidth = 1.5; ax.FontSize = 13;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
grid on; grid minor; box on; 

xlabel('Time'); ylabel('w(t)');
legend('w_{theor}', 'w_{sys}', 'Location','southeast','FontSize',15);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../../images/task4/time/w4.png', 'Resolution', 500);