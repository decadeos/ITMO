import numpy as np
from task1_1 import golden
from task1_2 import parabolic
from plot import plot


def f(x):
    return -5*x**5 + 4*x**4 - 12*x**3 + 11*x**2 - 2*x + 1

def brent(f, a, b, tol=1e-6, max_iter=100):
    history = []
    c = (a + b) / 2
    x = w = v = c
    f_x = f_w = f_v = f(c)

    for _ in range(max_iter):
        history.append((x, f_x))

        if abs(b - a) < tol:
            break

        if len(history) > 2 and len({f_x, f_w, f_v}) == 3:
            x_parab, _, _ = parabolic(f, v, w, x, tol, 1)
            if a <= x_parab <= b and abs(x_parab - x) < 0.5*abs(b - a):
                f_parab = f(x_parab)
                if f_parab < f_x:
                    x, f_x = x_parab, f_parab
                    continue

        x_golden, f_golden, _ = golden(f, a, b, tol, 1)
        if f_golden < f_x:
            x, f_x = x_golden, f_golden

        if x < c:
            b = c
        else:
            a = c
        c = x

        v, w, x = w, x, x
        f_v, f_w, f_x = f_w, f_x, f_x

    return x, f_x, history
