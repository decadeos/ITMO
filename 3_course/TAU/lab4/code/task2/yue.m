clc; % y

limYDown = min(y); limYUp = max(y); 

fig_y = figure('Color', 'white', 'Position', [100, 100, 900, 280]);
plot(t, y, 'Color', colors(2,:), 'LineWidth', L); hold on;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
xlim([-0.02; 10.02]); ylim([limYDown*1.1; limYUp*1.4]);

legend('$y(t)$', 'Interpreter', 'latex', 'FontSize', F+2, 'NumColumns', 2);

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$y(t)$', 'Interpreter', 'latex', 'FontSize', F+2); 

exportgraphics(fig_y, '../../report/images/task2/y.pdf', 'ContentType', 'vector');
close(fig_y);

% e

limYDown = min(e); limYUp = max(e); 

fig_e = figure('Color', 'white', 'Position', [100, 100, 900, 280]);
plot(t, e, 'Color', colors(3,:), 'LineWidth', L); hold on;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
xlim([-0.02; 10.02]); ylim([limYDown*1.1; limYUp*1.4]);

legend('$e(t) = g(t) - y(t)$', 'Interpreter', 'latex', 'FontSize', F+2, 'NumColumns', 2);

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$e(t)$', 'Interpreter', 'latex', 'FontSize', F+2); 

exportgraphics(fig_e, '../../report/images/task2/e.pdf', 'ContentType', 'vector');
close(fig_e);

% u

limYDown = min(u); limYUp = max(u); 

fig_u = figure('Color', 'white', 'Position', [100, 100, 900, 280]);
plot(t, u, 'Color', colors(1,:), 'LineWidth', L); hold on;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
xlim([-0.02; 10.02]); ylim([limYDown*1.1; limYUp*1.4]);

legend('$u(t) = K \hat x + K_g \hat w_g + K_f w_f$', 'Interpreter', 'latex', 'FontSize', F+2, 'NumColumns', 2);

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$u(t)$', 'Interpreter', 'latex', 'FontSize', F+2); 

exportgraphics(fig_u, '../../report/images/task2/u.pdf', 'ContentType', 'vector');
close(fig_u);


clear limYUp limYDown fig_u fig_e fig_y;