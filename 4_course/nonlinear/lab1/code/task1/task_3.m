clc; clear;

% Красота
colors = [0, 0.5, 0.4;    
          0, 0, 0.7;        
          0.8, 0.2, 0.2;    
          0.85, 0.65, 0.0;
          0.30, 0.40, 0.15; 
          0.40, 0.10, 0.45;
          0.60, 0.20, 0.10;
          0.10, 0.45, 0.40];

line_width = 2.5;
font_size_label = 15;
font_size_legend = 15;

addpath('../../../../../3_course/TAU/config');

x_star = [1; -1];
u_star = [0; 0];

A = [5, 1; -1, -1];
B = [1, 0; 0, 3];

p_des = [-5; -6]; 
K = place(A, B, p_des);


sys_ol = @(t, x) [-x(1) + 2*x(1)^3 + x(2); 
                  -x(1) - x(2)];

sys_cl = @(t, x) [
    -x(1) + 2*x(1)^3 + x(2) + sin( max(-3, min(3, -K(1,:)*(x - x_star))) );
    -x(1) - x(2) + 3*sin( max(-3, min(3, -K(2,:)*(x - x_star))) )
];

x0 = [1.1; -0.9]; 

[t_op, x_op] = ode45(sys_ol, [0 0.35], x0);
[t_cl, x_cl] = ode45(sys_cl, [0 1.5], x0);

var_names = {'$x_1(t)$', '$x_1(t)$'};


% fig_op= figure('Position', [100, 100, 900, 350]);
% ax = gca; hold on;
% 
% for j = 1:2
%     plot(t_op, x_op(:,j), 'Color', colors(j+1,:), 'LineWidth', line_width, 'DisplayName', [var_names{j}]);
% end
% 
% xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% legend('Location', 'northeast', 'FontSize', font_size_legend, 'Interpreter', 'latex');
% setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
% 
% y_lim = ylim;
% y_offset = 0.3 * (y_lim(2) - y_lim(1));
% ylim([y_lim(1)-y_offset, y_lim(2) + y_offset]);
% 
% exportgraphics(fig_op, '../../report/images/xop1.pdf', 'ContentType', 'vector');
% 
% 
% 
% 
% fig_cl= figure('Position', [100, 100, 900, 350]);
% ax = gca; hold on;
% 
% for j = 1:2
%     plot(t_cl, x_cl(:,j), 'Color', colors(j+1,:), 'LineWidth', line_width, 'DisplayName', [var_names{j}]);
% end
% 
% xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
% legend('Location', 'northeast', 'FontSize', font_size_legend, 'Interpreter', 'latex');
% setPlotStyle(ax, 'FontSize', font_size_label, 'LineWidth', line_width);
% 
% y_lim = ylim;
% y_offset = 0.3 * (y_lim(2) - y_lim(1));
% ylim([y_lim(1)-y_offset, y_lim(2) + y_offset]);
% 
% exportgraphics(fig_cl, '../../report/images/xcl1.pdf', 'ContentType', 'vector');
% 

Co = ctrb(A,B)
rank(Co)


K
eig(A-B*K)