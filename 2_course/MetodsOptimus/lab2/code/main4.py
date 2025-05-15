import numpy as np
import matplotlib.pyplot as plt
from numpy import log
from newton import newton
from mpl_toolkits.mplot3d import Axes3D

def f(x, y):
    return -9*x - 10*y - 10*(log(100 - x - y) + log(x) + log(y) + log(50 - x + y))

# Создаем основную фигуру с двумя подграфиками
fig = plt.figure(figsize=(20, 8))

# Первый подграфик - 2D вид сверху
ax1 = fig.add_subplot(121)
x = y = np.linspace(1, 99, 100)
X, Y = np.meshgrid(x, y)
mask = (X + Y < 100) & (X > 0) & (Y > 0) & (Y > X - 50)
Z = np.where(mask, f(X, Y), np.nan)

# Второй подграфик - 3D вид
ax2 = fig.add_subplot(122, projection='3d')

# Визуализируем поверхность на обоих графиках
for ax in [ax1, ax2]:
    if ax == ax2:
        # 3D поверхность
        surf = ax.plot_surface(X, Y, Z, cmap='viridis', alpha=0.5)
        fig.colorbar(surf, ax=ax, shrink=0.5, label='f(x,y)')
        ax.set_zlabel('f(x,y)')
        ax.view_init(30, 45)
    else:
        # 2D контурный график
        contour = ax.contour(X, Y, Z, levels=20, cmap='viridis')
        fig.colorbar(contour, ax=ax, shrink=0.5, label='f(x,y)')
    
    ax.set(xlabel='X', ylabel='Y', title='Метод Ньютона с alpha')

# Оптимизация методом Ньютона
initial_points = [(8, 90), (1, 40), (15, 68.69), (10, 20)]
colors = ['r', 'g', 'b', 'm']  # Разные цвета для разных траекторий

for point, color in zip(initial_points, colors):
    # Выполняем оптимизацию
    x0, history = newton(lambda x: f(x[0], x[1]), point, alpha='wolfe')
    history = np.array(history)
    
    # Визуализируем на 2D графике
    ax1.plot(history[:, 0], history[:, 1], 'o-', color=color, 
            label=f'Начальная точка: {point}')
    
    # Визуализируем на 3D графике
    z_values = [f(x, y) for x, y in history]
    ax2.plot(history[:, 0], history[:, 1], z_values, 'o-', color=color,
            markersize=5, linewidth=2)

# Настройки отображения
ax1.legend()
ax1.grid()
plt.tight_layout()
plt.show()