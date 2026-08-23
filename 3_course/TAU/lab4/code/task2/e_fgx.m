clc;
% e_f

limYDown = min(min(e_f)); limYUp = max(max(e_f));

fig_ef = figure('Color', 'white', 'Position', [100, 100, 900, 400]);

plot(t, e_f(:,1), 'Color', colors(1,:), 'LineWidth', L); hold on;
plot(t, e_f(:,2), 'Color', colors(2,:), 'LineWidth', L); hold on;
plot(t, e_f(:,3), 'Color', colors(3,:), 'LineWidth', L); hold on;
plot(t, e_f(:,4), 'Color', colors(4,:), 'LineWidth', L); hold on;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
xlim([-0.02; 10.02]); ylim([limYDown*1.1; limYUp*1.1]);

legend('$e_{f1}(t)$', '$e_{f2}(t)$', '$e_{f3}(t)$', '$e_{f4}(t)$', ...
    'Interpreter', 'latex', 'FontSize', F+2, 'NumColumns', 2);

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$e_f(t) = w_f(t) - \hat{w}_f(t)$', 'Interpreter', 'latex', 'FontSize', F+2);

exportgraphics(fig_ef, '../../report/images/task2/ef.pdf', 'ContentType', 'vector');
close(fig_ef);


% e_g

limYDown = min(min(e_g)); limYUp = max(max(e_g));

fig_eg = figure('Color', 'white', 'Position', [100, 100, 900, 400]);

plot(t, e_g(:,1), 'Color', colors(1,:), 'LineWidth', L); hold on;
plot(t, e_g(:,2), 'Color', colors(2,:), 'LineWidth', L); hold on;
plot(t, e_g(:,3), 'Color', colors(3,:), 'LineWidth', L); hold on;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
xlim([-0.02; 10.02]); ylim([limYDown*1.1; limYUp*1.1]);

legend('$e_{g1}(t)$', '$e_{g2}(t)$', '$e_{g3}(t)$', ...
    'Interpreter', 'latex', 'FontSize', F+2, 'NumColumns', 1);

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$e_g(t) = w_g(t) - \hat{w}_g(t)$', 'Interpreter', 'latex', 'FontSize', F+2);

exportgraphics(fig_eg, '../../report/images/task2/eg.pdf', 'ContentType', 'vector');
close(fig_eg);


% e_x

limYDown = min(min(e_x)); limYUp = max(max(e_x));

fig_ex = figure('Color', 'white', 'Position', [100, 100, 900, 400]);

plot(t, e_x(:,1), 'Color', colors(1,:), 'LineWidth', L); hold on;
plot(t, e_x(:,2), 'Color', colors(2,:), 'LineWidth', L); hold on;
plot(t, e_x(:,3), 'Color', colors(3,:), 'LineWidth', L); hold on;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
xlim([-0.02; 10.02]); ylim([limYDown*1.1; limYUp*1.1]);

legend('$e_{x1}(t)$', '$e_{x2}(t)$', '$e_{x3}(t)$', ...
    'Interpreter', 'latex', 'FontSize', F+2, 'NumColumns', 1);

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$e_x(t) = w_x(t) - \hat{w}_x(t)$', 'Interpreter', 'latex', 'FontSize', F+2);

exportgraphics(fig_ex, '../../report/images/task2/ex.pdf', 'ContentType', 'vector');
% close(fig_ex);