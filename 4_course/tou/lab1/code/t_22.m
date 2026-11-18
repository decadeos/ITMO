clc; clear;

syms x u lam

eq1 = 12*x + 4*u + 3*(1 + lam) == 0;
eq2 = 2*(1 + 4*lam)*u + 4*x + 4 == 0;
eq3 = 4*u^2 + 3*x + 7 == 0;

sol = solve([eq1, eq2, eq3], [x, u, lam]);

disp('x ='); disp(vpa(sol.x, 4));
disp('u ='); disp(vpa(sol.u, 4));
disp('lambda ='); disp(vpa(sol.lam, 4));