% k = 1;
% num = k * [10 9 -1]; den = [10 10*k-12 9*k-1 4-k];
% W_open = tf(num, den);
% 
% [y,t] = step(W_open);
% 
% figure('Color','w','Position',[100 100 900 500])
% plot(t, y, 'LineWidth', 2.5, 'Color', [0.8 0.2 0.2])
% 
% ax = gca; ax.LineWidth = 1.5; ax.FontSize = 20;
% ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
% grid on; grid minor; box on;
% ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4; 
% ax.MinorGridColor = [0.95, 0.95, 0.95];ax.MinorGridAlpha = 0.2;
% 
% xlabel('Time', 'FontSize', 25, 'FontWeight', 'normal');
% ylabel('Amplitude', 'FontSize', 25, 'FontWeight', 'normal');
% legend('$y_{s.r.}(t)$', 'Interpreter','latex', 'Location','northwest', 'FontSize', 25);
% 
% yl = ylim; ylim([-4.5*10^12 yl(2)]);
% xl = xlim; xlim([-0.03 113])
% 
% set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
% exportgraphics(gcf,'../../../images/task2/o2/h-zamk.png','Resolution',300)
% exportgraphics(gcf,'../../../images/task2/o2/h-zamk.pdf','ContentType','vector')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k = 2;
num = k * [10 9 -1]; den = [10 -12 -1 4];
W_open = tf(num, den);

[y,t] = step(W_open);

figure('Color','w','Position',[100 100 900 500])
plot(t, y, 'LineWidth', 2.5, 'Color', [0.8 0.2 0.2])

ax = gca; ax.LineWidth = 1.5; ax.FontSize = 20;
ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
grid on; grid minor; box on;
ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4; 
ax.MinorGridColor = [0.95, 0.95, 0.95];ax.MinorGridAlpha = 0.2;

xlabel('Time', 'FontSize', 25, 'FontWeight', 'normal');
ylabel('Amplitude', 'FontSize', 25, 'FontWeight', 'normal');
legend('$y_{s.r.}(t)$', 'Interpreter','latex', 'Location','northwest', 'FontSize', 25);

% yl = ylim; ylim([-1.5 2.5]);
% xl = xlim; xlim([-0.03 53.3])

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
% exportgraphics(gcf,'../../../images/task2/o2/h-zamk2.png','Resolution',300)
% exportgraphics(gcf,'../../../images/task2/o2/h-zamk2.pdf','ContentType','vector')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% k = 4;
% num = k * [10 9 -1]; den = [10 10*k-12 9*k-1 4-k];
% W_open = tf(num, den);
% 
% [y,t] = step(W_open);
% 
% figure('Color','w','Position',[100 100 900 500])
% plot(t, y, 'LineWidth', 2.5, 'Color', [0.8 0.2 0.2])
% 
% ax = gca; ax.LineWidth = 1.5; ax.FontSize = 20;
% ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
% grid on; grid minor; box on;
% ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4; 
% ax.MinorGridColor = [0.95, 0.95, 0.95];ax.MinorGridAlpha = 0.2;
% 
% xlabel('Time', 'FontSize', 25, 'FontWeight', 'normal');
% ylabel('Amplitude', 'FontSize', 25, 'FontWeight', 'normal');
% legend('$y_{s.r.}(t)$', 'Interpreter','latex', 'Location','northeast', 'FontSize', 25);
% 
% xl = xlim; xlim([-1 5700])
% 
% set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
% exportgraphics(gcf,'../../../images/task2/o2/h-zamk3.png','Resolution',300)
% exportgraphics(gcf,'../../../images/task2/o2/h-zamk3.pdf','ContentType','vector')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% k = 7;
% num = k * [10 9 -1]; den = [10 10*k-12 9*k-1 4-k];
% W_open = tf(num, den);
% 
% [y,t] = step(W_open);
% 
% figure('Color','w','Position',[100 100 900 500])
% plot(t, y, 'LineWidth', 2.5, 'Color', [0.8 0.2 0.2])
% 
% ax = gca; ax.LineWidth = 1.5; ax.FontSize = 20;
% ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
% grid on; grid minor; box on;
% ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4; 
% ax.MinorGridColor = [0.95, 0.95, 0.95];ax.MinorGridAlpha = 0.2;
% 
% xlabel('Time', 'FontSize', 25, 'FontWeight', 'normal');
% ylabel('Amplitude', 'FontSize', 25, 'FontWeight', 'normal');
% legend('$y_{s.r.}(t)$', 'Interpreter','latex', 'Location','northwest', 'FontSize', 25);
% 
% yl = ylim; ylim([-10*10^24 2*10^24]);
% xl = xlim; xlim([-0.03 1300])
% 
% set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
% exportgraphics(gcf,'../../../images/task2/o2/h-zamk4.png','Resolution',300)
% exportgraphics(gcf,'../../../images/task2/o2/h-zamk4.pdf','ContentType','vector')