import numpy as np
import matplotlib.pyplot as plt

def golden(f, a, b, epsilon, N):
    K = (np.sqrt(5) - 1) / 2
    x1 = b - K * (b - a)
    x2 = a + K * (b - a)
    f_x1 = f(x1)
    f_x2 = f(x2)

    x_values = [x1, x2]  # начальные точки
    f_values = [f_x1, f_x2]

    for k in range(N):
        if f_x1 < f_x2:
            b = x2
            x2 = x1
            f_x2 = f_x1
            x1 = b - K * (b - a)
            f_x1 = f(x1)
        else:
            a = x1
            x1 = x2
            f_x1 = f_x2
            x2 = a + K * (b - a)
            f_x2 = f(x2)

        x_values.append(x1) 
        x_values.append(x2)
        f_values.append(f_x1)
        f_values.append(f_x2)

        if abs(b - a) < epsilon:
            break

    x_min = (a + b) / 2
    f_min = f(x_min)

    x_range = np.linspace(-5, 5, 400)  
    y_range = f(x_range)

    plt.figure(figsize=(10, 6))
    plt.plot(x_range, y_range, label='f(x)', color='blue')
    plt.scatter(x_values, f_values, color='red', label='Iterations', s=20)
    plt.scatter(x_min, f_min, color='green', marker='.', s=100, label=f'Minimum: ({x_min:.3f}, {f_min:.3f})')  
    plt.axhline(0, color='black', linewidth=0.5, ls='--')  
    plt.axvline(0, color='black', linewidth=0.5, ls='--')  
    plt.xlabel('x')
    plt.ylabel('f(x)')
    plt.title('Golden Section Search')
    plt.legend()
    plt.grid(True)
    plt.xlim(-5, 5)  
    plt.ylim(-10, 10) 
    plt.show()

    return x_min, f_min

def func(x):
    return x**2 + 4*x + 4  

x_min, f_min = golden(func, -5, 5, 0.1, 100)
print(f"x_min: {x_min}, f_min: {f_min}")
