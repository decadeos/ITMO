clc; clear;

syms x u
J = 6*x^2 + u^2 + 4*x*u + 3*x + 4*u - 9;

grad_J = jacobian(J, [x, u])
hess_J = hessian(J, [x, u])

x0 = [0; 0];
vec = [x; u];

grad_J_num = subs(grad_J, {x, u}, {x0(1), x0(2)})
x_new = x0 - inv(hess_J) * grad_J_num'