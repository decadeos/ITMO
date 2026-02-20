colors = [0, 0.5, 0.4; 0, 0, 0.7; 0.8, 0.2, 0.2];
M = 15; L = 20; T = 13;

% График x(t)
figure('Color', 'white', 'Position', [100, 100, 900, 400]);
hold on
for i = 1:3
    plot(t, x(:,i), 'LineWidth', 2.5, 'Color', colors(i,:))
end
ax = gca; ax.LineWidth = 1.5; ax.FontSize = T;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
grid on; grid minor; box on;
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
xlabel('$t$', 'Interpreter','latex', 'FontSize', M)
ylabel('$x(t)$', 'Interpreter','latex', 'FontSize', M)
legend('$x_1(t)$','$x_2(t)$','$x_3(t)$', 'Interpreter','latex','Location','northwest','FontSize', L, 'NumColumns', 3);
xlim([-0.01; 3.1]);ylim([-6; 4.7]);
yline(x1(1), '--', 'LineWidth', 1, 'Color', colors(1,:), 'HandleVisibility','off')
yline(x1(2), '--', 'LineWidth', 1, 'Color', colors(2,:), 'HandleVisibility','off')
yline(x1(3), '--', 'LineWidth', 1, 'Color', colors(3,:), 'HandleVisibility','off')
xline(t1, '--', 'LineWidth', 1, 'Color', [0.7 0.7 0.7], 'HandleVisibility','off')
text(-0.05, x1(2), '$-3$', 'Interpreter','latex', 'FontSize', 16, 'Color', colors(2,:), 'HorizontalAlignment','right')
text(-0.05, x1(3), '$3$',  'Interpreter','latex', 'FontSize', 16, 'Color', colors(3,:), 'HorizontalAlignment','right')
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf,'../../report/images/task2/x.pdf','ContentType','vector')

% График u(t)
figure('Color', 'white', 'Position', [100, 100, 900, 400]);
plot(t, u_vals, 'LineWidth', 2.5, 'Color', [0.8 0.2 0.2])
ax = gca; ax.LineWidth = 1.5; ax.FontSize = T;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
grid on; grid minor; box on;
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
xlabel('$t$', 'Interpreter','latex', 'FontSize', M)
ylabel('$u(t)$', 'Interpreter','latex', 'FontSize', M)
legend('$u(t)$','Interpreter','latex','Location','northwest','FontSize', L)
xlim([-0.01; 3.01]);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf,'../../report/images/task2/u.pdf','ContentType','vector')