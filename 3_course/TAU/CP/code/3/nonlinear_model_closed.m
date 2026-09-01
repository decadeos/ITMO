% Функция замкнутой системы
function dx = nonlinear_model_closed(t, x, K, M, m, beta, J, l, g)
    u = -K * x;  % обратная связь по состоянию
    f = 0;
    dx = nonlinear_model(t, x, u, f, M, m, beta, J, l, g);
end