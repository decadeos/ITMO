sigma = linspace(-3, 3, 1000); phi = tanh(sigma);
mu1 = 0; mu2 = 1;
phi_mu1 = mu1 * sigma; phi_mu2 = mu2 * sigma;

figure('Position', [100 100 900 400], 'Color','white');
plot(sigma, phi, 'LineWidth', 3.0, 'Color', [0.85, 0.65, 0]); hold on;     
plot(sigma, phi_mu1, ':', 'LineWidth', 3.0, 'Color', [0, 0, 0.7]);     
plot(sigma, phi_mu2, ':', 'LineWidth', 3.0, 'Color', [0.8 0.2 0.2]);     

ax = gca; ax.LineWidth = 1.5; ax.FontSize = 15;
ax.XColor = [0.3 0.3 0.3]; ax.YColor = [0.3 0.3 0.3];
ax.GridColor = [0.9 0.9 0.9]; ax.GridAlpha = 0.4;
ax.MinorGridColor = [0.95 0.95 0.95]; ax.MinorGridAlpha = 0.2;
grid on; grid minor; box on; 

xlabel('\sigma'); ylabel('φ(\sigma)');
legend({'φ(\sigma) = tanh(\sigma)', '\mu_1=0', '\mu_2=1'},'Location','northwest', fontsize = 15);
set(findall(gcf, '-property', 'FontName'), 'FontName', 'DejaVu Math TeX Gyre');
exportgraphics(gcf, '../../images/task2/lines.png', 'Resolution', 500);

% A = [-2 1;
%       1 -2];
% lambda = eig(A)
% 
% syms lambda
% A = [-2 1; 1 -2];
% b = [1; 0]; c = [1; 0];
% W = c.' * inv(A - lambda*eye(2)) * b;
% latex(W)

