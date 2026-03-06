clc;
%% Инициализация
A = [8  1  11; 4  0  4 ; -4 -3  -7;];
B = [-1; -3; 3];

%% Жордан
[P, J] = jordan(sym(A)); P = double(P); J = double(J);
[P_real, J_real] = cdf2rdf(P, J);
B_tilde = inv(P_real) * B;

%% Синтез регулятора K

% 1 (Сильвестр)
A2 = J_real(2:3, 2:3);
B2 = B_tilde(2:3);
G = [ -3 1;
      0 -3];
Y = [1 2];
P = lyap(A2, -G, -B2*Y);
K2 = -Y * P^-1;
K = [0 K2] * P_real^-1;
z = A + B*K; eig(z);

% 2 Модальное управление
% Uc = ctrb(A2, B2);
% a = poly(A2);
% A_up = [ 0 1; -a(3) -a(2) ];
% B_up = [0;1];
% Uc_star = ctrb(A_up, B_up);
% P_up = Uc_star / Uc;
% K_up = [-8992 -334];
% K2 = K_up * P_up;
% K = [0 K2] * P_real^-1;
% z = A + B*K; eig(z);

% 3 Аккерман / Басса-Гур
% D_star = [1, 6, 90];   
% a_bar = D_star(2:end) - a(2:end);  
% Aa = [1, a(2); 0,  1];  
% K2 = -a_bar * inv(Aa) * inv(Uc);
% K = [0 K2] * P_real^-1;
% z = A + B*K;
% eig(z);

%% Моделирование
% load_system('model1');
% print('-smodel1', '-dpng', '-r300', '../../report/images/task1/model1.png');

%% Графики

% 1 (Сильвестр)
colors = [0, 0.5, 0.4; 0, 0, 0.7; 0.8, 0.2, 0.2; 0.85, 0.65, 0.0];
T = 14; M = 18; L = 20;

