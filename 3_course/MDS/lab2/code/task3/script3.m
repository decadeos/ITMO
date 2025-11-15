sigma = linspace(-3, 3, 1000); phi = zeros(size(sigma));
idx = abs(sigma) < 1;
phi(idx)  = 2 * sigma(idx);
phi(~idx) = 2 * sign(sigma(~idx));

mu1 = 0; mu0 = 2;
phi_mu1 = mu1 * sigma;
phi_mu0 = mu0 * sigma;

figure('Position',[100 100 900 400],'Color','white');
plot(sigma, phi, 'LineWidth', 3.0, 'Color', [0.85, 0.65, 0]); hold on;   
plot(sigma, phi_mu1, ':', 'LineWidth', 3.0, 'Color', [0, 0, 0.7]);  
plot(sigma, phi_mu0, ':', 'LineWidth', 3.0, 'Color', [0.8 0.2 0.2]);   

ax = gca; ax.LineWidth = 1.5; ax.FontSize = 15;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
grid on; grid minor; box on; 

xlabel('\sigma'); ylabel('φ(\sigma)');
legend({'φ(\sigma)', '\mu_1=0 \cdot \sigma', '\mu_2=2 \cdot \sigma'},'Location','northwest', fontsize = 15);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../images/task3/lines.png', 'Resolution', 500);

% A = [-1 -3;
%       -1 -4];
% lambda = eig(A)

syms lambda
A = [-1 -3; -1 -4];
b = [1; 0]; c = [0; 1];
W = c.' * inv(A - lambda*eye(2)) * b;
latex(W)