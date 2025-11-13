W = tf([3],[1 7.5 2]); 

num_H = [6.34375 8.6328125 4.07820638020833];
den_H = [1 0 0.0625];
H = tf(num_H, den_H);

sys_cl = feedback(W*H, 1); 

A = 4;
w = 0.25;
t_sim = (0:0.01:40)';
g = A * sin(w * t_sim);

[y, t] = lsim(sys_cl, g, t_sim);
e = g - y;

%% --- График g(t) и y(t) ---
figure('Position', [100 100 900 400]);
plot(t, g, 'Color', [0.8 0.2 0.2], 'LineStyle', '-', 'LineWidth', 2.5, 'DisplayName', 'g(t)');
hold on;
plot(t, y, 'Color', [0, 0, 0.7], 'LineStyle', '--', 'LineWidth', 2.5, 'DisplayName', 'y(t)');

ax = gca; ax.LineWidth = 1.5; ax.FontSize = 12;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
grid on; grid minor; box on; 
ylim([-6, 6]);

xlabel('Time');
ylabel('Amplitude');
legend('g(t)', 'y(t)', 'Location','northeast','FontSize',13,'NumColumns',1);

%% --- График ошибки e(t) ---
figure('Position', [150 150 900 400]);

% Полоса допуска ±5% (заполненная область)
eps_band = 0.05 * A;  % 5% от амплитуды входного сигнала (A=4 → 0.2)
hold on;
fill([t; flipud(t)], [eps_band*ones(size(t)); -eps_band*ones(size(t))], ...
     [1 0.6 0.6], 'FaceAlpha', 0.4, 'EdgeColor', 'none', ...
     'DisplayName', '±5% region');

% График ошибки
plot(t, e, 'Color', [0.8 0.2 0.2], 'LineStyle', '-', ...
    'LineWidth', 2.5, 'DisplayName', 'e(t)');

% Оформление осей и сетки
ax = gca; 
ax.LineWidth = 1.5; ax.FontSize = 12;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
grid on; grid minor; box on; 
ylim([-0.3, 0.45]);

xlabel('Time');
ylabel('e(t)');
legend('Location','northeast','FontSize',13,'NumColumns',1);


