import numpy as np
from plot import plot

def parabolic(f, a, c, b, tol=1e-6, max_iter=100):
    """
    Параболическая интерполяция для поиска минимума функции
    
    Параметры:
        f: целевая функция
        a, c, b: начальные точки (a < c < b)
        tol: допустимая погрешность
        max_iter: максимальное число итераций
    
    Возвращает:
        xmin: найденный минимум
        fmin: значение функции в минимуме
        history: история итераций (a, c, b, u)
        errors: история изменения размера интервала
    """
    history = []
    errors = [abs(b - a)]  # Инициализация ошибки
    
    for _ in range(max_iter):
        # 1. Вычисляем новую точку параболы
        try:
            # Матрица коэффициентов системы уравнений
            A = np.array([
                [a**2, a, 1],
                [c**2, c, 1],
                [b**2, b, 1]
            ])
            # Решаем систему для коэффициентов параболы
            coeffs = np.linalg.solve(A, [f(a), f(c), f(b)])
            # Вершина параболы
            u = -coeffs[1] / (2 * coeffs[0]) if coeffs[0] != 0 else (a + b)/2
        except np.linalg.LinAlgError:
            u = (a + b) / 2  # В случае вырожденной матрицы
        
        # 2. Вычисляем значение функции в новой точке
        fu = f(u)
        
        # 3. Сохраняем историю и ошибку
        history.append((a, c, b, u))
        current_error = abs(b - a)
        errors.append(current_error)
        
        # 4. Проверка критерия остановки
        if current_error < tol:
            break
            
        # 5. Обновляем интервал
        if u < c:
            if fu < f(c):
                a, c, b = a, u, c
            else:
                a, c, b = u, c, b
        else:
            if fu < f(c):
                a, c, b = c, u, b
            else:
                a, c, b = a, c, u
    
    # Возвращаем лучшую точку из трех
    xmin = min([a, b, c], key=f)
    return xmin, f(xmin), history, errors