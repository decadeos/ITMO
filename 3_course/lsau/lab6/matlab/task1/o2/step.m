num = [3 0 -285 -990 552]; den = conv(conv(conv([1 1],[1 2]),[1 3]), conv([1 4],[1 5]));

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
xl = xlim; xlim([-0.01 xl(2)-0.1])
yl = ylim; ylim([yl(1)+0.5 yl(2)-1])


set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf,'../../../images/task1/o2/h-raz.png','Resolution',300)
exportgraphics(gcf,'../../../images/task1/o2/h-raz.pdf','ContentType','vector')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num = [3 0 -285 -990 552]; den = conv(conv(conv([1 -1],[1 -2]),[1 6]), conv([1 7],[1 8]));

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
xl = xlim; xlim([xl(1)-0.01, xl(2)-1])
yl = ylim; ylim([-1.5*10^25, 0.3*10^25])

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf,'../../../images/task1/o2/h-zamk.png','Resolution',300)
exportgraphics(gcf,'../../../images/task1/o2/h-zamk.pdf','ContentType','vector')
