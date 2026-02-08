% k = 1;
% num = k * [10 9 -1]; den = [10 10*k-12 9*k-1 4-k];
% 
% fig = figure('Color', 'white');
% W = tf(num, den);
% z = zero(W);
% p = pole(W);
% 
% plot(real(z), imag(z), 'o', ...
%     'Color',[0 0 0.7], 'LineWidth',2.5, 'MarkerSize',13)
% hold on
% plot(real(p), imag(p), 'x', ...
%     'Color',[0.8 0.2 0.2], 'LineWidth',2.5, 'MarkerSize',13)
% 
% ax = gca; ax.LineWidth = 1.7; ax.FontSize = 15;
% ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
% grid on; grid minor; box on;
% ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4; 
% ax.MinorGridColor = [0.95, 0.95, 0.95];ax.MinorGridAlpha = 0.2;
% 
% xline(0,'Color',[0.3 0.3 0.3],'LineWidth',1)
% yline(0,'Color',[0.3 0.3 0.3],'LineWidth',1)
% xlim([-1.2 0.9]); ylim([-1.2  1.2]);
% 
% xlabel('Re(s)', 'FontSize', 15, 'FontWeight', 'normal');
% ylabel('Im(s)', 'FontSize', 15, 'FontWeight', 'normal');
% legend('Zeros','Poles');
% 
% set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
% exportgraphics(fig,'../../../images/task2/o2/PZ-plot.png','Resolution',300)
% exportgraphics(fig,'../../../images/task2/o2/PZ-plot.pdf','ContentType','vector')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% k = 2;
% num = k * [10 9 -1]; den = [10 10*k-12 9*k-1 4-k];
% 
% fig = figure('Color', 'white');
% W = tf(num, den);
% z = zero(W);
% p = pole(W);
% 
% plot(real(z), imag(z), 'o', ...
%     'Color',[0 0 0.7], 'LineWidth',2.5, 'MarkerSize',13)
% hold on
% plot(real(p), imag(p), 'x', ...
%     'Color',[0.8 0.2 0.2], 'LineWidth',2.5, 'MarkerSize',13)
% 
% ax = gca; ax.LineWidth = 1.7; ax.FontSize = 15;
% ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
% grid on; grid minor; box on;
% ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4; 
% ax.MinorGridColor = [0.95, 0.95, 0.95];ax.MinorGridAlpha = 0.2;
% 
% xline(0,'Color',[0.3 0.3 0.3],'LineWidth',1)
% yline(0,'Color',[0.3 0.3 0.3],'LineWidth',1)
% xlim([-1.2 0.2]); 
% 
% xlabel('Re(s)', 'FontSize', 15, 'FontWeight', 'normal');
% ylabel('Im(s)', 'FontSize', 15, 'FontWeight', 'normal');
% legend('Zeros','Poles');
% 
% set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
% exportgraphics(fig,'../../../images/task2/o2/PZ-plot2.png','Resolution',300)
% exportgraphics(fig,'../../../images/task2/o2/PZ-plot2.pdf','ContentType','vector')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% k = 4;
% num = k * [10 9 -1]; den = [10 10*k-12 9*k-1 4-k];
% 
% fig = figure('Color', 'white');
% W = tf(num, den);
% z = zero(W);
% p = pole(W);
% 
% plot(real(z), imag(z), 'o', ...
%     'Color',[0 0 0.7], 'LineWidth',2.5, 'MarkerSize',13)
% hold on
% plot(real(p), imag(p), 'x', ...
%     'Color',[0.8 0.2 0.2], 'LineWidth',2.5, 'MarkerSize',13)
% 
% ax = gca; ax.LineWidth = 1.7; ax.FontSize = 15;
% ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
% grid on; grid minor; box on;
% ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4; 
% ax.MinorGridColor = [0.95, 0.95, 0.95];ax.MinorGridAlpha = 0.2;
% 
% xline(0,'Color',[0.3 0.3 0.3],'LineWidth',1)
% yline(0,'Color',[0.3 0.3 0.3],'LineWidth',1)
% xlim([-1.5 0.2]); 
% 
% xlabel('Re(s)', 'FontSize', 15, 'FontWeight', 'normal');
% ylabel('Im(s)', 'FontSize', 15, 'FontWeight', 'normal');
% legend('Zeros','Poles');
% 
% set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
% exportgraphics(fig,'../../../images/task2/o2/PZ-plot3.png','Resolution',300)
% exportgraphics(fig,'../../../images/task2/o2/PZ-plot3.pdf','ContentType','vector')

% k = 7;
% num = k * [10 9 -1]; den = [10 10*k-12 9*k-1 4-k];
% 
% fig = figure('Color', 'white');
% W = tf(num, den);
% z = zero(W);
% p = pole(W);
% 
% plot(real(z), imag(z), 'o', ...
%     'Color',[0 0 0.7], 'LineWidth',2.5, 'MarkerSize',13)
% hold on
% plot(real(p), imag(p), 'x', ...
%     'Color',[0.8 0.2 0.2], 'LineWidth',2.5, 'MarkerSize',13)
% 
% ax = gca; ax.LineWidth = 1.7; ax.FontSize = 15;
% ax.XColor = [0.3, 0.3, 0.3]; ax.YColor = [0.3, 0.3, 0.3];
% grid on; grid minor; box on;
% ax.GridColor = [0.9, 0.9, 0.9]; ax.GridAlpha = 0.4; 
% ax.MinorGridColor = [0.95, 0.95, 0.95];ax.MinorGridAlpha = 0.2;
% 
% xline(0,'Color',[0.3 0.3 0.3],'LineWidth',1)
% yline(0,'Color',[0.3 0.3 0.3],'LineWidth',1)
% xlim([-4.7 0.7]); 
% 
% xlabel('Re(s)', 'FontSize', 15, 'FontWeight', 'normal');
% ylabel('Im(s)', 'FontSize', 15, 'FontWeight', 'normal');
% legend('Zeros','Poles');
% 
% set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
% exportgraphics(fig,'../../../images/task2/o2/PZ-plot4.png','Resolution',300)
% exportgraphics(fig,'../../../images/task2/o2/PZ-plot4.pdf','ContentType','vector')
