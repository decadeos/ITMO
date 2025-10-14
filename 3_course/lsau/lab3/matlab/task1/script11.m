a0 = 57.41;
a1 = 5.8;

y0 = -1;
y0_values = [-1, 0, 1];
dy0 = 0;

t = 0:0.01:10;

u = [t' 0.5 * ones(length(t), 1)];
% u = [t' 0.8 * t'];
% u = [t' cos(2 * t')];

assignin('base', 'a1', a1);
assignin('base', 'a0', a0);
assignin('base', 'y0', y0);
assignin('base', 'dy0', dy0);
assignin('base', 'u', u);
sim('model1');

figure('Color', 'white', 'Position', [100, 100, 900, 400]);
hold on;
grid on;

ax = gca;
ax.LineWidth = 1.5;
ax.FontSize = 13;
ax.FontName = 'DejaVuMathTeXGyre';
ax.XColor = [0.3, 0.3, 0.3];
ax.YColor = [0.3, 0.3, 0.3];
grid on; grid minor;
ax.GridColor = [0.9, 0.9, 0.9];
ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95, 0.95, 0.95];
ax.MinorGridAlpha = 0.2;
xlim([0, 4]);
box on;

line_styles = {
    {'Color', [0, 0, 0.7], 'LineStyle', '--', 'LineWidth', 2.5},  % первый: синий пунктир
    {'Color', [0.8, 0.2, 0.2], 'LineStyle', '-', 'LineWidth', 2.5},  % второй: красный сплошной
    {'Color', [0, 0.5, 0.4], 'LineStyle', '-.', 'LineWidth', 2.5}     % третий: еленый штрих-пунктир
};

for i = 1:length(y0_values)
    y0 = y0_values(i);
    assignin('base', 'y0', y0);
    
    out = sim('model1', 'ReturnWorkspaceOutputs', 'on');
    
    y = out.y;
    t_out = out.tout;
    
    plot(t_out, y.signals.values, line_styles{i}{:});
end

xlabel('Time', 'FontSize', 15, 'FontWeight', 'normal');
ylabel('Amplitude', 'FontSize', 15, 'FontWeight', 'normal');
legend({'$y(0) = 1; \quad \dot{y}(0) = 0$', '$y(0) = 0; \quad \dot{y}(0) = 0$', '$y(0) = -1; \quad \dot{y}(0) = 0$'}, 'Interpreter', 'latex', 'Location', 'northeast', 'FontSize', 15, 'FontName', 'DejaVuMathTeXGyre');

hold off;

% relativePath = fullfile('../../images/task1', 'model1.png');
% print('-smodel1', '-dpng', '-r300', relativePath) % сохранение пнг

exportgraphics(gcf, '../../images/task1/y11.png', 'Resolution', 300);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


