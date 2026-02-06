num = [-10 -2 142 218 372]; den = conv(conv(conv([1 -1],[1 -2]),[1 -3]), conv([1 4],[1 5]));
W = tf(num, den);
w = logspace(-2, 3, 500);

[mag, phase] = bode(W, w);
mag = squeeze(mag);
phase = squeeze(phase);

figure('Color','w','Position',[100 100 900 350])
semilogx(w, 20*log10(mag), 'LineWidth', 2.5, 'Color', [0.85, 0.65, 0])

ax = gca; ax.LineWidth = 1.5; ax.FontSize = 13;
ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
grid on; grid minor; box on;
ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4; 
ax.MinorGridColor = [0.95, 0.95, 0.95];ax.MinorGridAlpha = 0.2;

yline(0.01,'Color',[0.3 0.3 0.3],'LineWidth',1)
xline(8.4382,'Color',[0.3 0.3 0.3],'LineWidth',1)

ylim([-41, 11]);
xlabel('$\omega$', 'Interpreter','latex', 'FontSize',16)
ylabel('$L(\omega)$, dB', 'Interpreter','latex', 'FontSize',16)
legend('$L(\omega)$', 'Location','northeast', 'Interpreter','latex', 'FontSize',16)

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf,'../../../images/task1/o1/lach.png','Resolution',300)
exportgraphics(gcf,'../../../images/task1/o1/lach.pdf','ContentType','vector')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('Color','w','Position',[100 100 900 350])
semilogx(w, phase, 'LineWidth', 2.5, 'Color', [0.85, 0.65, 0])

ax = gca; ax.LineWidth = 1.5; ax.FontSize = 13;
ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
grid on; grid minor; box on;
ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4; 
ax.MinorGridColor = [0.95, 0.95, 0.95];ax.MinorGridAlpha = 0.2;

yline(180,'Color',[0.3 0.3 0.3],'LineWidth',1)
yline(-180,'Color',[0.3 0.3 0.3],'LineWidth',1)
xline(8.4382,'Color',[0.3 0.3 0.3],'LineWidth',1)

xlabel('$\omega$', 'Interpreter','latex', 'FontSize',16)
ylabel('$\varphi(\omega)$, deg', 'Interpreter','latex', 'FontSize',16)
legend('$\varphi(\omega)$', 'Location','northeast', 'Interpreter','latex', 'FontSize',16)

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf,'../../../images/task1/o1/lfch.png','Resolution',300)
exportgraphics(gcf,'../../../images/task1/o1/lfch.pdf','ContentType','vector')


