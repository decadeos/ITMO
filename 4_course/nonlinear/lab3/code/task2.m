clc; clear;

A = [-1 1 ; 1 -1]

B = [0 ; 1]

eig(A)

gamma = [-3; -4]

K = acker(A, B, gamma)

eig(A-B*K)




x0 = [-1; -2; -3];
t = [0 5];

% u = x1*x3 - K(1)*x1 - K(2)*x2
nonlinear_sys = @(t, x) [
    -x(1) + x(2);
    x(1)*(1 - K(1)) - x(2)*(1+K(2));
    x(1) + x(1)*x(2) - 2*x(3)
];

[t, X] = ode45(nonlinear_sys, t, x0);




addpath('/home/eva/Documents/ITMO/3_course/TAU/config');

colors = [
    0.8, 0.2, 0.2; 
    0, 0, 0.7; 
     0, 0.5, 0.4; 
    0.85, 0.65, 0.0];

% x
plotX = figure('Color', 'white', 'Position', [100, 100, 900, 350]); hold on;

x_data = {X(:,1), X(:,2), X(:,3)};
x_labels = {'$x_1(t)$', '$x_2(t)$', '$x_3(t)$'};
styles = {'-', '-', '-'};

for i = 1:length(x_data)
    plot(t, x_data{i}, ...
        'LineStyle',  styles{i}, 'DisplayName', x_labels{i}, ...
        'Color',      colors(i,:), 'LineWidth',  2.1);
end


setPlotStyle(gca);
legend('Interpreter', 'latex', 'FontSize', 15, 'NumColumns', 1, 'Location','best');
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 15); 
ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', 15); 


fname_x = sprintf('../report/images/x_sys_2.pdf');
exportgraphics(plotX, fname_x, 'ContentType', 'vector');

