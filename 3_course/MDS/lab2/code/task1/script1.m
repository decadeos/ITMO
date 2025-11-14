% syms x y
% eq1 = -3*x + y == 0;
% eq2 = x - 4*y - atan(2*y) == 0;
% 
% sol = vpasolve([eq1, eq2], [x, y], [0, 0]);
% sol.x
% sol.y

A = [-3 1;
      1 -6];
% 
% lambda = eig(A)


f = @(t, X)[
    -3*X(1) + X(2);              % x'
     X(1) - 4*X(2) - atan(2*X(2)) % y'
];

lin = @(t, X) A*X;

tspan = [0 5];
X0 = [-5; 30];    % начальные условия

[t1, Xnl] = ode45(f,  tspan, X0);   % нелинейная система
[t2, Xlin] = ode45(lin, tspan, X0); % линеаризованная система

figure('Position', [100 100 900 500], 'Color','white');
plot(t2, Xlin(:,1), 'Color', [0, 0, 0.7], 'LineStyle', '-', 'LineWidth', 3.5); hold on;
plot(t2, Xlin(:,2), 'Color', [0.8 0.2 0.2], 'LineStyle', '--', 'LineWidth', 3.5);

ax = gca; ax.LineWidth = 1.5; ax.FontSize = 20;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
grid on; grid minor; box on; 

xlabel('Time'); ylabel('State variable');
legend('x', 'y', fontsize = 22);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../images/task1/lin.png', 'Resolution', 500);

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

figure('Position', [100 100 900 500], 'Color','white');
plot(t1, Xnl(:,1), 'Color', [0, 0, 0.7], 'LineStyle', '-', 'LineWidth', 3.5); hold on;
plot(t1, Xnl(:,2), 'Color', [0.8 0.2 0.2], 'LineStyle', '--', 'LineWidth', 3.5);

ax = gca; ax.LineWidth = 1.5; ax.FontSize = 20;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
grid on; grid minor; box on; 

xlabel('Time'); ylabel('State variable');
legend('x', 'y', fontsize = 22);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../images/task1/non-lin.png', 'Resolution', 500);
