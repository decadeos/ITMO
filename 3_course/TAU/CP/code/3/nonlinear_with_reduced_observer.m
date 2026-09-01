function dz = nonlinear_with_reduced_observer(t, z, K, M, m, beta, J, l, g, Gamma, Q, M1, M2, Y)

    n = 4;
    x = z(1:n);          
    z_hat = z(n+1:end);  
    
    Delta0 = (M + m)*J - beta^2;
    
    A = [0, 1, 0, 0;
         0, 0, -beta^2 * g / Delta0, 0;
         0, 0, 0, 1;
         0, 0, (M+m) * beta * g / Delta0, 0];
    
    B = [0; J/Delta0; 0; -beta/Delta0];
    C = [1, 0, 0, 0;
         0, 0, 1, 0];
    
    y = C * x;  
    
    x_hat = M1 * y + M2 * z_hat;
    
    g_signal = 2 * sin(2*t);
    f = 0;
    
    u = -K * x_hat + g_signal;
    
    dx = nonlinear_model(t, x, u, f, M, m, beta, J, l, g);
    
    dz_hat = Gamma * z_hat - Y * y + Q * B * u;
    
    dz = [dx; dz_hat];
end