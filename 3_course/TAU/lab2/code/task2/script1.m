clc; 
% clear all;

%% INIT
A = [-40  16   9   7;
     -64  25  14  12;
     -26  11   7   3;
     -48  18  14   8];

C = [-3  2  -2  1];

%% JORDAN
% [P, J] = jordan(sym(A)); P = double(P); J = double(J);
% [P_real, J_real] = cdf2rdf(P, J);
% C_tilde = C *inv(P_real);

%% KANON
g = poly([-1, -1, -1, -1]);
Gamma = [0, 0, 0, -g(5);
         1, 0, 0, -g(4);
         0, 1, 0, -g(3);
         0, 0, 1, -g(2)]

a = double(poly(A));

A_k = [0, 0, 0, -a(5);
       1, 0, 0, -a(4);
       0, 1, 0, -a(3);
       0, 0, 1, -a(2);]

C_k = [0, 0, 0, 1;];

%% elements L
syms l1 l2 l3 l4
L_k = [l1; l2; l3; l4;];

eq = A_k + L_k * C_k == Gamma;
sol = solve(eq,[l1 l2 l3 l4]);

L_k = double([sol.l1; sol.l2; sol.l3; sol.l4])

T = obsv(A_k, C_k) \ obsv(A, C);
L = T^-1 * L_k

z = A + L*C
eig(z)

%% SIMULATION & PLOTS

% Настройки
Te = 14; M = 18; Le = 16;
colors = [0, 0.5, 0.4; 0, 0, 0.7; 0.8, 0.2, 0.2; 0.85, 0.65, 0.0];

% Симуляция
x0  = [1; 1; 1; 1];
xh0 = [0; 0; 0; 0];
F = [A, zeros(4); -L*C, A + L*C];
[t, Z] = ode45(@(t,z) F*z, [0 50], [x0; xh0]);
X  = Z(:,1:4);
Xh = Z(:,5:8);
E  = X - Xh;

%% Figure 1 — x(t) и x̂(t) в столбик
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
%         'Interpreter','latex','Location','northeast','FontSize',Le, 'NumColumns', 2)
%     xlim([-0.01 11.01]); ylim([-23; 26]);
%     if i == 4
%         xlabel('$t$','Interpreter','latex','FontSize',M)
%     end
%     set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');
% end
% exportgraphics(gcf,'../../report/images/task2/x1.pdf','ContentType','vector')
% 
% %% Figure 2 — e(t) в столбик
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
%     xlim([-0.01 11.01]); ylim([-10; 19]);
%     if i == 4
%         xlabel('$t$','Interpreter','latex','FontSize',M)
%     end
%     set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');
% end
% exportgraphics(gcf,'../../report/images/task2/e1.pdf','ContentType','vector')

%% Figure 3 — x(t) и x̂(t) приближение
% figure('Color','white','Position',[100 100 900 350]);
% for i = 1:4
%     subplot(2,2,i); hold on
%     plot(t, X(:,i),  'LineWidth', 2.5, 'Color', colors(4,:), 'LineStyle','-')
%     plot(t, Xh(:,i), 'LineWidth', 2.5, 'Color', colors(1,:), 'LineStyle','-')
%     ax = gca; ax.LineWidth = 1.5; ax.FontSize = Te;
%     ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
%     grid on; grid minor; box on;
%     ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
%     ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
%     ylabel(sprintf('$x_%d(t)$', i), 'Interpreter','latex','FontSize',M)
%     legend(sprintf('$x_%d$',i), sprintf('$\\hat{x}_%d$',i), ...
%         'Interpreter','latex','Location','northeast','FontSize',Le,'NumColumns',2)
%     xlim([-0.01 0.8]); ylim([-3 3.5]);
%     yline(1, '--', 'LineWidth', 1, 'Color', colors(4,:), 'HandleVisibility','off');
%     yline(0, '--', 'LineWidth', 1, 'Color', colors(1,:), 'HandleVisibility','off');
% 
%     current_ticks = yticks;
%     current_labels = yticklabels;
%     new_labels = current_labels;
%     for k = 1:length(current_ticks)
%         if current_ticks(k) == 0 || current_ticks(k) == 1
%             new_labels{k} = '';  
%         end
%     end
%     yticklabels(new_labels);
% 
%     xl = xlim;
%     tick_offset = ax.TickLength(1) * (xl(2)-xl(1)) + 0.01*(xl(2)-xl(1));
% 
%     text(xl(1) - tick_offset, 1, '1', ...
%         'Color', colors(4,:), 'FontSize', Te+1, ...
%         'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
%         'Clipping', 'off');
%     text(xl(1) - tick_offset, 0, '0', ...
%         'Color', colors(1,:), 'FontSize', Te+1, ...
%         'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
%         'Clipping', 'off');
%     set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');
% end
% exportgraphics(gcf,'../../report/images/task2/xp1.pdf','ContentType','vector')