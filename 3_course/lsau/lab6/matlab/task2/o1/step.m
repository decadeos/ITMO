% k = 1;
% num = k * [1 -4]; den = [1 k+8 2-4*k];
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
% yl = ylim; ylim([-1.5*10^25 0.5*10^25]);
% xl = xlim; xlim([-0.03 xl(2)-30])
% 
% set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
% exportgraphics(gcf,'../../../images/task2/o1/h-zamk.png','Resolution',300)
% exportgraphics(gcf,'../../../images/task2/o1/h-zamk.pdf','ContentType','vector')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% k = 1/5;
% num = k * [1 -4]; den = [1 k+8 2-4*k];
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
% % yl = ylim; ylim([-1.5*10^25 0.5*10^25]);
% xl = xlim; xlim([-0.03 xl(2)-7])
% 
% set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
% exportgraphics(gcf,'../../../images/task2/o1/h-zamk2.png','Resolution',300)
% exportgraphics(gcf,'../../../images/task2/o1/h-zamk2.pdf','ContentType','vector')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% k = 0.5;
% num = k * [1 -4]; den = [1 k+8 2-4*k];
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
% % yl = ylim; ylim([-1.5*10^25 0.5*10^25]);
% xl = xlim; xlim([-0.03 xl(2)-50])
% 
% set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
% exportgraphics(gcf,'../../../images/task2/o1/h-zamk3.png','Resolution',300)
% exportgraphics(gcf,'../../../images/task2/o1/h-zamk3.pdf','ContentType','vector')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k = 3/2;
num = k * [1 -4]; den = [1 k+8 2-4*k];
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
legend('$y_{s.r.}(t)$', 'Interpreter','latex', 'Location','northeast', 'FontSize', 25);

yl = ylim; ylim([-10*10^24 2*10^24]);
% xl = xlim; xlim([-0.03 xl(2)-40])

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf,'../../../images/task2/o1/h-zamk4.png','Resolution',300)
exportgraphics(gcf,'../../../images/task2/o1/h-zamk4.pdf','ContentType','vector')