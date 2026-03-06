clc; clear all;

%% INIT
A = [ 5  -9  -7   1;
     -9   5  -1   7;
     -7  -1   5   9;
      1   7   9   5];
B = [3; 3; 1; 3];
C = [ 2  -2   2   2;
     -2   4   2   4];
D = [4; 1];

%% JORDAN BASIS
[V, Lambda] = eig(A);
A_tilde = inv(V) * A * V;
C_tilde = C * V;


%% K
D_star = [1, 14, 88, 290, 375];
a = poly(A);
a_bar = D_star(2:end) - a(2:end);
Aa = [1,    a(2), a(3), a(4);
      0,    1,    a(2), a(3);
      0,    0,    1,    a(2);
      0,    0,    0,    1  ];
Uc = ctrb(A, B);
K = -a_bar * inv(Aa) * inv(Uc);

disp(eig(A + B*K))
%% REMOVE UNOBSERVABLE MODE
[~, idx] = min(vecnorm(C_tilde));
obs_idx = setdiff(1:4, idx);

A_c = diag(diag(Lambda(obs_idx, obs_idx)));
C_c = C_tilde(:, obs_idx);

%% OBSERVER POLES
desired_poles = [-5, -10, -15];
L_c = place(A_c', C_c', desired_poles)';

%% BACK TO ORIGINAL BASIS
L_tilde = zeros(4, 2);
L_tilde(obs_idx, :) = L_c;
L = V * L_tilde;

disp(L);
disp(eig(A - L*C));

F = [A+B*K,   -B*K;
     zeros(4),  A-L*C];

x0  = [1; 1; 1; 1];
xh0 = [0; 0; 0; 0];

[t, Z] = ode45(@(t,z) dynamics(z, A, B, C, K, L), [0 8], [x0; xh0]);

X  = Z(:, 1:4);   
Xh = Z(:, 5:8);
E  = X - Xh;
U  = (K * Xh')';
Y  = (C * X')';

function dzdt = dynamics(z, A, B, C, K, L)
    x  = z(1:4);
    xh = z(5:8);
    u  = K * xh;
    dx  = A*x  + B*u;
    dxh = A*xh + B*u + L*(C*x - C*xh);
    dzdt = [dx; dxh];
end

Te = 14; M = 18; Le = 20;
colors = [0.85, 0.65, 0.0; 0, 0, 0.7; 0.8, 0.2, 0.2; 0.85, 0.65, 0.0];

%% Figure 1 — x(t) и x̂(t)
% figure('Color','white','Position',[100 100 500 900]);
% for i = 1:4
%     subplot(4,1,i); hold on
%     plot(t, X(:,i),  'LineWidth', 2.5, 'Color', colors(4,:), 'LineStyle','-')
%     plot(t, Xh(:,i), 'LineWidth', 2.5, 'Color', colors(1,:), 'LineStyle','--')
%     ax = gca; ax.LineWidth = 1.5; ax.FontSize = Te;
%     ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
%     grid on; grid minor; box on;
%     ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
%     ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
%     ylabel(sprintf('$x_%d(t)$', i), 'Interpreter','latex','FontSize',M)
%     legend(sprintf('$x_%d$',i), sprintf('$\\hat{x}_%d$',i), ...
%         'Interpreter','latex','Location','northeast','FontSize',Le,'NumColumns',2)
%     xlim([-0.01 7]); ylim([-255, 130]);
%     if i == 4
%         xlabel('$t$','Interpreter','latex','FontSize',M)
%     end
%     set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');
% end
% exportgraphics(gcf,'../../report/images/task3/x.pdf','ContentType','vector')
% 
% %% Figure 2 — e(t)
% figure('Color','white','Position',[700 100 500 900]);
% for i = 1:4
%     subplot(4,1,i); hold on
%     plot(t, E(:,i), 'LineWidth', 2.5, 'Color', colors(3,:))
%     ax = gca; ax.LineWidth = 1.5; ax.FontSize = Te;
%     ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
%     grid on; grid minor; box on;
%     ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
%     ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
%     ylabel(sprintf('$e_%d(t)$', i), 'Interpreter','latex','FontSize',M)
%     legend(sprintf('$e_%d = x_%d - \\hat{x}_%d$', i, i, i), ...
%         'Interpreter','latex','Location','northeast','FontSize',Le)
%     xlim([-0.01 7]); ylim([-2, 2.5]);
%     if i == 4
%         xlabel('$t$','Interpreter','latex','FontSize',M)
%     end
%     set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');
% end
% exportgraphics(gcf,'../../report/images/task3/e.pdf','ContentType','vector')

%% Figure 3 — u(t)
figure('Color','white','Position',[1300 100 900 400]);
hold on
plot(t, U, 'LineWidth', 2.5, 'Color', colors(3,:))
ax = gca; ax.LineWidth = 1.5; ax.FontSize = Te;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
grid on; grid minor; box on;
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
ylabel('$u(t)$','Interpreter','latex','FontSize',M)
xlabel('$t$','Interpreter','latex','FontSize',M)
xlim([-0.01 7]);
legend('$u(t)$','Interpreter','latex','Location','northeast','FontSize',Le)
set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');
exportgraphics(gcf,'../../report/images/task3/u.pdf','ContentType','vector')

%% Figure 4 — y(t)
figure('Color','white','Position',[1300 500 900 400]);
hold on
styles = {'-', '--'};
for i = 1:2
    plot(t, Y(:,i), 'LineWidth', 2.5, 'Color', colors(i,:), 'LineStyle', styles{i})
end
ax = gca; ax.LineWidth = 1.5; ax.FontSize = Te;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
grid on; grid minor; box on;
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
ylabel('$y(t)$','Interpreter','latex','FontSize',M)
xlabel('$t$','Interpreter','latex','FontSize',M)
legend('$y_1$','$y_2$','Interpreter','latex','Location','northeast','FontSize',Le, 'NumColumns', 2)
xlim([-0.01 7]);
set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');
exportgraphics(gcf,'../../report/images/task3/y.pdf','ContentType','vector')