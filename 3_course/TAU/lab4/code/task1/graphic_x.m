
%%%%%%%%%%%%%%%           x_uK plot                          %%%%%%%%%%%%%%

limXDown = min(min(x_uK)); limXUp = max(max(x_uK));

fig_x_uK = figure('Color', 'white', 'Position', [100, 100, 900, 400]);
plot(t, x_uK(:,1), 'Color', colors(1,:), 'LineWidth', L); hold on;
plot(t, x_uK(:,2), 'Color', colors(2,:), 'LineWidth', L); hold on;
plot(t, x_uK(:,3), 'Color', colors(3,:), 'LineWidth', L); hold on;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
% xlim([-0.02; 10.02]); ylim([limXDown*1.1; limXUp*1.3]);

legend('$x_1(t)$', '$x_2(t)$', '$x_3(t)$', 'Interpreter', 'latex', 'FontSize', F+2, 'NumColumns', 3);
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', F+2); 

exportgraphics(fig_x_uK, '../../report/images/task1/x_uK.pdf', 'ContentType', 'vector');
% close(fig_x_uK);

%%%%%%%%%%%%%%%           x_uKf plot                          %%%%%%%%%%%%%

limXDown = min(min(x_uKf)); limXUp = max(max(x_uKf));

fig_x_uKf = figure('Color', 'white', 'Position', [100, 100, 900, 400]);
plot(t, x_uKf(:,1), 'Color', colors(1,:), 'LineWidth', L); hold on;
plot(t, x_uKf(:,2), 'Color', colors(2,:), 'LineWidth', L); hold on;
plot(t, x_uKf(:,3), 'Color', colors(3,:), 'LineWidth', L); hold on;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
% xlim([-0.02; 10.02]); ylim([limXDown*1.1; limXUp*1.3]);

legend('$x_1(t)$', '$x_2(t)$', '$x_3(t)$', 'Interpreter', 'latex', 'FontSize', F+2, 'NumColumns', 3);
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', F+2); 

exportgraphics(fig_x_uKf, '../../report/images/task1/x_uKf.pdf', 'ContentType', 'vector');
% close(fig_x_uKf);

%%%%%%%%%%%%%%%           x_uKg plot                          %%%%%%%%%%%%%

limXDown = min(min(x_uKg)); limXUp = max(max(x_uKg));

fig_x_uKg = figure('Color', 'white', 'Position', [100, 100, 900, 400]);
plot(t, x_uKg(:,1), 'Color', colors(1,:), 'LineWidth', L); hold on;
plot(t, x_uKg(:,2), 'Color', colors(2,:), 'LineWidth', L); hold on;
plot(t, x_uKg(:,3), 'Color', colors(3,:), 'LineWidth', L); hold on;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
% xlim([-0.02; 10.02]); ylim([limXDown*1.1; limXUp*1.3]);

legend('$x_1(t)$', '$x_2(t)$', '$x_3(t)$', 'Interpreter', 'latex', 'FontSize', F+2, 'NumColumns', 3);
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', F+2); 

exportgraphics(fig_x_uKg, '../../report/images/task1/x_uKg.pdf', 'ContentType', 'vector');
% close(fig_x_uKg);


%%%%%%%%%%%%%%%           x_uKfg plot                          %%%%%%%%%%%%%

limXDown = min(min(x_uKfg)); limXUp = max(max(x_uKfg));

fig_x_uKfg = figure('Color', 'white', 'Position', [100, 100, 900, 400]);
plot(t, x_uKfg(:,1), 'Color', colors(1,:), 'LineWidth', L); hold on;
plot(t, x_uKfg(:,2), 'Color', colors(2,:), 'LineWidth', L); hold on;
plot(t, x_uKfg(:,3), 'Color', colors(3,:), 'LineWidth', L); hold on;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
% xlim([-0.02; 10.02]); ylim([limXDown*1.1; limXUp*1.3]);

legend('$x_1(t)$', '$x_2(t)$', '$x_3(t)$', 'Interpreter', 'latex', 'FontSize', F+2, 'NumColumns', 3);
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', F+2); 

exportgraphics(fig_x_uKfg, '../../report/images/task1/x_uKfg.pdf', 'ContentType', 'vector');
% close(fig_x_uKfg);







%%%%%%%%%%%%%%%      очистка                                %%%%%%%%%%%%%%%

clear limFDown limGDown limXDown limYDown limFUp limGUp limXUp limYUp;
clear fig_f_uK fig_g_uK fig_x_uK fig_y_uK