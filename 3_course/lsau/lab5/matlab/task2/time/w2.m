K = 3.254; T = 0.144; xi = 0.33;
sys = tf(K, [T^2 2*xi*T 1]);
t = 0:0.001:5;

A  = K/(T*sqrt(1 - xi^2));     
wd = sqrt(1 - xi^2)/T;          
alpha = xi/T;                  
h_theory = A .* exp(-alpha*t) .* sin(wd*t);
[h_sys, t_sys] = impulse(sys, t);

figure('Position', [100 100 900 400], 'Color','white');
plot(t, h_theory, 'Color', [0, 0, 0.7], 'LineStyle', '-', 'LineWidth', 2.5); 
hold on;
plot(t_sys, h_sys, 'Color', [0.8 0.2 0.2], 'LineStyle', '--', 'LineWidth', 2.5);

ax = gca; ax.LineWidth = 1.5; ax.FontSize = 13;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
grid on; grid minor; box on; ylim([-5.5, 15]);

xlabel('Time'); ylabel('w(t)');
legend('w_{theor}', 'w_{sys}', 'Location','northeast','FontSize',15);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../../images/task2/time/w2.png', 'Resolution', 500);