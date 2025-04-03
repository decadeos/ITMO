import numpy as np
import matplotlib.pyplot as plt
from plot import plot


def f(x):
    return -5*x**5 + 4*x**4 - 12*x**3 + 11*x**2 - 2*x + 1

def parabolic(f, a, c, b, tol=1e-6, max_iter=100):
    history = []
    for _ in range(max_iter):
        try:
            A = np.array([[a**2, a, 1], [c**2, c, 1], [b**2, b, 1]])
            coeffs = np.linalg.solve(A, [f(a), f(c), f(b)])
            u = -coeffs[1]/(2*coeffs[0]) if coeffs[0] != 0 else (a + b)/2
        except:
            u = (a + b)/2

        fu = f(u)
        history.append((a, c, b, u))

        if u < c:
            a, c, b = (a, u, c) if fu < f(c) else (u, c, b)
        else:
            a, c, b = (c, u, b) if fu < f(c) else (a, c, u)

        if abs(b - a) < tol:
            break

    xmin = min([a, b, c], key=f)
    return xmin, f(xmin), history

limLeft, limRight = -0.5, 0.5
x_min, f_min, golden_data = parabolic(f, limLeft, limRight, 0.1, 100)
x_range = np.linspace(-0.5, 0.5, 400)
plot(f, x_range, golden_data, "парабольный метод")