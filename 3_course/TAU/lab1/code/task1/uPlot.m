A = [5 -2 8; 4 -3 4; -4 0 -7];
B = [-7; -5; 7];
x1 = [-2; -3; 3];
t1 = 3;

P = integral(@(t) expm(A*t)*B*B'*expm(A'*t), 0, t1, 'ArrayValued', true);
u = @(t) B' * expm(A'*(t1-t)) * inv(P) * x1;
opts = odeset('MaxStep', 0.01);
[t, x] = ode45(@(t,x) A*x + B*u(t), [0 t1], zeros(3,1), opts);
u_vals = arrayfun(@(ti) u(ti), t);

colors = [0, 0.5, 0.4; 0, 0, 0.7; 0.8, 0.2, 0.2];
M = 15; L = 20; T = 13;

% --- x(t) ---
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
xline(t1, '--k', 'LineWidth', 1.5)
xlabel('$t$', 'Interpreter','latex', 'FontSize', M)
ylabel('$x(t)$', 'Interpreter','latex', 'FontSize', M)
legend('$x_1(t)$','$x_2(t)$','$x_3(t)$', ...
    'Interpreter','latex','Location','northwest','FontSize', L, 'NumColumns', 3);
xlim([-0.01; 3.1]);

% Линии:
yline(x1(1), '--', 'LineWidth', 1, 'Color', colors(1,:), 'HandleVisibility','off')
yline(x1(2), '--', 'LineWidth', 1, 'Color', colors(2,:), 'HandleVisibility','off')
yline(x1(3), '--', 'LineWidth', 1, 'Color', colors(3,:), 'HandleVisibility','off')
xline(t1, '--', 'LineWidth', 1, 'Color', [0.7 0.7 0.7], 'HandleVisibility','off')

% Подписи
text(-0.05, x1(1)+0.3, '$-2$', 'Interpreter','latex', 'FontSize', 16, 'Color', colors(1,:), 'HorizontalAlignment','right')
text(-0.05, x1(2)-0.4, '$-3$', 'Interpreter','latex', 'FontSize', 16, 'Color', colors(2,:), 'HorizontalAlignment','right')
text(-0.05, x1(3), '$3$',  'Interpreter','latex', 'FontSize', 16, 'Color', colors(3,:), 'HorizontalAlignment','right')


set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf,'../../report/images/task1/x.pdf','ContentType','vector')


% --- u(t) ---
% figure('Color', 'white', 'Position', [100, 100, 900, 400]);
% plot(t, u_vals, 'LineWidth', 2.5, 'Color', [0.8 0.2 0.2])
% ax = gca; ax.LineWidth = 1.5; ax.FontSize = T;
% ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
% grid on; grid minor; box on;
% ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
% ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
% xlabel('$t$', 'Interpreter','latex', 'FontSize', M)
% ylabel('$u(t)$', 'Interpreter','latex', 'FontSize', M)
% legend('$u(t)$','Interpreter','latex','Location','northwest','FontSize', L)
% xlim([-0.01; 3.01]);
% 
% set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
% exportgraphics(gcf,'../../report/images/task1/u.pdf','ContentType','vector')
