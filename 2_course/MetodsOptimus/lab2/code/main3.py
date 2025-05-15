import numpy as np
import matplotlib.pyplot as plt
from math import sqrt
from newton import newton
from mpl_toolkits.mplot3d import Axes3D

def f(x):
    isuEva = 409290
    isuOla = 408835
    a = ((2*isuEva*isuOla)/(isuEva+isuOla))/1e5
    b = sqrt(isuEva*isuOla)/1e5
    return -1/(1 + (x[0]-a)**2 + (x[1]-b)**2)

a_opt = ((2*409290*408835)/(409290+408835))/1e5
b_opt = sqrt(409290*408835)/1e5
optimum = np.array([a_opt, b_opt])

startPoints = [
    np.array([a_opt + 0.3, b_opt - 0.2]),
    np.array([a_opt + 0.01, b_opt + 0.01]),
    np.array([a_opt + 0.05, b_opt + 0.03])
]

fig = plt.figure(figsize=(16, 7))

# 1. График сходимости (левый)
ax1 = fig.add_subplot(121)
for i, x0 in enumerate(startPoints):
    x_opt, history = newton(f, x0, alpha='wolfe')
    history = np.array(history)
    errors = [np.linalg.norm(x - optimum) for x in history]
    ax1.semilogy(errors, 'o-', label=f'Точка {i+1}')
    
    if len(errors) > 1:
        rates = []
        for k in range(len(errors)-4, len(errors)-1):
            rates.append(errors[k+1]/errors[k])
        
        avgRate = np.mean(rates)
        print(f'Точка {i+1}: средняя скорость = {avgRate:.4f}')
        if avgRate < 0.1:
            print("Квадратичная сходимость")
        elif avgRate < 0.6:
            print("Сверхлинейная сходимость")
        else:
            print("Линейная сходимость")

ax1.set_title('Сходимость метода Ньютона')
ax1.set_xlabel('Итерации')
ax1.set_ylabel('Ошибка (log scale)')
ax1.legend()
ax1.grid(True, linestyle='--', alpha=0.7)

# 2. 3D-график (правый)
ax2 = fig.add_subplot(122, projection='3d')
x = y = np.linspace(a_opt-2, a_opt+2, 50)
X, Y = np.meshgrid(x, y)
Z = np.array([f([xi, yi]) for xi, yi in zip(X.ravel(), Y.ravel())]).reshape(X.shape)

ax2.plot_surface(X, Y, Z, cmap='viridis', alpha=0.7)
ax2.scatter(a_opt, b_opt, f([a_opt, b_opt]), color='red', s=100, label='Минимум')

ax2.set_title('3D')
ax2.set_xlabel('X')
ax2.set_ylabel('Y')
ax2.set_zlabel('f(x,y)')

plt.tight_layout()
plt.show()





def nwSh(x0, y0):
    res, _ = newton(f, [x0, y0], tol=1e-6, maxIter=50)
    return np.linalg.norm(res - optimum) < 1e-3

n = 30
xPoints = np.linspace(a_opt-4, a_opt+4, n)
yPoints = np.linspace(b_opt-4, b_opt+4, n)
X, Y = np.meshgrid(xPoints, yPoints)

results = np.array([[nwSh(xi, yi) for xi in xPoints] for yi in yPoints])

plt.figure(figsize=(10, 8))
plt.contourf(X, Y, results, levels=[-0.5, 0.5, 1.5], cmap='RdYlGn')
plt.colorbar(ticks=[0, 1], label='Сходимость (1 - да, 0 - нет)')

contours = plt.contour(X, Y, results, levels=[0.5], colors='green', linewidths=0)

plt.axhline(y=b_opt, color='k', linestyle='--', linewidth=1, alpha=0.5)
plt.axvline(x=a_opt, color='k', linestyle='--', linewidth=1, alpha=0.5)

plt.scatter(a_opt, b_opt, c='k', marker='*', s=200, label='Минимум')
plt.title('Область сходимости метода Ньютона')
plt.xlabel('X'), plt.ylabel('Y')
plt.legend()
plt.show()