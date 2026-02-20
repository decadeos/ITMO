t = 2;
num = [8 4 2.4]; den = [10 -5 11];
W = tf(num, den, 'InputDelay',t); w = logspace(-2, 3, 5000);

figure('Color','w','Position',[100 100 600 400])
nyquist(W, w)
h = findobj(gca,'Type','line');
set(h,'LineWidth',1,'Color',[0, 0.5, 0.4])

h_patch = findall(gca,'Type','patch');
set(h_patch,'LineWidth',1.5)
set(h_patch,'EdgeColor',[0 0.5 0.4])
h_mark = findall(gca,'Type','line','-property','Marker');
set(h_mark,'LineWidth',2,'MarkerSize',15)

xl = xlim; xlim([xl(1)-0.1 xl(2)+0.1])
ax = gca; ax.LineWidth = 1.5; ax.FontSize = 13;
ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3]; box on;
ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4; 
ax.MinorGridColor = [0.95, 0.95, 0.95];ax.MinorGridAlpha = 0.1;

ax = findall(gcf,'Type','axes');
set(get(ax(1),'XLabel'),'FontSize',12)
set(get(ax(1),'YLabel'),'FontSize',12)
set(get(ax(1),'Title'),'FontSize',14)

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf,'../../../images/task3/o2/GNA5.pdf','ContentType','vector')