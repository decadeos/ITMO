function dx = nonlinear_model(t, x, u, f, M, m, beta, J, l, g)
    % beta = m * l_c
    dx = zeros(4,1);
    
    a = x(1);
    dot_a = x(2);
    phi = x(3);
    dot_phi = x(4);
    
    Delta = (M + m)*J - beta^2 * cos(phi)^2;
    
    ddot_a = (J*(u + beta*dot_phi^2*sin(phi)) - beta*cos(phi)*(f + beta*g*sin(phi))) / Delta;
    ddot_phi = ((M+m)*(f + beta*g*sin(phi)) - beta*cos(phi)*(u + beta*dot_phi^2*sin(phi))) / Delta;
    
    dx(1) = dot_a;
    dx(2) = ddot_a;
    dx(3) = dot_phi;
    dx(4) = ddot_phi;
end