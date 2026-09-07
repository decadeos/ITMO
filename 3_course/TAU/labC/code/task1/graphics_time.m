clc;
colors = [0, 0, 0.7]; 
line_width = 2.5;
font_size_label = 13;
font_size_legend = 15;

folder = '../../report/images/task1';


% Временной диапазон
t_vals = 0:0.01:2;
n = length(t_vals);

% Вычисление значений через цикл
g_vals = zeros(2, 2, n);
h_vals = zeros(2, 2, n);

for k = 1:n
    g_vals(:,:,k) = double(subs(g, t, t_vals(k)));
    h_vals(:,:,k) = double(subs(h, t, t_vals(k)));
end

% График весовой характеристики
g_fig = figure('Position', [100, 100, 900, 450]);
g_names = {'$g_{11}(t)$', '$g_{12}(t)$', '$g_{21}(t)$', '$g_{22}(t)$'};

idx = 0;
for i = 1:2
    for j = 1:2
        idx = idx + 1;
        subplot(2, 2, idx);
        plot(t_vals, squeeze(g_vals(i,j,:)), 'Color', colors, 'LineWidth', line_width);
        xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
        ylabel('$g(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
        legend(g_names{idx}, 'Location', 'best', 'FontSize', font_size_legend, 'Interpreter', 'latex');
        grid on;
    end
end

% График переходной характеристики
h_fig = figure('Position', [100, 100, 900, 450]);
h_names = {'$h_{11}(t)$', '$h_{12}(t)$', '$h_{21}(t)$', '$h_{22}(t)$'};

idx = 0;
for i = 1:2
    for j = 1:2
        idx = idx + 1;
        subplot(2, 2, idx);
        plot(t_vals, squeeze(h_vals(i,j,:)), 'Color', colors, 'LineWidth', line_width);
        xlabel('$t$', 'Interpreter', 'latex', 'FontSize', font_size_label);
        ylabel('$h(t)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
        legend(h_names{idx}, 'Location', 'best', 'FontSize', font_size_legend, 'Interpreter', 'latex');
        grid on;
    end
end



filename = fullfile(folder, sprintf('g.png'));
saveas(g_fig, filename); close(g_fig);

filename = fullfile(folder, sprintf('h.png'));
saveas(h_fig, filename); close(h_fig);