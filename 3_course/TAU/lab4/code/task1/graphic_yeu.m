
%%%%%%%%%%%%%%%   y на одном рисунке для замкнутых           %%%%%%%%%%%%%%

allY = [y_uK; y_uKf; y_uKg; y_uKfg];
limYDown = min(allY); limYUp = max(allY); 

fig_y = figure('Color', 'white', 'Position', [100, 100, 900, 400]);
plot(t, y_uK, 'Color', colors(1,:), 'LineWidth', L); hold on;
plot(t, y_uKg, 'Color', colors(2,:), 'LineWidth', L); hold on;
plot(t, y_uKf, 'Color', colors(3,:), 'LineWidth', L); hold on;
plot(t, y_uKfg, 'Color', colors(4,:), 'LineWidth', L); hold on;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
xlim([-0.02; 10.02]); ylim([limYDown*1.1; limYUp*1.3]);

legend('$y_1(t)$', '$y_2(t)$', '$y_3(t)$', '$y_4(t)$', 'Interpreter', 'latex', 'FontSize', F+2, 'NumColumns', 3);
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$y(t)$', 'Interpreter', 'latex', 'FontSize', F+2); 

exportgraphics(fig_y, '../../report/images/task1/y.pdf', 'ContentType', 'vector');
close(fig_y);

%%%%%%%%%%%%%%%   e на одном рисунке для замкнутых           %%%%%%%%%%%%%%

allE = [e_uK; e_uKf; e_uKg; e_uKfg];
limEDown = min(allE); limEUp = max(allE); 

fig_e = figure('Color', 'white', 'Position', [100, 100, 900, 400]);
plot(t, e_uK, 'Color', colors(1,:), 'LineWidth', L); hold on;
plot(t, e_uKg, 'Color', colors(2,:), 'LineWidth', L); hold on;
plot(t, e_uKf, 'Color', colors(3,:), 'LineWidth', L); hold on;
plot(t, e_uKfg, 'Color', colors(4,:), 'LineWidth', L); hold on;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
xlim([-0.02, 10.02]); ylim([limEDown*1.1, limEUp*1.3]);

legend('$e_1(t)$', '$e_2(t)$', '$e_3(t)$', '$e_4(t)$', 'Interpreter', 'latex', 'FontSize', F+2, 'NumColumns', 3);
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$e(t)$', 'Interpreter', 'latex', 'FontSize', F+2); 

exportgraphics(fig_e, '../../report/images/task1/e.pdf', 'ContentType', 'vector');
close(fig_e);


%%%%%%%%%%%%%%%   e на одном рисунке для замкнутых           %%%%%%%%%%%%%%

allU = [u_uK; u_uKf; u_uKg; u_uKfg];
limUDown = min(allU); limUUp = max(allU); 

fig_u = figure('Color', 'white', 'Position', [100, 100, 900, 400]);
plot(t, u_uK, 'Color', colors(1,:), 'LineWidth', L); hold on;
plot(t, u_uKg, 'Color', colors(2,:), 'LineWidth', L); hold on;
plot(t, u_uKf, 'Color', colors(3,:), 'LineWidth', L); hold on;
plot(t, u_uKfg, 'Color', colors(4,:), 'LineWidth', L); hold on;

setPlotStyle(gca, 'FontSize', F, 'LineWidth', L);
xlim([-0.02, 10.02]); ylim([limUDown*1.1, limUUp*1.3]);

legend('$u_1(t)$', '$u_2(t)$', '$u_3(t)$', '$u_4(t)$', 'Interpreter', 'latex', 'FontSize', F+2, 'NumColumns', 3);
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', F+2); 
ylabel('$u(t)$', 'Interpreter', 'latex', 'FontSize', F+2); 

exportgraphics(fig_u, '../../report/images/task1/u.pdf', 'ContentType', 'vector');
% close(fig_u);