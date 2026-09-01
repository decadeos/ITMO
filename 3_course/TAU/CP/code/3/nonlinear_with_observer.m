function dz = nonlinear_with_observer(t, z, K, L, M, m, beta, J, l, g)
    n = 4;
    x = z(1:n);
    x_hat = z(n+1:2*n);
    
    A = [0, 1, 0, 0;
         0, 0, -beta^2 * g / ((M+m)*J - beta^2), 0;
         0, 0, 0, 1;
         0, 0, (M+m) * beta * g / ((M+m)*J - beta^2), 0];
    
    B = [0; J / ((M+m)*J - beta^2); 0; -beta / ((M+m)*J - beta^2)];
    C = [1, 0, 0, 0;
         0, 0, 1, 0];
    
    g_signal = 2 * sin(2*t);
    u = -K * x_hat + g_signal;
    f = 0;
    
    dx = nonlinear_model(t, x, u, f, M, m, beta, J, l, g);
    y = C * x;
    dx_hat = A * x_hat + B * u + L * (y - C * x_hat);
    
    dz = [dx; dx_hat];
end