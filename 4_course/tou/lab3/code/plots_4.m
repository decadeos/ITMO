clc;

Q_star = [2 0; 0 3];
experiments = {
    2*Q_star,  4;
    Q_star,    10;
    5*Q_star,  0.5
};

for j = 1:length(experiments)

    Q = experiments{j, 1};
    r = experiments{j, 2};

    [P, ~, ~] = icare(A, b, Q, r);

    K = r^-1 * b' * P;
    eig(A - b*K);
    
    J_min = x0' * P * x0;
    
    K
    P
    e = eig(A-b*K)
    J_min

    out = sim('model', 'StopTime', '5');

    t = out.x.time(); 
    x = out.x.signals.values; 
    u = out.u.signals.values; 
    J = out.J.signals.values; 

    plotX = figure('Color', 'white', 'Position', [100, 100, 900, 350]); hold on;
    
    x_data = {x(:,1), x(:,2)};
    x_labels = {'$x_1(t)$', '$x_2(t)$'};
    styles = {'-', '-'};
    
    for i = 1:length(x_data)
        plot(t, x_data{i}, ...
            'LineStyle',  styles{i}, 'DisplayName', x_labels{i}, ...
            'Color',      colors(i,:), 'LineWidth',  2.1);
    end
    
    setPlotStyle(gca);
    legend('Interpreter', 'latex', 'FontSize', 15, 'NumColumns', 1, 'Location','northeast');
    xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 15); 
    ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', 15); 

    ylim_auto = ylim;
    y_range = ylim_auto(2) - ylim_auto(1);
    ylim([ylim_auto(1) - 0.05 * y_range, ylim_auto(2) + 0.05 * y_range]); 
    
    fname_x = sprintf('../report/images/task4/x_%d.pdf', j);
    exportgraphics(plotX, fname_x, 'ContentType', 'vector');
    
    
    % u
    plotU = figure('Color', 'white', 'Position', [100, 100, 900, 350]); hold on;
    
    u_data = {u(:,1)};
    u_labels = {'$u(t)$', 'Interpreter', 'latex'};
    styles = {'-'};
    
    for i = 1:length(u_data)
        plot(t, u_data{i}, ...
            'LineStyle',  styles{i}, 'DisplayName', u_labels{i}, ...
            'Color',      colors(i,:), 'LineWidth',  2.1);
    end
    
    setPlotStyle(gca);
    legend('Interpreter', 'latex', 'FontSize', 15, 'NumColumns', 1, 'Location','southeast');
    xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 15); 
    ylabel('$u(t)$', 'Interpreter', 'latex', 'FontSize', 15);

    ylim_auto = ylim;
    y_range = ylim_auto(2) - ylim_auto(1);
    ylim([ylim_auto(1) - 0.05 * y_range, ylim_auto(2) + 0.05 * y_range]); 
    
    fname_u = sprintf('../report/images/task4/u_%d.pdf', j);
    exportgraphics(plotU, fname_u, 'ContentType', 'vector');
    
    
    % J
    plotJ = figure('Color', 'white', 'Position', [100, 100, 900, 350]); hold on;
    
    j_data = {J(:,1)};
    j_labels = {'$J(t)$','Interpreter', 'latex'};
    styles = {'-'};
    
    for i = 1:length(u_data)
        plot(t, j_data{i}, ...
            'LineStyle',  styles{i}, 'DisplayName', j_labels{i}, ...
            'Color',      colors(i+2,:), 'LineWidth',  2.1);
    end
    

    yline(J_min, '--', 'Color', [0.3, 0.3, 0.3], 'LineWidth', 2.1, 'DisplayName', sprintf('$J_{min} = %.2f$', J_min), 'Interpreter', 'latex');
    
    setPlotStyle(gca);
    legend('Interpreter', 'latex', 'FontSize', 15, 'NumColumns', 1, 'Location','southeast');
    xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 15); 
    ylabel('$J(t)$', 'Interpreter', 'latex', 'FontSize', 15); 

    ylim_auto = ylim;
    y_range = ylim_auto(2) - ylim_auto(1);
    ylim([ylim_auto(1) - 0.05 * y_range, ylim_auto(2) + 0.05 * y_range]); 
    
    fname_J = sprintf('../report/images/task4/J_%d.pdf', j);
    exportgraphics(plotJ, fname_J, 'ContentType', 'vector');


end