function [Gamma, Q, Y, M1, M2, t, x, x_hat, e] = design_reduced_observer(lam_red, K, A, B, C, M, m, beta, J, l, g, x0, tspan)
    
    A11 = A(1:2, 1:2);
    A12 = A(1:2, 3:4);
    A21 = A(3:4, 1:2);
    A22 = A(3:4, 3:4);
    B1 = B(1:2);
    B2 = B(3:4);
    
    Gamma = diag(lam_red);
    
    syms q11 q12 q21 q22 real
    Q_sym = [q11, 1, q12, 0;
             q21, 0, q22, 1];
    
    left = Gamma * Q_sym - Q_sym * A;
    eq2 = left(:,2) == 0;
    eq4 = left(:,4) == 0;
    
    sol = solve([eq2; eq4], [q11, q12, q21, q22]);
    
    Q = double([sol.q11, 1, sol.q12, 0;
                sol.q21, 0, sol.q22, 1]);
    
    Y = (Gamma * Q - Q * A) * pinv(C);
    
    T = [C; Q];
    T_inv = inv(T);
    M1 = T_inv(:, 1:2);
    M2 = T_inv(:, 3:4);
    
    disp('Gamma:');
    disp(Gamma);
    disp('Q:');
    disp(Q);
    disp('Y:');
    disp(Y);
    disp('M1:');
    disp(M1);
    disp('M2:');
    disp(M2);
    
    z_hat0 = [0; 0];
    z0 = [x0; z_hat0];
    
    [t, z] = ode45(@(t, z) nonlinear_with_reduced_observer(t, z, K, M, m, beta, J, l, g, Gamma, Q, M1, M2, Y), tspan, z0);
    
    x = z(:, 1:4);
    z_hat = z(:, 5:6);
    
    x_hat = zeros(size(x));
    for i = 1:length(t)
        y = C * x(i,:)';
        x_hat(i,:) = (M1 * y + M2 * z_hat(i,:)')';
    end
    
    e = x - x_hat;
end