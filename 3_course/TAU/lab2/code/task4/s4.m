clc;

A = [5 -9 -7 1;
    -9  5 -1 7;
    -7 -1  5 9;
     1  7  9 5];

B = [3; 3; 1; 3];

C = [0 1 0 0;
     0 0 1 0];

D = [4; 1];

[V, Lambda] = eig(A);
C_tilde = C * V;

Gamma = diag([-10, -15]);
Y = [3 2; 1 4];
Q = lyap(-Gamma, A, -Y*C)
disp('det([C;Q]) ='), disp(det([C;Q]))


%% Моделирование

Gamma = diag([-10 -15]);

K = place(A,B,[-3 -3+4i -3-4i -5]);

dt = 0.005;
t = 0:dt:5;

x0 = [1;1;1;1];
z0 = [0;0];

x = zeros(4,length(t));
z = zeros(2,length(t));
xhat = zeros(4,length(t));

x(:,1) = x0;
z(:,1) = z0;

for k=1:length(t)-1
    
    u = -K*x(:,k);
    y = C*x(:,k) + D*u;
    
    xdot = A*x(:,k) + B*u;
    x(:,k+1) = x(:,k) + xdot*dt;
    
    zdot = Gamma*z(:,k) - Y*y + (Q*B + Y*D)*u;
    z(:,k+1) = z(:,k) + zdot*dt;
    
    xhat(:,k) = [C;Q]\([y-D*u; z(:,k)]);
    
end

xhat(:,end) = [C;Q]\([C*x(:,end)+D*(-K*x(:,end)) - D*(-K*x(:,end)); z(:,end)]);

e = x - xhat;


colors = [0, 0.5, 0.4; 0, 0, 0.7; 0.8, 0.2, 0.2; 0.85, 0.65, 0.0];
T = 14; M = 18; L = 20;


u = zeros(1,length(t));
for k=1:length(t)
    u(k) = -K*x(:,k);
end

figure('Color','white','Position',[100 100 900 400]); hold on
plot(t, u, 'LineWidth', 2.5, 'Color', colors(2,:))

ax = gca; ax.LineWidth = 1.5; ax.FontSize = T;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];

grid on; grid minor; box on;

ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;

xlabel('$t$','Interpreter','latex','FontSize',M)
ylabel('$u(t)$','Interpreter','latex','FontSize',M)

legend('$u(t)$','Interpreter','latex','Location','northeast','FontSize',L)

set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');

exportgraphics(gcf,'../../report/images/task4/u.pdf','ContentType','vector')


%% zhat(t)

figure('Color','white','Position',[100 100 900 400]); hold on

plot(t, z(1,:), 'LineWidth', 2.5, 'Color', colors(3,:))
plot(t, z(2,:), 'LineWidth', 2.5, 'Color', colors(4,:), 'LineStyle','--')

ax = gca; ax.LineWidth = 1.5; ax.FontSize = T;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];

grid on; grid minor; box on;

ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;

xlabel('$t$','Interpreter','latex','FontSize',M)
ylabel('$\hat z(t)$','Interpreter','latex','FontSize',M)

legend('$\hat z_1$','$\hat z_2$','Interpreter','latex','Location','northeast','FontSize',L)

set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');

exportgraphics(gcf,'../../report/images/task4/z.pdf','ContentType','vector')





figure('Color','white','Position',[100 100 900 400]); hold on

plot(t, e(1,:), 'LineWidth', 2.5, 'Color', colors(3,:))
plot(t, e(2,:), 'LineWidth', 2.5, 'Color', colors(4,:), 'LineStyle','--')
plot(t, e(3,:), 'LineWidth', 2.5, 'Color', colors(1,:), 'LineStyle','-.')
plot(t, e(4,:), 'LineWidth', 2.5, 'Color', colors(2,:), 'LineStyle',':')

ax = gca; ax.LineWidth = 1.5; ax.FontSize = T;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];

grid on; grid minor; box on;

ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;

xlabel('$t$','Interpreter','latex','FontSize',M)
ylabel('$e(t)$','Interpreter','latex','FontSize',M)

legend('$e_1$','$e_2$','$e_3$','$e_4$','Interpreter','latex','Location','northeast','FontSize',L)

set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');

exportgraphics(gcf,'../../report/images/task4/e.pdf','ContentType','vector')




%% x(t) vs xhat(t)

figure('Color','white','Position',[100 100 900 400]); hold on

plot(t, x(1,:), 'LineWidth', 2.5, 'Color', colors(3,:))
plot(t, xhat(1,:), 'LineWidth', 2.5, 'Color', colors(3,:), 'LineStyle','--')

plot(t, x(2,:), 'LineWidth', 2.5, 'Color', colors(4,:))
plot(t, xhat(2,:), 'LineWidth', 2.5, 'Color', colors(4,:), 'LineStyle','--')

plot(t, x(3,:), 'LineWidth', 2.5, 'Color', colors(1,:))
plot(t, xhat(3,:), 'LineWidth', 2.5, 'Color', colors(1,:), 'LineStyle','--')

plot(t, x(4,:), 'LineWidth', 2.5, 'Color', colors(2,:))
plot(t, xhat(4,:), 'LineWidth', 2.5, 'Color', colors(2,:), 'LineStyle','--')

ax = gca; ax.LineWidth = 1.5; ax.FontSize = T;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];

grid on; grid minor; box on;

ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;

xlabel('$t$','Interpreter','latex','FontSize',M)
ylabel('$x(t),\hat x(t)$','Interpreter','latex','FontSize',M)

legend('$x_1$','$\hat x_1$','$x_2$','$\hat x_2$','$x_3$','$\hat x_3$','$x_4$','$\hat x_4$','Interpreter','latex','Location','northeast','FontSize',L, 'NumColumns', 4)

set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');

exportgraphics(gcf,'../../report/images/task4/x_compare.pdf','ContentType','vector')