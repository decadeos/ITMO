num = [-10 -2 142 218 372]; den = conv(conv(conv([1 -1],[1 -2]),[1 -3]), conv([1 4],[1 5]));
W_open = tf(num, den);

[y,t] = step(W_open);

figure('Color','w','Position',[100 100 900 400])
plot(t, y, 'LineWidth', 2.5, 'Color', [0.8 0.2 0.2])

ax = gca; ax.LineWidth = 1.5; ax.FontSize = 13;
ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
grid on; grid minor; box on;
ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4; 
ax.MinorGridColor = [0.95, 0.95, 0.95];ax.MinorGridAlpha = 0.2;

xlabel('Time', 'FontSize', 13, 'FontWeight', 'normal');
ylabel('Amplitude', 'FontSize', 13, 'FontWeight', 'normal');
legend('$y_{s.r.}(t)$', 'Interpreter','latex', 'Location','northwest', 'FontSize', 15);
xl = xlim; xlim([-0.03 xl(2)-0.6])

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf,'../../../images/task1/o1/h-raz.png','Resolution',300)
exportgraphics(gcf,'../../../images/task1/o1/h-raz.pdf','ContentType','vector')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num = [-10 -2 142 218 372]; den = conv(conv(conv([1 1],[1 2]),[1 3]), conv([1 -6],[1 -7]));
W_open = tf(num, den);

[y,t] = step(W_open);

figure('Color','w','Position',[100 100 900 400])
plot(t, y, 'LineWidth', 2.5, 'Color', [0.8 0.2 0.2])

ax = gca; ax.LineWidth = 1.5; ax.FontSize = 13;
ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
grid on; grid minor; box on;
ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4; 
ax.MinorGridColor = [0.95, 0.95, 0.95];ax.MinorGridAlpha = 0.2;

xlabel('Time', 'FontSize', 13, 'FontWeight', 'normal');
ylabel('Amplitude', 'FontSize', 13, 'FontWeight', 'normal');
legend('$y_{s.r.}(t)$', 'Interpreter','latex', 'Location','northwest', 'FontSize', 15);
xl = xlim; xlim([xl(1)-0.01, xl(2)-0.7])
yl = ylim; ylim([-2.5*10^25, 0.5*10^25])

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf,'../../../images/task1/o1/h-zamk.png','Resolution',300)
exportgraphics(gcf,'../../../images/task1/o1/h-zamk.pdf','ContentType','vector')
