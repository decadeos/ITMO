clc; clear;

syms x u
J = 6*x^2 + u^2 + 4*x*u + 3*x + 4*u - 9;


% необходимое
grad_J = jacobian(J, [x, u]);

[x_star, u_star] = solve(grad_J == 0, [x, u]);

disp('Оптимальная точка x*:'); disp(x_star);
disp('Оптимальная точка u*:'); disp(u_star);

J_min = subs(J, {x, u}, {x_star, u_star})

% достаточное
hess_J = hessian(J, [x, u])