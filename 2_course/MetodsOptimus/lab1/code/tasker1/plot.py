import matplotlib.pyplot as plt
import numpy as np

def plot(f, x_range, optimization_data, method_name, highlight_min=True):
    plt.figure(figsize=(10, 6))
    y_range = f(x_range)
    plt.plot(x_range, y_range, 'b-', label='f(x)')
    
    if isinstance(optimization_data, tuple):
        x_vals, f_vals = optimization_data
        plt.scatter(x_vals, f_vals, c='r', s=20, label='Iterations')
    elif isinstance(optimization_data, list):
        if all(len(item) == 4 for item in optimization_data):
            for a, c, b, u in optimization_data:
                plt.plot([a, b], [f(a), f(b)], 'r--', alpha=0.3)
                plt.scatter(u, f(u), c='r', s=20)
        elif all(len(item) == 2 for item in optimization_data):
            x_vals, f_vals = zip(*optimization_data)
            plt.scatter(x_vals, f_vals, c='r', s=20, label='Iterations')
    
    if highlight_min:
        x_min = x_range[np.argmin(y_range)]
        y_min = f(x_min)
        plt.scatter(x_min, y_min, c='g', marker='*', s=200, label=f'Min ({x_min:.4f}, {y_min:.4f})')
    
    plt.axhline(0, color='k', linestyle=':', alpha=0.5)
    plt.axvline(0, color='k', linestyle=':', alpha=0.5)
    plt.xlabel('x')
    plt.ylabel('f(x)')
    plt.title(f'Optimization: {method_name}')
    plt.legend()
    plt.grid(True)
    plt.show()

def plot_convergence(errors_list, method_names=None):
    plt.figure(figsize=(12, 7))
    
    colors = ['blue', 'green', 'red']  # Фиксированные цвета для методов
    markers = ['o', 's', '^']  # Разные маркеры
    
    max_len = max(len(err) for err in errors_list)
    
    for i, errors in enumerate(errors_list):
        # Нормализуем длину массивов
        x_vals = np.linspace(0, 1, len(errors))
        label = method_names[i] if method_names else f'Method {i+1}'
        
        plt.semilogy(x_vals, errors, 
                    marker=markers[i], 
                    color=colors[i],
                    markersize=8,
                    linewidth=2, 
                    label=label,
                    alpha=0.7)
    
    plt.xlabel('Normalized Iteration Number', fontsize=12)
    plt.ylabel('Interval Size (log scale)', fontsize=12)
    plt.title('Optimization Methods Convergence Comparison', fontsize=14, pad=20)
    plt.legend(fontsize=11, framealpha=0.9)
    
    plt.grid(True, which="both", linestyle='--', alpha=0.5)
    plt.minorticks_on()
    
    # Улучшаем отображение границ
    plt.xlim(0, 1)
    y_min = min(min(err) for err in errors_list) * 0.8
    y_max = max(max(err) for err in errors_list) * 1.2
    plt.ylim(y_min, y_max)
    
    plt.tight_layout()
    plt.show()
