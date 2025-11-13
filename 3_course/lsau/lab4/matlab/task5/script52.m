k_combinations = [
    1.0, 0.5;
    1.0, 1;
    2.0, 0.5;
    2.0, 1;
];

t = 0:0.01:80;
g = [t' 4 * sin(0.25 * t')];
assignin('base','g', g);

figure('Color','white','Position',[100,100,900,400]);
hold on;

line_styles = {
    {'Color', [0.85, 0.65, 0], 'LineStyle', '-', 'LineWidth', 2.5}, % Gold
    {'Color', [0, 0.5, 0.4], 'LineStyle', '--', 'LineWidth', 2.5} % green
    {'Color', [0, 0, 0.7], 'LineStyle', '-', 'LineWidth', 2.5},  % blue
    {'Color', [0.8, 0.2, 0.2], 'LineStyle', '--', 'LineWidth', 2.5},  % red
};

plot(t, 4 * sin(0.25 * t), ':', 'LineWidth', 2.5, 'Color', [0.3, 0.3, 0.3]);
for i = 1:size(k_combinations, 1)
    ki = k_combinations(i, 1);
    kp = k_combinations(i, 2);

    assignin('base','ki', ki);
    assignin('base','kp', kp);

    out = sim('model51');

    t_sim = out.y.time;
    y = out.y.signals.values;

    plot(t_sim, y, line_styles{i}{:});
end

xlabel('Time');
ylabel('y(t)');

legendStrings = arrayfun(@(i) sprintf('k_i=%.0f, k_p=%.1f', ...
    k_combinations(i,1), k_combinations(i,2)), ...
    1:size(k_combinations,1), 'UniformOutput', false);
legendStrings = [{'g(t)=4 sin(0.25t)'}, legendStrings];
legend(legendStrings, 'Location','northeast','FontSize',13,'NumColumns',1);

ax = gca;
ax.LineWidth = 1.5; ax.FontSize = 12;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
xlim([-0.05 80.05]); ylim([-5.05 13.05]);
grid on; grid minor; box on;

set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../images/task5/y2.png', 'Resolution', 300);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Color', 'white', 'Position', [100, 100, 900, 400]);
hold on;
 
for i = 1:size(k_combinations, 1)
    ki = k_combinations(i, 1);
    kp = k_combinations(i, 2);

    assignin('base','ki', ki);
    assignin('base','kp', kp);

    out = sim('model51');

    t = out.e.time;
    e = out.e.signals.values;
    plot(t, e, line_styles{i}{:});
end

xlabel('Time');
ylabel('e(t)');

legendStrings = arrayfun(@(i) sprintf('e_%d', i), ...
    1:size(k_combinations,1), 'UniformOutput', false);
legend(legendStrings, 'Location','northeast','FontSize',13, NumColumns=2);

ax = gca;
ax.LineWidth = 1.5; ax.FontSize = 12;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
xlim([-0.05 80.05]); ylim([-1.35 2.05]);
grid on; grid minor; box on;

set(findall(gcf,'-property','FontName'),'FontName','DejaVu Math TeX Gyre');
% exportgraphics(gcf, '../../images/task5/e2.png', 'Resolution', 300);