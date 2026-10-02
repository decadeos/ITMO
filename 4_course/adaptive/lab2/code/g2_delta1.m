clc;

addpath('/home/eva/Documents/ITMO/3_course/TAU/config');

colors = [0, 0.5, 0.4; 0, 0, 0.7; 0.8, 0.2, 0.2; 0.85, 0.65, 0.0];
gamma_list = [500, 5000];
sigma_list = [0.05, 0.005];


for k = 1:length(sigma_list)
    for j = 1:length(gamma_list)
    
        % моделирование
    
        gamma = gamma_list(j);
        sigma = sigma_list(k);
    
        out = sim('model1', 'StopTime', '50');
        t = out.x.time(:); 
        
        x = squeeze(out.x.signals.values)'; 
        xM = squeeze(out.xM.signals.values);
        e = squeeze(out.e.signals.values)';
        teta_2 = squeeze(out.teta_2.signals.values)';
        
        % x / xM
        
        x_delta1 = figure('Color', 'white', 'Position', [100, 100, 900, 400]); hold on;
        
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
    
        fname_x = sprintf('../report/images/task2/x_delta1_sigma%g_gamma%d.pdf', sigma, gamma);
        exportgraphics(x_delta1, fname_x, 'ContentType', 'vector');
        close(x_delta1);
        
        % e
        
        e_delta1 = figure('Color', 'white', 'Position', [100, 100, 900, 400]); hold on;
        
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
        ylim([limEDown*1.1; limEUp*1.1]);
        
        fname_e = sprintf('../report/images/task2/e_delta1_sigma%g_gamma%d.pdf', sigma, gamma);
        exportgraphics(e_delta1, fname_e, 'ContentType', 'vector');
        close(e_delta1);


        % \til_teta = teta - teta_2

        til_teta = teta - teta_2;
        
        til_teta1 = figure('Color', 'white', 'Position', [100, 100, 900, 400]); hold on;
        
        til_teta_data = {til_teta(:,1), til_teta(:,2)}; 
        til_teta_labels = {'$\tilde{\theta_1}(t)$', '$\tilde{\theta_2}(t)$'};
        
        for i = 1:length(til_teta_data)
            plot(t, til_teta_data{i}, ...
                'DisplayName', til_teta_labels{i}, 'Color', colors(i+2,:), 'LineWidth',  2.1);
        end

        setPlotStyle(gca);
        legend('Interpreter', 'latex', 'FontSize', 15, 'NumColumns', 2, 'Location','best');
        xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 15); 
        ylabel('$\tilde{\theta}(t)$', 'Interpreter', 'latex', 'FontSize', 15); 
        
        limTDown = min(min(til_teta)); limTUp = max(max(til_teta));
        ylim([limTDown*1.1; limTUp*1.1]);

        fname_t = sprintf('../report/images/task2/t_delta1_sigma%g_gamma%d.pdf', sigma, gamma);
        exportgraphics(til_teta1, fname_t, 'ContentType', 'vector');
        close(til_teta1);

    end
end

    