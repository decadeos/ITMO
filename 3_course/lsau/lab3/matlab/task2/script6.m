t = 0:0.01:10;

lambda = [-0.5+3j, -0.5-3j, -1];

num = abs(prod(lambda));
den = poly(lambda);
sys = tf(num, den);
[y, t_out] = step(sys, t);

y_inf = y(end);

[y_max, idx_max] = max(y);
Mp = (y_max - y_inf) / y_inf * 100;
t_max = t_out(idx_max);

lower_bound = 0.95 * y_inf;
upper_bound = 1.05 * y_inf;

tp_index = find((y < lower_bound) | (y > upper_bound), 1, 'last');
if isempty(tp_index)
    tp = 0;
else
    if tp_index + 1 <= length(t_out)
        tp = t_out(tp_index + 1);
    else
        tp = t_out(end);
    end
end

figure('Color', 'white', 'Position', [100, 100, 700, 350]);
hold on;

x_fill = [t_out(:); flipud(t_out(:))];
y_fill = [upper_bound*ones(size(t_out(:))); flipud(lower_bound*ones(size(t_out(:))))];
h_fill = fill(x_fill, y_fill, [0, 0, 0.7], 'FaceAlpha', 0.3, 'EdgeColor', 'none');

uistack(h_fill, 'bottom')

h_plot = plot(t_out, y, 'b-', 'LineWidth', 2.5, 'Color', [0, 0, 0.7]);

h_ymax = plot([0, t_max], [y_max, y_max], 'k--', 'LineWidth', 1.5);



text(-0.2, y_max + 0.01, 'y_{max}', ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'bottom', ... 
    'FontSize', 12, 'Color', 'black', 'FontWeight', 'bold');


if tp > 0
    h_tp = plot([tp, tp], [0, lower_bound], 'r--', 'LineWidth', 1.5, 'Color', [0.8, 0, 0]);

    text(tp+0.2, -0.011, sprintf('t_p', tp), ...
     'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', ...
     'FontSize', 12, 'Color', [0.8, 0, 0], 'FontWeight', 'bold');
end

h_yinf = plot([0, t_out(end)], [y_inf, y_inf], 'k--', 'LineWidth', 1.5);

text(-0.3, y_inf, sprintf('y_{∞}', y_inf), ...
     'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
     'FontSize', 12, 'Color', 'black', 'FontWeight', 'bold');

hold off;

ax = gca;
ax.LineWidth = 1.5;
ax.FontSize = 14;
ax.FontName = 'DejaVuMathTeXGyre';
ax.XColor = [0.3, 0.3, 0.3];
ax.YColor = [0.3, 0.3, 0.3];
grid on; grid minor;
ax.GridColor = [0.9, 0.9, 0.9];
ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95, 0.95, 0.95];
ax.MinorGridAlpha = 0.2;
box on;

ylim([-0.02, 1.1]); 
xlim([0, t_out(end)]); 

xlabel('Time');
ylabel('Amplitude');

legend([h_plot, h_fill, h_yinf, h_ymax, h_tp], ...
       'Step response', '±5% region', ...
       sprintf('y_{∞} = %.2f', y_inf), ...
       sprintf('y_{max} = %.2f', y_max), ...
       sprintf('t_p = %.2f s', tp), ...
       'Location', 'southeast');

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../images/task2/y6.png', 'Resolution', 300);

fprintf('\n==== Результаты ====\n');
fprintf('Полюса:                 %s\n', mat2str(lambda));
fprintf('Установившееся значение: %.4f\n', y_inf);
fprintf('Перерегулирование:       %.2f %%\n', Mp);
fprintf('Время перехода (5%%):     %.2f сек\n', tp);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('Color', 'white', 'Position', [100, 100, 550, 300]); 
% plot(real(lambda), imag(lambda), 'o', 'MarkerSize', 10, ...
%     'MarkerFaceColor', [0.0, 0.0, 0.7], 'MarkerEdgeColor', 'black', 'LineWidth', 1.5);

colors = {[0, 0, 0.7], [0.8, 0.2, 0.2], [0, 0.5, 0.4]};

hold on
for k = 1:length(lambda)
    plot(real(lambda(k)), imag(lambda(k)), 'o', ...
        'MarkerSize', 10, ...
        'MarkerFaceColor', colors{k}, ...
        'MarkerEdgeColor', 'k', ...
        'LineWidth', 1.5);
end
hold off

grid on; 
axis equal; 
ax = gca;

ax.Box = 'off'; 
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin'; 

ax.LineWidth = 1.5; 
ax.FontSize = 12; 
ax.FontName = 'DejaVuMathTeXGyre'; 
ax.XColor = [0.3, 0.3, 0.3]; 
ax.YColor = [0.3, 0.3, 0.3];

grid on; 
grid minor; 
ax.GridColor = [0.9, 0.9, 0.9]; 
ax.GridAlpha = 0.4; 
ax.MinorGridColor = [0.95, 0.95, 0.95]; 
ax.MinorGridAlpha = 0.2;

xlabel('Re(\lambda)');
ylabel('Im(\lambda)');

xlim([-3.3, 3.3]); 
ylim([-3.3, 3.3]); 

ax.TickDir = 'in';

ax.XTick = -6:1:6; 
ax.YTick = -6:1:6;

ax.XAxis.Label.FontSize = 13;
ax.YAxis.Label.FontSize = 13;

hold on;

arrowColor = [0.3, 0.3, 0.3];
arrowSize = 0.25; 

x_arrow_x = [2.9, 3.25, 2.9, 2.9];
x_arrow_y = [arrowSize/2, 0, -arrowSize/2, arrowSize/2];
fill(x_arrow_x, x_arrow_y, arrowColor, 'EdgeColor', arrowColor, 'LineWidth', 1);

y_arrow_x = [arrowSize/2, 0, -arrowSize/2, arrowSize/2];
y_arrow_y = [2.9, 3.25, 2.9, 2.9]; 
fill(y_arrow_x, y_arrow_y, arrowColor, 'EdgeColor', arrowColor, 'LineWidth', 1);

hold off;

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../images/task2/lambda6.png', 'Resolution', 300);