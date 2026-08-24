% w_f / wf_hat

limYDown = min(min(min(w_f, wf_hat))); limYUp = max(max(max(w_f, wf_hat)));

fig_wf = figure('Color', 'white', 'Position', [100, 100, 900, 400]);

plot(t, w_f(:,1), 'Color', colors(1,:), 'LineWidth', L_g); hold on;
plot(t, w_f(:,2), 'Color', colors(2,:), 'LineWidth', L_g); hold on;
plot(t, w_f(:,3), 'Color', colors(3,:), 'LineWidth', L_g); hold on;
plot(t, w_f(:,4), 'Color', colors(4,:), 'LineWidth', L_g); hold on;

plot(t, wf_hat(:,1), 'Color', colors(5,:), 'LineWidth', L_g, 'LineStyle','--'); hold on;
plot(t, wf_hat(:,2), 'Color', colors(6,:), 'LineWidth', L_g, 'LineStyle','--'); hold on;
plot(t, wf_hat(:,3), 'Color', colors(7,:), 'LineWidth', L_g, 'LineStyle','--'); hold on;
plot(t, wf_hat(:,4), 'Color', colors(8,:), 'LineWidth', L_g, 'LineStyle','--'); hold on;

setPlotStyle(gca, 'FontSize', F_g, 'LineWidth', L_g);
xlim([-0.02; 10.02]); ylim([limYDown*1.1; limYUp*2.4]);

legend('$w_{f1}(t)$', '$w_{f2}(t)$', '$w_{f3}(t)$', '$w_{f4}(t)$', ...
    '$\hat{w}_{f1}(t)$', '$\hat{w}_{f2}(t)$', '$\hat{w}_{f3}(t)$', '$\hat{w}_{f4}(t)$', ...
    'Interpreter', 'latex', 'FontSize', F_g+2, 'NumColumns', 2);

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F_g+2); 
ylabel('$w_f(t), \hat{w}_f(t)$', 'Interpreter', 'latex', 'FontSize', F_g+2);

exportgraphics(fig_wf, '../../report/images/task3/wf_st.pdf', 'ContentType', 'vector');
close(fig_wf);


% e_f

limYDown = min(min(e_f)); limYUp = max(max(e_f));

fig_ef = figure('Color', 'white', 'Position', [100, 100, 900, 400]);

plot(t, e_f(:,1), 'Color', colors(1,:), 'LineWidth', L_g); hold on;
plot(t, e_f(:,2), 'Color', colors(2,:), 'LineWidth', L_g); hold on;
plot(t, e_f(:,3), 'Color', colors(3,:), 'LineWidth', L_g); hold on;
plot(t, e_f(:,4), 'Color', colors(4,:), 'LineWidth', L_g); hold on;

setPlotStyle(gca, 'FontSize', F_g, 'LineWidth', L_g);
xlim([-0.02; 10.02]); ylim([limYDown*1.1; limYUp*1.1]);

legend('$e_{f1}(t)$', '$e_{f2}(t)$', '$e_{f3}(t)$', '$e_{f4}(t)$', ...
    'Interpreter', 'latex', 'FontSize', F_g+2, 'NumColumns', 2);

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F_g+2); 
ylabel('$e_f(t) = w_f(t) - \hat{w}_f(t)$', 'Interpreter', 'latex', 'FontSize', F_g+2);

exportgraphics(fig_ef, '../../report/images/task3/ef_st.pdf', 'ContentType', 'vector');
close(fig_ef);

clear fig_wf fig_ef limYUp limYDown