function [L, t, x, x_hat, e] = design_full_observer(lam_obs, K, A, B, C, M, m, beta, J, l, g, x0, tspan)
    
    L = place(A', C', lam_obs)';
    disp('Матрица L:');
    disp(L);
    
    x_hat0 = [0; 0; 0; 0];
    z0 = [x0; x_hat0];
    
    [t, z] = ode45(@(t, z) nonlinear_with_observer(t, z, K, L, M, m, beta, J, l, g), tspan, z0);
    
    x = z(:, 1:4);
    x_hat = z(:, 5:8);
    e = x - x_hat;
end