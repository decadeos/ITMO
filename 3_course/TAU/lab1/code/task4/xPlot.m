% 
% close all; clear all; clc;
% colors = [0, 0.5, 0.4; 0, 0, 0.7; 0.8, 0.2, 0.2; 0.85, 0.65, 0.0];
% % line_colors: alpha=0 -> золотой, alpha=0.5 -> зелёный, alpha=1 -> синий, alpha=2 -> красный
% line_colors = [colors(4,:); colors(1,:); colors(2,:); colors(3,:)];
% line_styles = {'-', '--', '-.', ':'};
% line_styles = {'-', '-.', ':', '--'};
% M = 15; L = 16; T = 13;
% 
% A = [-13 -36 -8;
%       6  15  2;
%      -2  -8 -3];
% C = [0 4 4];
% t1 = 3; tspan = linspace(0, t1, 1000);
% f = @(t) exp(-t).*cos(4*t) + 3*exp(-t).*sin(4*t);
% 
% Q = integral(@(t) expm(A'*t)*C'*C*expm(A*t), 0, t1, 'ArrayValued', true);
% I = integral(@(t) expm(A'*t)*C'*f(t), 0, t1, 'ArrayValued', true);
% x0 = pinv(Q) * I;
% e = [2; -1; 1];
% 
% x0s = {x0 + 0*e, x0 + 0.5*e, x0 + 1*e, x0 + 2*e};
% xs = cell(1,4);
% for k = 1:4
%     [~, xs{k}] = ode45(@(t,x) A*x, tspan, x0s{k});
% end
% 
% legend_labels = {'$\alpha=0$','$\alpha=0.5$','$\alpha=1$','$\alpha=2$'};
% comp_labels   = {'$x_1(t)$','$x_2(t)$','$x_3(t)$'};
% file_names    = {'x1','x2','x3'};

% for comp = 1:3
%     figure('Color', 'white', 'Position', [100+comp*30, 100+comp*30, 900, 350]);
%     hold on;
%     for k = 1:4
%         plot(tspan, xs{k}(:,comp), 'LineWidth', 2.5, 'Color', line_colors(k,:));
%     end
%     xline(t1, '--', 'LineWidth', 1, 'Color', [0.7 0.7 0.7], 'HandleVisibility', 'off');
%     ax = gca;
%     ax.LineWidth = 1.5; ax.FontSize = T;
%     ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
%     ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
%     ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
%     grid on; grid minor; box on;
%     xlabel('$t$', 'Interpreter', 'latex', 'FontSize', M)
%     ylabel(comp_labels{comp}, 'Interpreter', 'latex', 'FontSize', M)
%     legend(legend_labels, 'Interpreter', 'latex', ...
%         'FontSize', L, 'NumColumns', 4, 'Location', 'northwest');
%     xlim([-0.01, 3.01]);
%     set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
%     exportgraphics(gcf, sprintf('../../report/images/task4/%s.pdf', file_names{comp}), ...
%         'ContentType', 'vector');
% end
% 
% 
% for comp = 1:3
%     figure('Color', 'white', 'Position', [100+comp*30, 100+comp*30, 900, 350]);
%     hold on;
%     for k = 1:4
%         plot(tspan, xs{k}(:,comp), 'LineWidth', 2.5, 'Color', line_colors(k,:));
%     end
%     for k = 1:4
%         yline(x0s{k}(comp), '--', 'LineWidth', 1, ...
%             'Color', line_colors(k,:), 'HandleVisibility', 'off');
%     end
%     ax = gca;
%     ax.LineWidth = 1.5; ax.FontSize = T;
%     ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
%     ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
%     ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
%     grid on; grid minor; box on;
%     xlabel('$t$', 'Interpreter', 'latex', 'FontSize', M)
%     ylabel(comp_labels{comp}, 'Interpreter', 'latex', 'FontSize', M)
%     legend(legend_labels, 'Interpreter', 'latex', ...
%         'FontSize', L, 'NumColumns', 4, 'Location', 'southwest');
%     xlim([-0.001, 0.3]);
%     if comp == 1
%         ylim([-6, 6]);
%     else
%         ylim([-3, 3]);
%     end
%     set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
%     exportgraphics(gcf, sprintf('../../report/images/task4/%s_zoom.pdf', file_names{comp}), ...
%         'ContentType', 'vector');
% end

% figure('Color', 'white', 'Position', [100, 100, 900, 400]);
% hold on;
% for k = 1:4
%     y_k = (C * xs{k}')';
%     plot(tspan, y_k, line_styles{k}, ...
%         'LineWidth', 2.5, 'Color', line_colors(k,:));
% end
% ax = gca;
% ax.LineWidth = 1.5; ax.FontSize = T;
% ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
% ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
% ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
% grid on; grid minor; box on;
% xlabel('$t$', 'Interpreter', 'latex', 'FontSize', M)
% ylabel('$y(t)$', 'Interpreter', 'latex', 'FontSize', M)
% legend(legend_labels, 'Interpreter', 'latex', ...
%     'Location', 'northeast', 'FontSize', L, 'NumColumns', 4);
% xlim([-0.01, 3.01]);
% set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
% exportgraphics(gcf, '../../report/images/task4/y.pdf', 'ContentType', 'vector');
