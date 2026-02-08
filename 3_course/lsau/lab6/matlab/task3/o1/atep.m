t = 1/2 ;
num = [9 2]; den = [1 6 1];
W = tf(num, den, 'InputDelay',t); 
t2 = linspace(0,10,50000);  T = feedback(W,1);

[y,t] = step(T, t2);

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

% yl = ylim; ylim([-1.5*10^25 0.5*10^25]);
xl = xlim; xlim([-0.03 10])

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf,'../../../images/task3/o1/h-zamk15.png','Resolution',300)
exportgraphics(gcf,'../../../images/task3/o1/h-zamk15.pdf','ContentType','vector')