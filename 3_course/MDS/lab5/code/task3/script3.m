% A  = [-4  1; -2 -4]; A1 = [ 1  2; 1 -1];
% h = 3; lags = h;
% function dx = ddefun(t, x, Z)
%     xlag = Z(:,1);
%     A  = [-4  1; -2 -4];
%     A1 = [ 1  2; 1 -1];
%     dx = A*x + A1*xlag;
% end
% 
% function xhist = history(t)
%     xhist = [1; 0]; 
% end
% 
% tspan = [0 20];
% sol = dde23(@ddefun, lags, @history, tspan);
% 
% figure('Position', [100 100 900 400], 'Color','white');
% plot(sol.x, sol.y(1,:), 'Color', [0 0 0.7], 'LineStyle', '-', 'LineWidth', 2.5); hold on;
% plot(sol.x, sol.y(2,:), 'Color', [0.8 0.2 0.2], 'LineStyle', '--', 'LineWidth', 2.5);
% 
% ax = gca; ax.LineWidth = 1.5; ax.FontSize = 13; 
% ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
% ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
% ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
% grid on; grid minor; box on; 
% 
% xlabel('t'); ylabel('x(t)');
% legend({'x_1' 'x_2'}, 'Location','northeast','FontSize',15);
% set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
% exportgraphics(gcf, '../../images/task3/modeling.png', 'Resolution', 500);



setlmis([]); [P_var,~,~] = lmivar(1,[2 1]); [Q_var,~,~] = lmivar(1,[2 1]);

lmiterm([1 1 1 P_var],A',1,'s'); lmiterm([1 1 1 Q_var],1,1); 
lmiterm([1 1 2 P_var],1,A1,'s'); lmiterm([1 2 2 Q_var],-1,1);
lmiterm([2 1 1 P_var],-1,1); lmiterm([3 1 1 Q_var],-1,1);
lmis = getlmis;

[tmin, xfeas] = feasp(lmis);
disp(P); disp(Q);
