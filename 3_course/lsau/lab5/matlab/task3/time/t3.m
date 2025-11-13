K = 1/419;
sys = tf(K, [1 0]);
t = 0:0.001:1;

y_theory = K * t;
[y_sys, t_sys] = step(sys, t);

figure('Position', [100 100 900 400], 'Color','white');
plot(t, y_theory, 'Color', [0, 0, 0.7], 'LineStyle', '-', 'LineWidth', 2.5); 
hold on;
plot(t_sys, y_sys, 'Color', [0.8 0.2 0.2], 'LineStyle', '--', 'LineWidth', 2.5);

ax = gca; ax.LineWidth = 1.5; ax.FontSize = 13;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
grid on; grid minor; box on; 

xlabel('Time'); ylabel('h(t)');
legend('h_{theor}', 'h_{sys}', 'Location','southeast','FontSize',15);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
% exportgraphics(gcf, '../../../images/task3/time/y3.png', 'Resolution', 500);