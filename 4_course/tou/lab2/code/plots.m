clc;

addpath('/home/eva/Documents/ITMO/3_course/TAU/config');

colors = [
    0.8, 0.2, 0.2; 
    0, 0, 0.7; 
     0, 0.5, 0.4; 
    0.85, 0.65, 0.0];

out = sim('model', 'StopTime', '9.2');

t = out.x.time(); 
x = out.x.signals.values; 
u = out.u.signals.values; 
J = out.J.signals.values; 


% x
plotX = figure('Color', 'white', 'Position', [100, 100, 900, 350]); hold on;

x_data = {x(:,1), x(:,2)};
x_labels = {'$x_1(t)$', '$x_2(t)$'};
styles = {'-', '-'};

for i = 1:length(x_data)
    plot(t, x_data{i}, ...
        'LineStyle',  styles{i}, 'DisplayName', x_labels{i}, ...
        'Color',      colors(i,:), 'LineWidth',  2.1);
end


yline(1, '--', 'Color', [0.3, 0, 0.5], 'LineWidth', 2.1, 'DisplayName', '$x_1(9) = 1$', 'Interpreter', 'latex');
yline(0, '--', 'Color', [0.5, 0, 0.8], 'LineWidth', 2.1, 'DisplayName', '$x_2(9) = 0$', 'Interpreter', 'latex');

xline(9, '--', 'Color', [0.3, 0.3, 0.3], 'LineWidth', 2.1, 'DisplayName', '$t=9$', 'Interpreter', 'latex');


setPlotStyle(gca);
legend('Interpreter', 'latex', 'FontSize', 15, 'NumColumns', 1, 'Location','eastoutside');
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 15); 
ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', 15); 

xlim([0, 9.2]); ylim([-0.2, 1.1]); 

fname_x = sprintf('../report/images/x_sim.pdf');
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
legend('Interpreter', 'latex', 'FontSize', 15, 'NumColumns', 1, 'Location','eastoutside');
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 15); 
ylabel('$u(t)$', 'Interpreter', 'latex', 'FontSize', 15); 

xlim([0, 9.2]); ylim([-0.1, 0.6]); 

fname_u = sprintf('../report/images/u_sim.pdf');
exportgraphics(plotU, fname_u, 'ContentType', 'vector');


% J
plotU = figure('Color', 'white', 'Position', [100, 100, 900, 350]); hold on;

j_data = {J(:,1)};
j_labels = {'$J(t)$','Interpreter', 'latex'};
styles = {'-'};

for i = 1:length(u_data)
    plot(t, j_data{i}, ...
        'LineStyle',  styles{i}, 'DisplayName', j_labels{i}, ...
        'Color',      colors(i,:), 'LineWidth',  2.1);
end

yline(15.21, '--', 'Color', [0.5, 0, 0.8], 'LineWidth', 2.1, 'DisplayName', '$J(9) = 15.21$', 'Interpreter', 'latex');
xline(9, '--', 'Color', [0.3, 0.3, 0.3], 'LineWidth', 2.1, 'DisplayName', '$t=9$', 'Interpreter', 'latex');


setPlotStyle(gca);
legend('Interpreter', 'latex', 'FontSize', 15, 'NumColumns', 1, 'Location','eastoutside');
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 15); 
ylabel('$J(t)$', 'Interpreter', 'latex', 'FontSize', 15); 

xlim([0, 9.2]);

fname_J = sprintf('../report/images/J_sim.pdf');
exportgraphics(plotU, fname_J, 'ContentType', 'vector');
