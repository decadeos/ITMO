K = 3.254; T = 0.144; xi = 0.33;
sys = tf(K, [T^2 2*xi*T 1]);
t = 0:0.001:5;

h_theory = K * ( ...
    1 - exp(-(xi/T) * t) .* ( ...
        cos( sqrt(1 - xi^2)/T * t ) + ...
        (xi / sqrt(1 - xi^2)) * sin( sqrt(1 - xi^2)/T * t ) ...
    ) ...
);

[y_sys, t_sys] = step(sys, t);

figure('Position', [100 100 900 400], 'Color','white');
plot(t, h_theory, 'Color', [0, 0, 0.7], 'LineStyle', '-', 'LineWidth', 2.5); 
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
exportgraphics(gcf, '../../../images/task2/time/y2.png', 'Resolution', 500);