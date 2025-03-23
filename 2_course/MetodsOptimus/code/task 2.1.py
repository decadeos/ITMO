import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import math

# Определяем матрицу A и вектор b
A = np.array([[2, 1], [1, 3]])  # Положительно определённая матрица
b = np.array([1, -1])  # Вектор коэффициентов

# Определяем целевую функцию
def f(x):
    return x.T @ A @ x + b.T @ x

# Определяем градиент функции
def grad_f(x):
    return 2 * A @ x + b

# Вычисляем точный минимум (x^*) и f(x^*)
x_star = -0.5 * np.linalg.inv(A) @ b
f_star = f(x_star)

# Метод градиентного спуска
def gradient_descent(f, grad_f, x0, alpha, epsilon, max_iterations):
    """
    Реализует метод градиентного спуска для функции двух переменных.

    Параметры:
    - f: целевая функция.
    - grad_f: функция, вычисляющая градиент.
    - x0: начальное приближение.
    - alpha: коэффициент обучения (шаг).
    - epsilon: точность для остановки.
    - max_iterations: максимальное количество итераций.

    Возвращает:
    - x_min: точка минимума.
    - f_min: значение функции в точке минимума.
    - history: список всех точек (x, y) на каждой итерации.
    - errors: список значений ошибки f(x_k) - f(x^*).
    """
    x = x0
    history = [x0]  # Для хранения истории точек
    errors = [f(x0) - f_star]  # Для хранения ошибок
    for k in range(max_iterations):
        gradient = grad_f(x)  # Вычисляем градиент
        x_new = x - alpha * gradient  # Обновляем x
        
        # Проверяем критерий остановки
        if np.linalg.norm(x_new - x) < epsilon:
            break
        
        # Обновляем значения x
        x = x_new
        history.append(x)  # Сохраняем текущую точку
        errors.append(f(x) - f_star)  # Сохраняем текущую ошибку
    
    return x, f(x), np.array(history), np.array(errors)

# Параметры метода градиентного спуска
alpha = 1/(math.sqrt(5)+5)  # Коэффициент обучения
alpha = 0.08
epsilon = 1e-6  # Точность
max_iterations = 1000  # Максимальное количество итераций

# Начальные приближения
initial_points = [
    np.array([1.0, 1.0]),  # Первое начальное приближение
    np.array([-1.0, -1.0]),  # Второе начальное приближение
    np.array([2.0, -2.0])  # Третье начальное приближение
]

# Запуск метода градиентного спуска для каждого начального приближения
results = []
for x0 in initial_points:
    x_min, f_min, history, errors = gradient_descent(f, grad_f, x0, alpha, epsilon, max_iterations)
    results.append((x_min, f_min, history, errors))
    print(f"Начальное приближение: {x0}")
    print(f"Точка минимума: {x_min}")
    print(f"Значение функции в точке минимума: {f_min}")
    print()

# Визуализация

# 1. 3D-график функции
fig = plt.figure(figsize=(18, 6))

# Создаем сетку для построения графика
x_vals = np.linspace(-3, 3, 100)
y_vals = np.linspace(-3, 3, 100)
X, Y = np.meshgrid(x_vals, y_vals)
Z = np.array([[f(np.array([x, y])) for x, y in zip(X.ravel(), Y.ravel())]]).reshape(X.shape)

# 3D-график
ax1 = fig.add_subplot(131, projection='3d')
ax1.plot_surface(X, Y, Z, cmap='viridis', alpha=0.8)
ax1.set_xlabel('X')
ax1.set_ylabel('Y')
ax1.set_zlabel('f(X, Y)')
ax1.set_title('3D-график функции')

# Добавляем траектории градиентного спуска на 3D-график
colors = ['r', 'g', 'b']  # Цвета для разных траекторий
for i, (x_min, f_min, history, errors) in enumerate(results):
    z_history = np.array([f(x) for x in history])  # Вычисляем z для каждой точки траектории
    ax1.plot(history[:, 0], history[:, 1], z_history, f'{colors[i]}.-', label=f'Траектория {i+1}')
    ax1.plot([x_min[0]], [x_min[1]], [f_min], f'{colors[i]}o', label=f'Минимум {i+1}')  # Точка минимума
ax1.legend()

# 2. 2D-график с линиями уровня и траекториями градиентного спуска
ax2 = fig.add_subplot(132)
ax2.contour(X, Y, Z, levels=20, cmap='viridis')  # Линии уровня
ax2.set_xlabel('X')
ax2.set_ylabel('Y')
ax2.set_title('Траектории градиентного спуска')

# Отображаем траектории градиентного спуска
for i, (x_min, f_min, history, errors) in enumerate(results):
    ax2.plot(history[:, 0], history[:, 1], f'{colors[i]}.-', label=f'Траектория {i+1}')
    ax2.plot(x_min[0], x_min[1], f'{colors[i]}o', label=f'Минимум {i+1}')
ax2.legend()

# 3. График ошибки (f(x_k) - f(x^*)) в логарифмической шкале
ax3 = fig.add_subplot(133)
for i, (x_min, f_min, history, errors) in enumerate(results):
    ax3.semilogy(errors, f'{colors[i]}.-', label=f'Траектория {i+1}')
ax3.set_xlabel('Итерация (k)')
ax3.set_ylabel('log(f(x_k) - f(x^*))')
ax3.set_title('Скорость сходимости')
ax3.legend()

plt.tight_layout()
plt.show()