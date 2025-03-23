import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def f1(x, y, z):
    return z  # y' = z

def f2(x, y, z):
    return -16 * y + np.sin(x)  # z' = -16y + sin(x)

def runge_kutta(x0, y0, z0, h, x_end):
    x_values = [x0]
    y_values = [y0]
    z_values = [z0]

    x = x0
    y = y0
    z = z0

    while x < x_end:
        # Coefficients
        K1_y = h * f1(x, y, z)
        K1_z = h * f2(x, y, z)

        K2_y = h * f1(x + h / 2, y + K1_y / 2, z + K1_z / 2)
        K2_z = h * f2(x + h / 2, y + K1_y / 2, z + K1_z / 2)

        K3_y = h * f1(x + h / 2, y + K2_y / 2, z + K2_z / 2)
        K3_z = h * f2(x + h / 2, y + K2_y / 2, z + K2_z / 2)

        K4_y = h * f1(x + h, y + K3_y, z + K3_z)
        K4_z = h * f2(x + h, y + K3_y, z + K3_z)


        y += (K1_y + 2 * K2_y + 2 * K3_y + K4_y) / 6
        z += (K1_z + 2 * K2_z + 2 * K3_z + K4_z) / 6
        x += h

        x_values.append(round(x, 4))
        y_values.append(round(y, 6))
        z_values.append(round(z, 6))

    return np.array(x_values), np.array(y_values), np.array(z_values)


x0 = 0       # начальное значение x
y0 = 1       # начальное значение y
z0 = -2      # начальное значение y'
h = 0.1      # шаг
x_end = 0.3  # конечное значение x


# runge_kutta
x_vals, y_vals, z_vals = runge_kutta(x0, y0, z0, h, x_end)

# Результаты в таблице
results = pd.DataFrame({'x': x_vals, 'y': y_vals, "z (y')": z_vals})
print("\nРезультаты метода Рунге-Кутта 4-го порядка:")
print(results)


# plt.figure(figsize=(10, 6))
# plt.plot(x_vals, y_vals, label="y(x)", marker='o', linestyle='-')
# plt.title("Решение системы ОДУ методом Рунге-Кутта 4-го порядка")
# plt.xlabel("x")
# plt.ylabel("Значения")
# plt.grid(True)
# plt.plot(x_vals, z_vals, label="z(x) (y')", marker='s', linestyle='--')
# plt.legend()
# plt.show()
