clc;

addpath('/home/eva/Documents/ITMO/3_course/TAU/config');

colors = [0, 0.5, 0.4; 0, 0, 0.7; 0.8, 0.2, 0.2; 0.85, 0.65, 0.0];
gamma_list = [50, 500, 5000];

for j = 1:length(gamma_list)

    % моделирование

    gamma = gamma_list(j);

    out = sim('model1', 'StopTime', '50');
    t = out.x.time(:); 
    
    x = squeeze(out.x.signals.values)'; 
    xM = squeeze(out.xM.signals.values);
    e = squeeze(out.e.signals.values)'; 
    
    % x / xM
    
    x_delta0 = figure('Color', 'white', 'Position', [100, 100, 900, 400]); hold on;
    
    x_data = {x(:,1), x(:,2), xM(:,1), xM(:,2)};
    x_labels = {'$x_1(t)$', '$x_2(t)$', '$x_{M1}(t)$', '$x_{M2}(t)$'};
    styles = {'-', '-', '-', '--'};
    
    for i = 1:length(x_data)
        plot(t, x_data{i}, ...
            'LineStyle',  styles{i}, 'DisplayName', x_labels{i}, ...
            'Color',      colors(i,:), 'LineWidth',  2.1);
    end
    
    setPlotStyle(gca);
    legend('Interpreter', 'latex', 'FontSize', 15, 'NumColumns', 2, 'Location','best');
    xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 15); 
    ylabel('$x(t), x_M(t)$', 'Interpreter', 'latex', 'FontSize', 15); 

    limXDown = min(min(x)); limXUp = max(max(x));
    ylim([limXDown*1.1; limXUp*1.2]);

    fname_x = sprintf('../report/images/task1/x_delta0_%d.pdf', gamma);
    exportgraphics(x_delta0, fname_x, 'ContentType', 'vector');
    close(x_delta0);
    
    % e
    
    e_delta0 = figure('Color', 'white', 'Position', [100, 100, 900, 400]); hold on;
    
    e_data = {e(:,1), e(:,2)}; e_labels = {'$e_1(t)$', '$e_2(t)$'};
    
    for i = 1:length(e_data)
        plot(t, e_data{i}, ...
            'DisplayName', e_labels{i}, 'Color', colors(i+2,:), 'LineWidth',  2.1);
    end
    
    setPlotStyle(gca);
    legend('Interpreter', 'latex', 'FontSize', 15, 'NumColumns', 2);
    xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 15); 
    ylabel('$e(t)$', 'Interpreter', 'latex', 'FontSize', 15); 

    limEDown = min(min(e)); limEUp = max(max(e));
    ylim([limEDown*1.1; limEUp*10]);
    
    fname_e = sprintf('../report/images/task1/e_delta0_%d.pdf', gamma);
    exportgraphics(e_delta0, fname_e, 'ContentType', 'vector');
    close(e_delta0);

end


