import numpy as np
import matplotlib.pyplot as plt

def f(x):
    return -5*x**5 + 4*x**4 - 12*x**3 + 11*x**2 - 2*x + 1

def parabolic_minimize(f, a, c, b, tol=1e-6, max_iter=100):
    history = []
    for _ in range(max_iter):
        # Коэффициенты параболы
        A = np.array([[a**2, a, 1], [c**2, c, 1], [b**2, b, 1]])
        y = np.array([f(a), f(c), f(b)])
        
        try:
            coeffs = np.linalg.solve(A, y)
            u = -coeffs[1]/(2*coeffs[0]) if coeffs[0] != 0 else (a + b)/2
        except:
            u = (a + b)/2
        
        fu = f(u)
        history.append((a, c, b, u))
        
        # Обновление точек
        if u < c:
            if fu < f(c): a, c, b = a, u, c
            else: a, c, b = u, c, b
        else:
            if fu < f(c): a, c, b = c, u, b
            else: a, c, b = a, c, u
            
        if abs(b - a) < tol:
            break
    
    xmin = min([a, b, c], key=f)
    return xmin, history

# Поиск минимума
xmin, history = parabolic_minimize(f, -0.5, 0, 0.5)
print(f"Найденный минимум: x = {xmin:.6f}, f(x) = {f(xmin):.6f}")

# Визуализация
x = np.linspace(-0.5, 0.5, 400)
plt.figure(figsize=(10, 6))
plt.plot(x, f(x), label='f(x) = -5x⁵ + 4x⁴ - 12x³ + 11x² - 2x + 1')

# Отметка минимума
plt.scatter(xmin, f(xmin), color='red', s=100, marker='*', label=f'Minimum ({xmin:.4f}, {f(xmin):.4f})')

plt.xlabel('x')
plt.ylabel('f(x)')
plt.title('Минимум функции на [-0.5, 0.5]')
plt.legend()
plt.grid(True)
plt.show()