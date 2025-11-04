num_W = [3]; 
den_W = [1 7.5 2]; 
W = tf(num_W, den_W); 
A = 4; 
w = 0.25; 
w0 = 0.5; 
a3 = 1; 
a0_tilde = 2.5 - 7.5; % = -5 
b3 = (2.5 - (2 + 7.5*a0_tilde + 0.0625*a3)) / 3; 
b2 = (1.25 - (2*a0_tilde + 0.46875*a3 + 0.0625*a0_tilde)) / 3; 
b1 = (0.3125 - (0.125*a3 + 0.46875*a0_tilde)) / 3; 
b0 = (0.03125 - (0.125*a0_tilde)) / 3; 
a2 = a0_tilde; 
a1 = 0.0625 * a3; 
a0 = 0.0625 * a0_tilde; 
num_H = [b3 b2 b1 b0]; 
den_H = [a3 a2 a1 a0]; 
H = tf(num_H, den_H); 
t_sim = 0:0.01:100; 
g = A*sin(w*t_sim); 
sys_cl = feedback(W*H, 1); 
[y, t] = lsim(sys_cl, g, t_sim);

line_styles = {
    {'Color', [0.85, 0.65, 0], 'LineStyle', '-', 'LineWidth', 2.5},
    {'Color', [0, 0.5, 0.4], 'LineStyle', '--', 'LineWidth', 2.5},
    {'Color', [0, 0, 0.7], 'LineStyle', '-', 'LineWidth', 2.5}, 
    {'Color', [0.8, 0.2, 0.2], 'LineStyle', '--', 'LineWidth', 2.5}, 
};

figure('Position', [100 100 800 400]);
hold on;

plot(t, y, line_styles{3}{:});
plot(t, g, line_styles{4}{:});

ax = gca; ax.LineWidth = 1.5; ax.FontSize = 12;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
grid on; grid minor; box on; 

xlabel('Time'); ylabel('Amplitude');

legend('1', '2', 'Location','northeast','FontSize',13,'NumColumns',1);

