clc;
% w_f / wf_hat

limYDown = min(min(min(w_f, wf_hat))); limYUp = max(max(max(w_f, wf_hat)));

fig_wf = figure('Color', 'white', 'Position', [100, 100, 900, 400]);

plot(t, w_f(:,1), 'Color', colors(1,:), 'LineWidth', L); hold on;
plot(t, w_f(:,2), 'Color', colors(2,:), 'LineWidth', L); hold on;
plot(t, w_f(:,3), 'Color', colors(3,:), 'LineWidth', L); hold on;
plot(t, w_f(:,4), 'Color', colors(4,:), 'LineWidth', L); hold on;

plot(t, wf_hat(:,1), 'Color', colors(5,:), 'LineWidth', L, 'LineStyle','--'); hold on;
plot(t, wf_hat(:,2), 'Color', colors(6,:), 'LineWidth', L, 'LineStyle','--'); hold on;
plot(t, wf_hat(:,3), 'Color', colors(7,:), 'LineWidth', L, 'LineStyle','--'); hold on;
plot(t, wf_hat(:,4), 'Color', colors(8,:), 'LineWidth', L, 'LineStyle','--'); hold on;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
xlim([-0.02; 10.02]); ylim([limYDown*1.1; limYUp*2.4]);

legend('$w_{f1}(t)$', '$w_{f2}(t)$', '$w_{f3}(t)$', '$w_{f4}(t)$', ...
    '$\hat{w}_{f1}(t)$', '$\hat{w}_{f2}(t)$', '$\hat{w}_{f3}(t)$', '$\hat{w}_{f4}(t)$', ...
    'Interpreter', 'latex', 'FontSize', F+2, 'NumColumns', 2);

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$w_f(t), \hat{w}_f(t)$', 'Interpreter', 'latex', 'FontSize', F+2);

exportgraphics(fig_wf, '../../report/images/task2/wf.pdf', 'ContentType', 'vector');
close(fig_wf);


% w_g / wg_hat

limYDown = min(min(min(w_g, wg_hat))); limYUp = max(max(max(w_g, wg_hat)));

fig_wg = figure('Color', 'white', 'Position', [100, 100, 900, 400]);

plot(t, w_g(:,1), 'Color', colors(1,:), 'LineWidth', L); hold on;
plot(t, w_g(:,2), 'Color', colors(2,:), 'LineWidth', L); hold on;
plot(t, w_g(:,3), 'Color', colors(3,:), 'LineWidth', L); hold on;

plot(t, wg_hat(:,1), 'Color', colors(5,:), 'LineWidth', L, 'LineStyle','--'); hold on;
plot(t, wg_hat(:,2), 'Color', colors(6,:), 'LineWidth', L, 'LineStyle','--'); hold on;
plot(t, wg_hat(:,3), 'Color', colors(7,:), 'LineWidth', L, 'LineStyle','--'); hold on;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
xlim([-0.02; 10.02]); ylim([limYDown*1.1; limYUp*2.2]);

legend('$w_{g1}(t)$', '$w_{g2}(t)$', '$w_{g3}(t)$', ...
    '$\hat{w}_{g1}(t)$', '$\hat{w}_{g2}(t)$', '$\hat{w}_{g3}(t)$', ...
    'Interpreter', 'latex', 'FontSize', F+2, 'NumColumns', 2);

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$w_g(t), \hat{w}_g(t)$', 'Interpreter', 'latex', 'FontSize', F+2);

exportgraphics(fig_wg, '../../report/images/task2/wg.pdf', 'ContentType', 'vector');
close(fig_wg);


% x / x_hat

limYDown = min(min(min(x, x_hat))); limYUp = max(max(max(x, x_hat)));

fig_x = figure('Color', 'white', 'Position', [100, 100, 900, 400]);

plot(t, x(:,1), 'Color', colors(1,:), 'LineWidth', L); hold on;
plot(t, x(:,2), 'Color', colors(2,:), 'LineWidth', L); hold on;
plot(t, x(:,3), 'Color', colors(3,:), 'LineWidth', L); hold on;

plot(t, x_hat(:,1), 'Color', colors(5,:), 'LineWidth', L, 'LineStyle','--'); hold on;
plot(t, x_hat(:,2), 'Color', colors(6,:), 'LineWidth', L, 'LineStyle','--'); hold on;
plot(t, x_hat(:,3), 'Color', colors(7,:), 'LineWidth', L, 'LineStyle','--'); hold on;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
xlim([-0.02; 10.02]); ylim([limYDown*1.1; limYUp*1.4]);

legend('$x_{1}(t)$', '$x_{2}(t)$', '$x_{3}(t)$', ...
    '$\hat{x}_{1}(t)$', '$\hat{x}_{2}(t)$', '$\hat{x}_{3}(t)$', ...
    'Interpreter', 'latex', 'FontSize', F+2, 'NumColumns', 2);

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$x(t), \hat{x}_(t)$', 'Interpreter', 'latex', 'FontSize', F+2);

exportgraphics(fig_x, '../../report/images/task2/x.pdf', 'ContentType', 'vector');
close(fig_x);


clear limYUp limYDown fig_wf fig_wg fig_x;