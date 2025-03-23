import numpy as np
import matplotlib.pyplot as plt

def f(x, y):
    return 3 * x - y / x

# Метод Эйлера
def euler_method(f, x0, y0, h, x_end):
    x_values = [x0]
    y_values = [y0]
    
    x = x0
    y = y0
    
    while x < x_end:
        y = y + h * f(x, y)
        x = x + h
        x_values.append(x)
        y_values.append(y)
    
    return np.array(x_values), np.array(y_values)

x0 = 1  # Начальное значение x
y0 = 1  # Начальное значение y
h = 0.2  # Шаг
x_end = 2  # Конечное значение x

# Решаем методом Эйлера
x_vals, y_vals = euler_method(f, x0, y0, h, x_end)

# Вывод результатов
print("Решение методом Эйлера:")
for i in range(len(x_vals)):
    print(f"x = {x_vals[i]:.1f}, y = {y_vals[i]:.4f}")


