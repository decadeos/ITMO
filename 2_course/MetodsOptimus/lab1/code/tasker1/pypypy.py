import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import minimize_scalar  

def f(x):
    return -3 * x * np.sin(0.75 * x) + np.exp(-2 * x)

def brent_with_history(f, bounds):
    history = []
    result = minimize_scalar(
        f,
        method='brent',
        bracket=bounds,
        options={'maxiter': 100},
    )
    # Для Brent можно получить историю через детали реализации (если доступно)
    return result, history



methods = ['brent']

bounds = (0, 2 * np.pi)
results = {}

for method in methods:
    if method == 'brent':
        result, history = brent_with_history(f, bounds)
    elif method == 'golden':
        result, history = golden_with_history(f, bounds)
    results[method] = {
        'x_min': result.x,
        'f_min': result.fun,
        'history': history,
    }


plt.figure(figsize=(10, 6))

for method in methods:
    history = results[method]['history']
    if history:  # Если данные доступны
        errors = [abs(b - a) for a, b in history]
        plt.semilogy(errors, label=f'{method} (N={len(errors)})')

plt.xlabel('Iteration')
plt.ylabel('Interval Size (log scale)')
plt.title('Convergence Comparison: Brent vs Golden')
plt.legend()
plt.grid(True, linestyle='--', alpha=0.7)
plt.show()