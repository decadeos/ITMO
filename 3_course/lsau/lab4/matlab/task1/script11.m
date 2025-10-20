a2 = 1;
a1 = 1;
a0 = -2;
y0 = 0;
dy0 = -1; 
odefun = @(t, x) [x(2);
                  ( -a1*x(2) - a0*x(1) )/a2 ];
tspan = [0 10];
x0 = [y0; dy0];
[t, x] = ode45(odefun, tspan, x0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('Color', 'white', 'Position', [100, 100, 900, 400]);

plot(t, x(:,1), ...
    'LineWidth', 2.5, ...
    'Color', [0.0, 0.0, 0.7]);

ylim([-51, 1]); xlim([0, 5.05]); 

grid on;
xlabel('Time');
ylabel('Amplitude');

ax = gca;
ax.XTick = 0:1:10; 
ax.LineWidth = 1.5;
ax.FontSize = 12;
ax.XColor = [0.3, 0.3, 0.3];
ax.YColor = [0.3, 0.3, 0.3];

grid on; grid minor;

ax.GridColor = [0.9, 0.9, 0.9];
ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95, 0.95, 0.95];
ax.MinorGridAlpha = 0.2;
box on;

legend('y_{paz}(t)', 'Location', 'northeast', 'FontSize', 15)

set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../images/task1/y_raz.png', 'Resolution', 300);