x0 = [1; 1; 1];
t = linspace(0,5,1000);
[t, x1] = ode45(@(t,x) z*x, t, x0);
u1 = (K*x1')';

% --- x(t) ---
figure('Color','white','Position',[100 100 900 400]); hold on
plot(t, x1(:,1), 'LineWidth', 2.5, 'Color', colors(3,:))
plot(t, x1(:,2), 'LineWidth', 2.5, 'Color', colors(4,:), 'LineStyle','--')
plot(t, x1(:,3), 'LineWidth', 2.5, 'Color', colors(1,:), 'LineStyle','-.')
ax = gca; ax.LineWidth = 1.5; ax.FontSize = T; ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
grid on; grid minor; box on;
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
xlabel('$t$','Interpreter','latex','FontSize',M)
ylabel('$x(t)$','Interpreter','latex','FontSize',M)
xlim([-0.01; 5.01]); ylim([-4.3; 4.3]);
legend('$x_1$','$x_2$','$x_3$','Interpreter','latex','Location','northeast','FontSize',L)
set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');
exportgraphics(gcf,'../../report/images/task1/x1.pdf','ContentType','vector')

% --- u(t) ---
figure('Color','white','Position',[100 100 900 400]); hold on
plot(t, u1, 'LineWidth', 2.5, 'Color', colors(2,:))
ax = gca; ax.LineWidth = 1.5; ax.FontSize = T; ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
grid on; grid minor; box on;
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
xlabel('$t$','Interpreter','latex','FontSize',M)
ylabel('$u(t)$','Interpreter','latex','FontSize',M)
legend('$u(t)$','Interpreter','latex','Location','northeast','FontSize',L)
xlim([-0.01; 5.01]); ylim([-6.01; 2.3]);
set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');
exportgraphics(gcf,'../../report/images/task1/u1.pdf','ContentType','vector')

% 2 (Метода модального управления)
% colors = [0, 0.5, 0.4; 0, 0, 0.7; 0.8, 0.2, 0.2; 0.85, 0.65, 0.0];
% T = 14; M = 18; L = 20;
% 
% x0 = [1; 1; 1];
% t = linspace(0,5,1000);
% [t, x2] = ode45(@(t,x) z*x, t, x0);
% u2 = (K*x2')';
% 
% % --- x(t) ---
% figure('Color','white','Position',[100 100 900 400]); hold on
% plot(t, x2(:,1), 'LineWidth', 2.5, 'Color', colors(3,:))
% plot(t, x2(:,2), 'LineWidth', 2.5, 'Color', colors(4,:), 'LineStyle','--')
% plot(t, x2(:,3), 'LineWidth', 2.5, 'Color', colors(1,:), 'LineStyle','-.')
% ax = gca; ax.LineWidth = 1.5; ax.FontSize = T; ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
% grid on; grid minor; box on;
% ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
% ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
% xlabel('$t$','Interpreter','latex','FontSize',M)
% ylabel('$x(t)$','Interpreter','latex','FontSize',M)
% xlim([-0.0051; 2.0051]); ylim([-12; 13]);
% legend('$x_1$','$x_2$','$x_3$','Interpreter','latex','Location','northeast','FontSize',L, 'NumColumns', 3)
% set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');
% exportgraphics(gcf,'../../report/images/task1/x2.pdf','ContentType','vector')
% 
% % --- u(t) ---
% figure('Color','white','Position',[100 100 900 400]); hold on
% plot(t, u2, 'LineWidth', 2.5, 'Color', colors(2,:))
% ax = gca; ax.LineWidth = 1.5; ax.FontSize = T; ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
% grid on; grid minor; box on;
% ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
% ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
% xlabel('$t$','Interpreter','latex','FontSize',M)
% ylabel('$u(t)$','Interpreter','latex','FontSize',M)
% xlim([-0.0051; 2.0051]); ylim([-30; 90]);
% legend('$u(t)$','Interpreter','latex','Location','northeast','FontSize',L)
% set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');
% exportgraphics(gcf,'../../report/images/task1/u2.pdf','ContentType','vector')


% 3 (Басса-Гур)
% colors = [0, 0.5, 0.4; 0, 0, 0.7; 0.8, 0.2, 0.2; 0.85, 0.65, 0.0];
% T = 14; M = 18; L = 20;
% 
% x0 = [1; 1; 1];
% t = linspace(0,5,1000);
% [t, x3] = ode45(@(t,x) z*x, t, x0);
% u3 = (K*x3')';
% 
% % --- x(t) ---
% figure('Color','white','Position',[100 100 900 400]); hold on
% plot(t, x3(:,1), 'LineWidth', 2.5, 'Color', colors(3,:))
% plot(t, x3(:,2), 'LineWidth', 2.5, 'Color', colors(4,:), 'LineStyle','--')
% plot(t, x3(:,3), 'LineWidth', 2.5, 'Color', colors(1,:), 'LineStyle','-.')
% ax = gca; ax.LineWidth = 1.5; ax.FontSize = T; ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
% grid on; grid minor; box on;
% ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
% ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
% xlabel('$t$','Interpreter','latex','FontSize',M)
% ylabel('$x(t)$','Interpreter','latex','FontSize',M)
% xlim([-0.01; 2.01]);
% legend('$x_1$','$x_2$','$x_3$','Interpreter','latex','Location','northeast','FontSize',L)
% set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');
% exportgraphics(gcf,'../../report/images/task1/x3.pdf','ContentType','vector')
% 
% % --- u(t) ---
% figure('Color','white','Position',[100 100 900 400]); hold on
% plot(t, u3, 'LineWidth', 2.5, 'Color', colors(2,:))
% ax = gca; ax.LineWidth = 1.5; ax.FontSize = T; ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
% grid on; grid minor; box on;
% ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
% ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
% xlabel('$t$','Interpreter','latex','FontSize',M)
% ylabel('$u(t)$','Interpreter','latex','FontSize',M)
% xlim([-0.01; 2.01]);
% legend('$u(t)$','Interpreter','latex','Location','northeast','FontSize',L)
% set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');
% exportgraphics(gcf,'../../report/images/task1/u3.pdf','ContentType','vector')

% u(t)
% colors = [0, 0.5, 0.4;
%           0.85, 0.65, 0.0;
%           0.8, 0.2, 0.2];
% T = 14; M = 18; L = 20;
% figure('Color','white','Position',[100 100 900 400]); hold on
% plot(t, u1, 'LineWidth',2.5,'Color',colors(1,:),'LineStyle','--')
% plot(t, u2, 'LineWidth',2.5,'Color',colors(2,:),'LineStyle','-')
% plot(t, u3, 'LineWidth',2.5,'Color',colors(3,:),'LineStyle','-.')
% ax = gca;
% ax.LineWidth = 1.5;
% ax.FontSize = T;
% ax.XColor = [0.3 0.3 0.3];
% ax.YColor = [0.3 0.3 0.3];
% grid on; grid minor; box on;
% ax.GridColor = [0.9 0.9 0.9];
% ax.GridAlpha = 0.4;
% ax.MinorGridColor = [0.95 0.95 0.95];
% ax.MinorGridAlpha = 0.2;
% 
% xlabel('$t$','Interpreter','latex','FontSize',M)
% ylabel('$u(t)$','Interpreter','latex','FontSize',M)
% 
% legend('$u_1(t):\{-3,-3,-3\}$', ...
%        '$u_2(t):\{-3,-30,-300\}$', ...
%        '$u_3(t):\{-3,-3\pm9i\}$', ...
%        'Interpreter','latex','Location','northeast','FontSize',L)
% 
% ylim([-30 90]); xlim([-0.01; 2])
% 
% set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');
% exportgraphics(gcf,'../../report/images/task1/u123.pdf','ContentType','vector')