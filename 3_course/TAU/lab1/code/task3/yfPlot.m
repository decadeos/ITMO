A = [-9 0 -10;
     -4 -1 -6;
      6 -2 5];

C = [2 -1 2]; 
t1 = 3;

f = @(t) -3*exp(-3*t).*cos(2*t) - 2*exp(-3*t).*sin(2*t);

% Определите Q (пример - возможно, нужно другое выражение)
Q = obsv(A, C);  % или gram(A, C) и т.д.

% Вычисление интеграла
I = integral(@(t) expm(A'*t)*C'*f(t), 0, t1, 'ArrayValued', true);
x0 = inv(Q)*I;

% Решение ОДУ
tspan = linspace(0, t1, 1000);
[t, x] = ode45(@(t, x) A*x, tspan, x0);

% Вычисление выхода
y = (C*x')';
y_ref = f(t);

% Параметры оформления
colors = lines(7);
T = 12; M = 14; L = 12;

% График y(t) и f(t)
figure('Color','white','Position',[100 100 900 400]); hold on
plot(t, y, 'LineWidth', 2.5, 'Color', colors(2,:))
plot(t, y_ref, '--', 'LineWidth', 2.5, 'Color', colors(3,:))

ax = gca; 
ax.LineWidth = 1.5; 
ax.FontSize = T; 
ax.XColor = [0.3 0.3 0.3]; 
ax.YColor = [0.3 0.3 0.3];
grid on; grid minor; box on; 
% xlim([-0.01 3.01]); 
% ylim([-1.5 3.1])
ax.GridColor = [0.9 0.9 0.9];
ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95];
ax.MinorGridAlpha = 0.2;

xlabel('$t$','Interpreter','latex','FontSize',M)
ylabel('$y(t)$','Interpreter','latex','FontSize',M)
legend('$y(t)$','$f(t)$', 'Interpreter','latex', 'Location','northeast', 'FontSize',L);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');

% График ошибки
e = y - y_ref;

figure('Color','white','Position',[100 100 900 350]); hold on
plot(t, e, 'LineWidth', 2.5, 'Color', colors(1,:))

ax = gca; 
ax.LineWidth = 1.5; 
ax.FontSize = T; 
ax.XColor = [0.3 0.3 0.3]; 
ax.YColor = [0.3 0.3 0.3];
grid on; grid minor; box on; 
% xlim([-0.01 3.01]); 
% ylim([-3.1e-3 3.1e-3]);
ax.GridColor = [0.9 0.9 0.9];
ax.GridAlpha = 0.4; 
ax.YAxis.Exponent = -3;
ax.MinorGridColor = [0.95 0.95 0.95];
ax.MinorGridAlpha = 0.2;

xlabel('$t$','Interpreter','latex','FontSize',M)
ylabel('$e(t)\times10^{-3}$','Interpreter','latex')
legend('$e(t)=y(t)-f(t)$', 'Interpreter','latex', 'Location','northeast', 'FontSize',L);

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');