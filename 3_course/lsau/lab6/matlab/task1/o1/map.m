num = [-10 -2 142 218 372]; den = conv(conv(conv([1 -1],[1 -2]),[1 -3]), conv([1 4],[1 5]));

fig = figure('Color', 'white');
W = tf(num, den);
z = zero(W);
p = pole(W);

plot(real(z), imag(z), 'o', ...
    'Color',[0 0 0.7], 'LineWidth',2.5, 'MarkerSize',13)
hold on
plot(real(p), imag(p), 'x', ...
    'Color',[0.8 0.2 0.2], 'LineWidth',2.5, 'MarkerSize',13)

ax = gca; ax.LineWidth = 1.7; ax.FontSize = 15;
ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
grid on; grid minor; box on;
ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4; 
ax.MinorGridColor = [0.95, 0.95, 0.95];ax.MinorGridAlpha = 0.2;
ax.XTick = -5:1:5; ax.YTick = -4:1:4; 
xlim([-5.5 5.5]); ylim([-4.5 4.5]);

xline(0,'Color',[0.3 0.3 0.3],'LineWidth',1)
yline(0,'Color',[0.3 0.3 0.3],'LineWidth',1)

xlabel('Re(s)', 'FontSize', 15, 'FontWeight', 'normal');
ylabel('Im(s)', 'FontSize', 15, 'FontWeight', 'normal');
legend('Zeros','Poles');

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(fig,'../../../images/task1/o1/PZ-plot-raz.png','Resolution',300)
exportgraphics(fig,'../../../images/task1/o1/PZ-plot-raz.pdf','ContentType','vector')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num = [-10 -2 142 218 372]; den = conv(conv(conv([1 1],[1 2]),[1 3]), conv([1 -6],[1 -7]));

figure('Color', 'white')
W = tf(num, den);
z = zero(W);
p = pole(W);

plot(real(z), imag(z), 'o', ...
    'Color',[0 0 0.7], 'LineWidth',2.5, 'MarkerSize',13)
hold on
plot(real(p), imag(p), 'x', ...
    'Color',[0.8 0.2 0.2], 'LineWidth',2.5, 'MarkerSize',13)

ax = gca; ax.LineWidth = 1.7; ax.FontSize = 15;
ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
grid on; grid minor; box on;
ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4; 
ax.MinorGridColor = [0.95, 0.95, 0.95];ax.MinorGridAlpha = 0.2;
xlim([-4.1 7.5])
ax.XTick = -4:1:7;

ylim([-4.5 4.5])
ax.YTick = -4:1:4;

xline(0,'Color',[0.3 0.3 0.3],'LineWidth',1)
yline(0,'Color',[0.3 0.3 0.3],'LineWidth',1)

xlabel('Re(s)', 'FontSize', 15, 'FontWeight', 'normal');
ylabel('Im(s)', 'FontSize', 15, 'FontWeight', 'normal');
legend('Zeros','Poles');

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf,'../../../images/task1/o1/PZ-plot-zamk.png','Resolution',300)
exportgraphics(gcf,'../../../images/task1/o1/PZ-plot-zamk.pdf','ContentType','vector')