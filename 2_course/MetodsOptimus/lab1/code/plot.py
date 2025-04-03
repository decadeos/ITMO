import matplotlib.pyplot as plt
import numpy as np

def plot(f, x_range, optimization_data, method_name, highlight_min=True):
    """
    Визуализация процесса оптимизации
    
    Параметры:
        f: целевая функция
        x_range: диапазон значений x для построения графика
        optimization_data: данные оптимизации (формат зависит от метода)
        method_name: название метода (для заголовка)
        highlight_min: выделять найденный минимум
    """
    plt.figure(figsize=(10, 6))
    y_range = f(x_range)
    
    # Рисуем саму функцию
    plt.plot(x_range, y_range, 'b-', label='f(x)')
    
    # Обрабатываем разные форматы данных методов
    if isinstance(optimization_data, tuple) and len(optimization_data) == 2:
        # Данные golden section (x_values, f_values)
        x_vals, f_vals = optimization_data
        plt.scatter(x_vals, f_vals, c='r', s=20, label='Итерации')
    elif isinstance(optimization_data, list) and all(len(item) == 4 for item in optimization_data):
        # Данные parabolic (a, c, b, u)
        for a, c, b, u in optimization_data:
            plt.plot([a, b], [f(a), f(b)], 'r--', alpha=0.3)
            plt.scatter(u, f(u), c='r', s=20)
    elif isinstance(optimization_data, list) and all(len(item) == 2 for item in optimization_data):
        # Данные Brent (x, f(x))
        x_vals, f_vals = zip(*optimization_data)
        plt.scatter(x_vals, f_vals, c='r', s=20, label='Итерации')
    
    # Выделяем минимум
    if highlight_min:
        x_min = x_range[np.argmin(y_range)]
        y_min = f(x_min)
        plt.scatter(x_min, y_min, c='g', marker='*', s=200, 
                   label=f'Минимум ({x_min:.4f}, {y_min:.4f})')
    
    plt.axhline(0, color='k', linestyle=':', alpha=0.5)
    plt.axvline(0, color='k', linestyle=':', alpha=0.5)
    plt.xlabel('x')
    plt.ylabel('f(x)')
    plt.title(f'Метод оптимизации: {method_name}')
    plt.legend()
    plt.grid(True)
    plt.show()