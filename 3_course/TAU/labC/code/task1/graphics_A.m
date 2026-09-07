clc;
colors = [0, 0, 0.7]; 
line_width = 2.5;
font_size_label = 13;
font_size_legend = 15;

folder = '../../report/images/task1';


%% Частотные характеристики
syms s omega real

A = [0  1;
    -3  4];

B = [3  -5;
     2   0];

C = [4  1;
    -2   0];





% Передаточная матрица
W = C * inv(s*eye(2) - A) * B;
W = simplify(W);

% Подстановка s = j*omega
W_jw = simplify(subs(W, s, 1i*omega));

% АЧХ и ФЧХ
A_ach = simplify(abs(W_jw));
phi_fch = simplify(angle(W_jw));

% Частотный диапазон
omega_vals = logspace(-1, 2, 500);
n_omega = length(omega_vals);

% Вычисление АЧХ через цикл
A_vals = zeros(2, 2, n_omega);
phi_vals = zeros(2, 2, n_omega);

for k = 1:n_omega
    A_vals(:,:,k) = double(subs(A_ach, omega, omega_vals(k)));
    phi_vals(:,:,k) = double(subs(phi_fch, omega, omega_vals(k)));
end

% Извлечение компонент
A11 = squeeze(A_vals(1,1,:));
A12 = squeeze(A_vals(1,2,:));
A21 = squeeze(A_vals(2,1,:));
A22 = squeeze(A_vals(2,2,:));

phi11 = squeeze(phi_vals(1,1,:));
phi12 = squeeze(phi_vals(1,2,:));
phi21 = squeeze(phi_vals(2,1,:));
phi22 = squeeze(phi_vals(2,2,:));

% График АЧХ
ach_fig = figure('Position', [100, 100, 900, 450]);
ach_names = {'$A_{11}(\omega)$', '$A_{12}(\omega)$', '$A_{21}(\omega)$', '$A_{22}(\omega)$'};
ach_data = {A11, A12, A21, A22};

for idx = 1:4
    subplot(2, 2, idx);
    plot(omega_vals, ach_data{idx}, 'Color', colors, 'LineWidth', line_width);
    xlabel('$\omega$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    ylabel('$A(\omega)$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    legend(ach_names{idx}, 'Location', 'best', 'FontSize', font_size_legend, 'Interpreter', 'latex');
    grid on;
end

% График ЛАЧХ
lach_fig = figure('Position', [100, 100, 900, 450]);
lach_names = {'$L_{11}(\omega)$', '$L_{12}(\omega)$', '$L_{21}(\omega)$', '$L_{22}(\omega)$'};
lach_data = {20*log10(A11), 20*log10(A12), 20*log10(A21), 20*log10(A22)};

for idx = 1:4
    subplot(2, 2, idx);
    semilogx(omega_vals, lach_data{idx}, 'Color', colors, 'LineWidth', line_width);
    xlabel('$\omega$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    ylabel('$L(\omega), dB$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    legend(lach_names{idx}, 'Location', 'best', 'FontSize', font_size_legend, 'Interpreter', 'latex');
    grid on;
end

% График ФЧХ
fch_fig = figure('Position', [100, 100, 900, 450]);
fch_names = {'$\phi_{11}(\omega)$', '$\phi_{12}(\omega)$', '$\phi_{21}(\omega)$', '$\phi_{22}(\omega)$'};
fch_data = {rad2deg(phi11), rad2deg(phi12), rad2deg(phi21), rad2deg(phi22)};

for idx = 1:4
    subplot(2, 2, idx);
    semilogx(omega_vals, fch_data{idx}, 'Color', colors, 'LineWidth', line_width);
    xlabel('$\omega$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    ylabel('$\phi(\omega)$, deg', 'Interpreter', 'latex', 'FontSize', font_size_label);
    legend(fch_names{idx}, 'Location', 'best', 'FontSize', font_size_legend, 'Interpreter', 'latex');
    grid on;
end

% График ЛФЧХ (то же что ФЧХ, но отдельный рисунок для отчёта)
lfch_fig = figure('Position', [100, 100, 900, 450]);
lfch_names = {'$L\phi_{11}(\omega)$', '$L\phi_{12}(\omega)$', '$L\phi_{21}(\omega)$', '$L\phi_{22}(\omega)$'};
lfch_data = {rad2deg(phi11), rad2deg(phi12), rad2deg(phi21), rad2deg(phi22)};

for idx = 1:4
    subplot(2, 2, idx);
    semilogx(omega_vals, lfch_data{idx}, 'Color', colors, 'LineWidth', line_width);
    xlabel('$\omega$', 'Interpreter', 'latex', 'FontSize', font_size_label);
    ylabel('$\phi(\omega)$, deg', 'Interpreter', 'latex', 'FontSize', font_size_label);
    legend(lfch_names{idx}, 'Location', 'best', 'FontSize', font_size_legend, 'Interpreter', 'latex');
    grid on;
end


filename = fullfile(folder, sprintf('ach.png'));
saveas(ach_fig, filename); close(ach_fig);

filename = fullfile(folder, sprintf('lach.png'));
saveas(lach_fig, filename); close(lach_fig);

filename = fullfile(folder, sprintf('fch.png'));
saveas(fch_fig, filename); close(fch_fig);

filename = fullfile(folder, sprintf('lfch.png'));
saveas(lfch_fig, filename); close(lfch_fig);