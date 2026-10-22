clc;

addpath('/home/eva/Documents/ITMO/3_course/TAU/config');

colors = [0, 0.5, 0.4; 0, 0, 0.7; 0.8, 0.2, 0.2; 0.85, 0.65, 0.0];

out = sim('model', 'StopTime', '40000');
t = out.x.time(:); 

% x / hat_x
x = squeeze(out.x.signals.values); 
hat_x = squeeze(out.hat_x.signals.values);

% ошибки
tilde_teta = squeeze(out.tilde_teta.signals.values);
abs_x = squeeze(out.abs_x.signals.values);

% x / hat_x
u2_x_hat_x = figure('Color', 'white', 'Position', [100, 100, 900, 400]); hold on;

x_data = {x(:,1), x(:,2), hat_x(:,1), hat_x(:,2)};
x_labels = {'$x_1(t)$', '$x_2(t)$', '$\hat x_{1}(t)$', '$\hat x_{2}(t)$'};
styles = {'-', '-', '--', '-'};

for i = 1:length(x_data)
    plot(t, x_data{i}, ...
        'LineStyle',  styles{i}, 'DisplayName', x_labels{i}, ...
        'Color',      colors(i,:), 'LineWidth',  2.1);
end

setPlotStyle(gca);
legend('Interpreter', 'latex', 'FontSize', 15, 'NumColumns', 2, 'Location','best');
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 15); 
ylabel('$x(t), \hat x(t)$', 'Interpreter', 'latex', 'FontSize', 15); 

limXDown = min(min(x)); limXUp = max(max(x));
ylim([limXDown*1.2; limXUp*1.7]);

fname_x_hat_x = sprintf('../report/images/task2/u2_x_hat_x.pdf');
exportgraphics(u2_x_hat_x, fname_x_hat_x, 'ContentType', 'vector');


% ошибки оценки модуль

u2_abs = figure('Color', 'white', 'Position', [100, 100, 900, 400]); hold on;

abs_x_data = {abs_x(:,1), abs_x(:,2)};
e_labels = {'$|e_1|(t)$', '$|e_2|(t)$'};
styles = {'-', '-'};

for i = 1:length(abs_x_data)
    plot(t, abs_x_data{i}, ...
        'LineStyle',  styles{i}, 'DisplayName', e_labels{i}, ...
        'Color',      colors(i,:), 'LineWidth',  2.1);
end

setPlotStyle(gca);
legend('Interpreter', 'latex', 'FontSize', 15, 'NumColumns', 2, 'Location','best');
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 15); 
ylabel('$e(t)$', 'Interpreter', 'latex', 'FontSize', 15); 
ylim([-1; 37]);

fname_abs = sprintf('../report/images/task2/u2_abs.pdf');
exportgraphics(u2_abs, fname_abs, 'ContentType', 'vector');


% тета / тета хат

u2_teta = figure('Color', 'white', 'Position', [100, 100, 900, 400]); hold on;

data_tilde_teta = {tilde_teta(:,1), tilde_teta(:,2), tilde_teta(:,3), tilde_teta(:,4)};
teta_labels = {'$\tilde \theta_1(t)$', '$\tilde \theta_2(t)$', '$\tilde \theta_3(t)$', '$\tilde \theta_4(t)$'};
styles = {'-', '-', '-', '-'};

for i = 1:length(data_tilde_teta)
    plot(t, data_tilde_teta{i}, ...
        'LineStyle',  styles{i}, 'DisplayName', teta_labels{i}, ...
        'Color',      colors(i,:), 'LineWidth',  2.1);
end

setPlotStyle(gca);
legend('Interpreter', 'latex', 'FontSize', 15, 'NumColumns', 4, 'Location','northeast');
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 15); 
ylabel('$e(t)$', 'Interpreter', 'latex', 'FontSize', 15); 
ylim([-5; 14]);

fname_teta = sprintf('../report/images/task2/u2_teta.pdf');
exportgraphics(u2_teta, fname_teta, 'ContentType', 'vector');