import numpy as np

def golden(f, a, b, epsilon, N):
    K = (np.sqrt(5) - 1) / 2  # Золотое сечение
    x1 = b - K * (b - a)
    x2 = a + K * (b - a)
    f_x1 = f(x1)
    f_x2 = f(x2)

    history = [(x1, f_x1), (x2, f_x2)]  # История всех точек
    errors = [abs(b - a)]  # Начальная ошибка

    for _ in range(N):
        current_error = abs(b - a)
        errors.append(current_error)  # Записываем ошибку перед проверкой
        
        if current_error < epsilon:
            break

        if f_x1 < f_x2:
            b, x2, f_x2 = x2, x1, f_x1
            x1 = b - K * (b - a)
            f_x1 = f(x1)
        else:
            a, x1, f_x1 = x1, x2, f_x2
            x2 = a + K * (b - a)
            f_x2 = f(x2)

        history.extend([(x1, f_x1), (x2, f_x2)])

    x_min = (a + b) / 2
    f_min = f(x_min)
    
    # Разделяем историю на x и f(x)
    x_vals, f_vals = zip(*history) if history else ([], [])
    
    return x_min, f_min, (list(x_vals), list(f_vals)), errors