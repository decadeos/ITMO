A = [-13 -36 -8;
      6  15  2;
     -2  -8 -3];

C = [0 4 4];
t1 = 3;
f = @(t) exp(-t).*cos(4*t) + 3*exp(-t).*sin(4*t);

Q = integral(@(t) expm(A'*t)*C'*C*expm(A*t), 0, t1, 'ArrayValued', true);

I = integral(@(t) expm(A'*t)*C'*f(t), 0, t1, 'ArrayValued', true);
x0 = pinv(Q) * I;
C = [0 4 4];

I = integral(@(t) expm(A'*t)*C'*f(t), 0, t1, 'ArrayValued', true);
x0 = pinv(Q) * I;

tspan = linspace(0, t1, 1000);
[t, x] = ode45(@(t,x) A*x, tspan, x0);

y = (C * x')';
y_ref = f(t);

figure('Color','white','Position',[100 100 900 400]); hold on

plot(t, y,     'LineWidth', 2.5, 'Color', colors(2,:))
plot(t, y_ref, '--', 'LineWidth', 2.5, 'Color', colors(3,:))

ax = gca; ax.LineWidth = 1.5; ax.FontSize = T; ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
grid on; grid minor; box on; xlim([-0.01 3.01]); ylim([-1.5, 3.1])
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', M)
ylabel('$y(t)$', 'Interpreter', 'latex', 'FontSize', M)
legend('$y(t)$', '$f(t)$', 'Interpreter', 'latex', 'Location', 'northeast', 'FontSize', L);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf,'../../report/images/task4/uf.pdf','ContentType','vector')

% --- ошибка e(t) ---
e = y - y_ref;

figure('Color','white','Position',[100 100 900 350]); hold on
plot(t, e, 'LineWidth', 2.5, 'Color', colors(1,:))

ax = gca; ax.LineWidth = 1.5; ax.FontSize  = T; ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
grid on; grid minor; box on; xlim([-0.01 3.01]); ylim([-3.4*10^-3; 4.2*10^-3]);
ax.GridColor = [0.9 0.9 0.9];ax.GridAlpha = 0.4; ax.YAxis.Exponent = -3;
ax.MinorGridColor = [0.95 0.95 0.95];ax.MinorGridAlpha = 0.2;

xlabel('$t$','Interpreter','latex','FontSize',M)
ylabel('$e(t)\times10^{-3}$','Interpreter','latex')
legend('$e(t)=y(t)-f(t)$', 'Interpreter','latex', 'Location','northeast', 'FontSize',L);

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf,'../../report/images/task4/e.pdf','ContentType','vector')