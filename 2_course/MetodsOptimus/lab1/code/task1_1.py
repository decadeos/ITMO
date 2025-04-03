import numpy as np
import matplotlib.pyplot as plt
from plot import plot

def f(x):
    return -5*x**5 + 4*x**4 - 12*x**3 + 11*x**2 - 2*x + 1

def golden(f, a, b, epsilon, N):
    K = (np.sqrt(5) - 1) / 2
    x1 = b - K * (b - a)
    x2 = a + K * (b - a)
    f_x1 = f(x1)
    f_x2 = f(x2)

    x_values = [x1, x2]
    f_values = [f_x1, f_x2]

    for _ in range(N):
        if f_x1 < f_x2:
            b, x2, f_x2 = x2, x1, f_x1
            x1 = b - K * (b - a)
            f_x1 = f(x1)
        else:
            a, x1, f_x1 = x1, x2, f_x2
            x2 = a + K * (b - a)
            f_x2 = f(x2)

        x_values.extend([x1, x2])
        f_values.extend([f_x1, f_x2])

        if abs(b - a) < epsilon:
            break

    x_min = (a + b) / 2
    return x_min, f(x_min), (x_values, f_values)

limLeft, limRight = -0.5, 0.5
x_min, f_min, golden_data = golden(f, limLeft, limRight, 0.1, 100)
x_range = np.linspace(-0.5, 0.5, 400)
plot(f, x_range, golden_data, "Золотое сечение")
