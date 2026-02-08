% t = 1/3;
% num = [9 2]; den = [1 6 1];
% W = tf(num, den, 'InputDelay',t); w = logspace(-2, 3, 5000);
% 
% figure('Color','w','Position',[100 100 600 400])
% nyquist(W, w)
% h = findobj(gca,'Type','line');
% set(h,'LineWidth',2,'Color',[0, 0.5, 0.4])
% 
% h_patch = findall(gca,'Type','patch');
% set(h_patch,'LineWidth',3.5)
% set(h_patch,'EdgeColor',[0 0.5 0.4])
% h_mark = findall(gca,'Type','line','-property','Marker');
% set(h_mark,'LineWidth',2,'MarkerSize',15)
% 
% xl = xlim; xlim([xl(1)-0.1 xl(2)+0.1])
% ax = gca; ax.LineWidth = 1.5; ax.FontSize = 13;
% ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3]; box on;
% ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4; 
% ax.MinorGridColor = [0.95, 0.95, 0.95];ax.MinorGridAlpha = 0.1;
% 
% ax = findall(gcf,'Type','axes');
% set(get(ax(1),'XLabel'),'FontSize',12)
% set(get(ax(1),'YLabel'),'FontSize',12)
% set(get(ax(1),'Title'),'FontSize',14)
% 
% set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
% exportgraphics(gcf,'../../../images/task3/o1/GNA13.png','Resolution',300)
% exportgraphics(gcf,'../../../images/task3/o1/GNA13.pdf','ContentType','vector')

clc; clear;

% передаточная функция
num = [8 4 2.4];
den = [10 -5 11];
W = tf(num, den);

% частота среза (из расчёта)
w_cp = 2.00;

% комплексное значение на этой частоте
Wjw = evalfr(W, 1j*w_cp);

% фаза (в радианах)
phi = angle(Wjw);

% запас по фазе
phi_z = pi + phi;

% критическое запаздывание
tau_cr = phi_z / w_cp;

% вывод
fprintf('omega_cp = %.4f rad/s\n', w_cp);
fprintf('phi(omega_cp) = %.4f rad\n', phi);
fprintf('Phase margin = %.4f rad (%.2f deg)\n', phi_z, phi_z*180/pi);
fprintf('tau_cr = %.4f s\n', tau_cr);



