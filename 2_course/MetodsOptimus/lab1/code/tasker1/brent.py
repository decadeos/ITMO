import numpy as np
from golden import golden
from parabolic import parabolic
from plot import plot

def brent(f, a, b, tol=1e-6, max_iter=100):
    """
    Комбинированный метод Брента для поиска минимума функции
    
    Параметры:
        f: целевая функция
        a, b: границы интервала
        tol: допустимая погрешность
        max_iter: максимальное число итераций
    
    Возвращает:
        x_min: найденный минимум
        f_min: значение функции в минимуме
        history: история итераций (x, f(x))
        errors: история изменения размера интервала
    """
    history = []
    errors = []
    
    # Инициализация точек
    c = (a + b) / 2
    x = w = v = c
    f_x = f_w = f_v = f(c)
    
    for iter_num in range(max_iter):
        # Сохраняем текущее состояние
        history.append((x, f_x))
        current_error = abs(b - a)
        errors.append(current_error)
        
        # Критерий остановки
        if current_error < tol:
            break
            
        # Параболическая интерполяция (когда возможно)
        if iter_num > 2 and len({f_x, f_w, f_v}) == 3:
            x_parab, _, _, _ = parabolic(f, v, w, x, tol, 1)
            
            # Проверка допустимости новой точки
            if (a <= x_parab <= b and 
                abs(x_parab - x) < 0.5 * current_error):
                
                f_parab = f(x_parab)
                if f_parab < f_x:
                    x, f_x = x_parab, f_parab
                    # Обновление границ
                    if x < c:
                        b = c
                    else:
                        a = c
                    c = x
                    continue

        # Золотое сечение (когда параболическая интерполяция не сработала)
        x_golden, f_golden, _, _ = golden(f, a, b, tol, 1)
        if f_golden < f_x:
            x, f_x = x_golden, f_golden

        # Обновление интервала
        if x < c:
            b = c
        else:
            a = c
        c = x

        # Обновление вспомогательных точек
        v, w = w, x
        f_v, f_w = f_w, f_x

    return x, f(x), history, errors