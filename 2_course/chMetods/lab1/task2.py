import numpy as np
from scipy.integrate import quad
import matplotlib.pyplot as plt

def f(t, T, R=1.0):
    """Комплекснозначная функция с периодом T"""
    t_mod = np.mod(t + T/8, T) - T/8
    
    # Вещественная часть
    Re_f = np.piecewise(t_mod,
                       [(-T/8 <= t_mod) & (t_mod < T/8),
                        (T/8 <= t_mod) & (t_mod < 3*T/8),
                        (3*T/8 <= t_mod) & (t_mod < 5*T/8),
                        (5*T/8 <= t_mod) & (t_mod < 7*T/8)],
                       [R,
                        lambda x: 2*R - 8*R*x/T,
                        -R,
                        lambda x: -6*R + 8*R*x/T])
    
    # Мнимая часть
    Im_f = np.piecewise(t_mod,
                       [(-T/8 <= t_mod) & (t_mod < T/8),
                        (T/8 <= t_mod) & (t_mod < 3*T/8),
                        (3*T/8 <= t_mod) & (t_mod < 5*T/8),
                        (5*T/8 <= t_mod) & (t_mod < 7*T/8)],
                       [lambda x: 8*R*x/T,
                        R,
                        lambda x: 4*R - 8*R*x/T,
                        -R])
    
    return Re_f + 1j*Im_f

def cN(n, T):
    """Коэффициенты Фурье с частотой ω_n = 2πn/T"""
    omega_n = 2 * np.pi * n / T
    integral = (1/T) * quad(lambda t: f(t, T) * np.exp(-1j * omega_n * t), -T/2, T/2, complex_func=True)[0]
    return integral

def fourier_series(t, N, T):
    """Частичная сумма ряда Фурье G_N(t)"""
    series = np.zeros_like(t, dtype=complex)
    for n in range(-N, N+1):
        omega_n = 2 * np.pi * n / T
        series += cN(n, T) * np.exp(1j * omega_n * t)
    return series  # Возвращаем комплексный ряд

# Параметры
T = 2.0  # Период
N = 7   # Число гармоник
t = np.linspace(-T, 2*T, 1000)

# Вычисление
f_values = f(t, T)
fourier_values = fourier_series(t, N, T)

# Визуализация
plt.figure(figsize=(14, 8))

# Вещественная часть
plt.subplot(2, 1, 1)
plt.plot(t, np.real(f_values), label='Re(f(t))', color='#0000FF')
plt.plot(t, np.real(fourier_values), label=f'Re(Fourier N={N})', color='#800000')
plt.ylabel('Re(f(t))')
plt.grid(True)
plt.legend()

# Мнимая часть
plt.subplot(2, 1, 2)
plt.plot(t, np.imag(f_values), label='Im(f(t))', color='#006400')
plt.plot(t, np.imag(fourier_values), label=f'Im(Fourier N={N})', color='#00FA9A')
plt.xlabel('Time t')
plt.ylabel('Im(f(t))')
plt.grid(True)
plt.legend()

plt.suptitle(f'Аппроксимация ряда Фурье (T={T}, N={N})')
plt.tight_layout()
plt.show()