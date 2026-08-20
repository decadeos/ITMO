clc; % Строятся отдельные графики для разомкнутой системы (f, g, x, y)

% config

limFDown = min(min(f_u0)); limFUp = max(max(f_u0));
limGDown = min(g_u0); limGUp = max(g_u0);
limXDown = min(min(x_u0)); limXUp = max(max(x_u0));
limYDown = min(y_u0); limYUp = max(y_u0);


%%%%%%%%%%%%%%%           f_u0 plot                          %%%%%%%%%%%%%%

fig_f_u0 = figure('Color', 'white', 'Position', [100, 100, 900, 400]);
plot(t, f_u0(:,1), 'Color', colors(2,:), 'LineWidth', L); hold on;
plot(t, f_u0(:,2), 'Color', colors(3,:), 'LineWidth', L); hold off;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
xlim([-0.02; 20.02]); ylim([limFDown*1.1; limFUp*1.6]);

legend('$f_1(t)$', '$f_2(t)$', 'Interpreter', 'latex', 'FontSize', F+2);
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$f(t)$', 'Interpreter', 'latex', 'FontSize', F+2); 

exportgraphics(fig_f_u0, '../../report/images/task1/f_u0.pdf', 'ContentType', 'vector');
close(fig_f_u0);


%%%%%%%%%%%%%%%           g_u0 plot                          %%%%%%%%%%%%%%

fig_g_u0 = figure('Color', 'white', 'Position', [100, 100, 900, 400]);
plot(t, g_u0, 'Color', colors(2,:), 'LineWidth', L); hold on;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
xlim([-0.02; 20.02]); ylim([limGDown*1.1; limGUp*1.8]);

legend('$g(t)$', 'Interpreter', 'latex', 'FontSize', F+2);
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$g(t)$', 'Interpreter', 'latex', 'FontSize', F+2); 

exportgraphics(fig_g_u0, '../../report/images/task1/g_u0.pdf', 'ContentType', 'vector');
close(fig_g_u0);


%%%%%%%%%%%%%%%           x_u0 plot                          %%%%%%%%%%%%%%

fig_x_u0 = figure('Color', 'white', 'Position', [100, 100, 900, 400]);
plot(t, x_u0(:,1), 'Color', colors(1,:), 'LineWidth', L); hold on;
plot(t, x_u0(:,2), 'Color', colors(2,:), 'LineWidth', L, 'LineStyle', '--'); hold on;
plot(t, x_u0(:,3), 'Color', colors(3,:), 'LineWidth', L, 'LineStyle', ':'); hold on;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
xlim([-0.02; 20.02]); ylim([limXDown*1.1; limXUp*1.3]);

legend('$x_1(t)$', '$x_2(t)$', '$x_3(t)$', 'Interpreter', 'latex', 'FontSize', F+2, 'NumColumns', 3);
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', F+2); 

exportgraphics(fig_x_u0, '../../report/images/task1/x_u0.pdf', 'ContentType', 'vector');
close(fig_x_u0);


%%%%%%%%%%%%%%%           y_u0 plot                          %%%%%%%%%%%%%%

fig_y_u0 = figure('Color', 'white', 'Position', [100, 100, 900, 400]);
plot(t, y_u0, 'Color', colors(3,:), 'LineWidth', L); hold on;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
xlim([-0.02; 20.02]); ylim([limYDown*1.1; limYUp*1.6]);

legend('$y(t)$', 'Interpreter', 'latex', 'FontSize', F+2, 'NumColumns', 3);
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$y(t)$', 'Interpreter', 'latex', 'FontSize', F+2); 

exportgraphics(fig_y_u0, '../../report/images/task1/y_u0.pdf', 'ContentType', 'vector');
close(fig_y_u0);


%%%%%%%%%%%%%%%      очистка                                %%%%%%%%%%%%%%%

clear limFDown limGDown limYDown limFUp limGUp limXUp limYUp;
clear fig_f_u0 fig_g_u0 fig_x_u0 fig_y_u0