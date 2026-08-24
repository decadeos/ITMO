clc; % y

limYDown = min(y); limYUp = max(y); 

fig_y = figure('Color', 'white', 'Position', [100, 100, 900, 280]);
plot(t, y, 'Color', colors(2,:), 'LineWidth', L_g); hold on;

setPlotStyle(gca, 'FontSize', F_g, 'LineWidth', L_g);
xlim([-0.02; 10.02]); ylim([limYDown*1.1; limYUp*1.4]);

legend('$y(t)$', 'Interpreter', 'latex', 'FontSize', F_g+2, 'NumColumns', 2);

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F_g+2); 
ylabel('$y(t)$', 'Interpreter', 'latex', 'FontSize', F_g+2); 

exportgraphics(fig_y, '../../report/images/task3/y_st.pdf', 'ContentType', 'vector');
close(fig_y);

% e

limYDown = min(e); limYUp = max(e); 

fig_e = figure('Color', 'white', 'Position', [100, 100, 900, 280]);
plot(t, e, 'Color', colors(3,:), 'LineWidth', L_g); hold on;

setPlotStyle(gca, 'FontSize', F_g, 'LineWidth', L_g);
xlim([-0.02; 10.02]); ylim([limYDown*1.1; limYUp*1.4]);

legend('$e(t) = g(t) - y(t)$', 'Interpreter', 'latex', 'FontSize', F_g+2, 'NumColumns', 2);

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F_g+2); 
ylabel('$e(t)$', 'Interpreter', 'latex', 'FontSize', F_g+2); 

exportgraphics(fig_e, '../../report/images/task3/e_st.pdf', 'ContentType', 'vector');
close(fig_e);

% u

limYDown = min(u); limYUp = max(u); 

fig_u = figure('Color', 'white', 'Position', [100, 100, 900, 280]);
plot(t, u, 'Color', colors(1,:), 'LineWidth', L_g); hold on;

setPlotStyle(gca, 'FontSize', F_g, 'LineWidth', L_g);
xlim([-0.02; 10.02]); ylim([limYDown*1.1; limYUp*1.8]);

legend('$u(t) = K \hat x + K_g \hat w_g + K_f w_f$', 'Interpreter', 'latex', 'FontSize', F_g+2, 'NumColumns', 2);

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F_g+2); 
ylabel('$u(t)$', 'Interpreter', 'latex', 'FontSize', F_g+2); 

exportgraphics(fig_u, '../../report/images/task3/u_st.pdf', 'ContentType', 'vector');
close(fig_u);

% x

limYDown = min(min(x)); limYUp = min(max(x)); 

fig_x = figure('Color', 'white', 'Position', [100, 100, 900, 280]);
plot(t, x(:,1), 'Color', colors(1,:), 'LineWidth', L_g); hold on;
plot(t, x(:,2), 'Color', colors(2,:), 'LineWidth', L_g); hold on;
plot(t, x(:,3), 'Color', colors(3,:), 'LineWidth', L_g); hold on;

setPlotStyle(gca, 'FontSize', F_g, 'LineWidth', L_g);
xlim([-0.02; 10.02]); ylim([limYDown*1.1; limYUp*2.4]);

legend('$x_1(t)$', '$x_2(t)$', '$x_3(t)$', 'Interpreter', 'latex', 'FontSize', F_g+2, 'NumColumns', 3);

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F_g+2); 
ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', F_g+2); 

exportgraphics(fig_x, '../../report/images/task3/x_st.pdf', 'ContentType', 'vector');
close(fig_x);

clear limYUp limYDown fig_u fig_e fig_y fig_x;