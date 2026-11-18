clc;

addpath('/home/eva/Documents/ITMO/3_course/TAU/config');

K = r^-1 * b' * P*0.85

eig(A - b*K)


colors = [
    0.8, 0.2, 0.2; 
    0, 0, 0.7; 
     0, 0.5, 0.4; 
    0.85, 0.65, 0.0];

out = sim('model', 'StopTime', '5');

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

ylim([-0.25, 1.05]);


setPlotStyle(gca);
legend('Interpreter', 'latex', 'FontSize', 15, 'NumColumns', 1, 'Location','northeast');
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 15); 
ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', 15); 


fname_x = sprintf('../report/images/task3/x.pdf');
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

ylim([-1.05, 0.05]);

setPlotStyle(gca);
legend('Interpreter', 'latex', 'FontSize', 15, 'NumColumns', 1, 'Location','southeast');
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 15); 
ylabel('$u(t)$', 'Interpreter', 'latex', 'FontSize', 15); 

fname_u = sprintf('../report/images/task3/u.pdf');
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

ylim([-0.05, 1.05]);

setPlotStyle(gca);
legend('Interpreter', 'latex', 'FontSize', 15, 'NumColumns', 1, 'Location','southeast');
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 15); 
ylabel('$J(t)$', 'Interpreter', 'latex', 'FontSize', 15); 

fname_J = sprintf('../report/images/task3/J.pdf');
exportgraphics(plotJ, fname_J, 'ContentType', 'vector');
