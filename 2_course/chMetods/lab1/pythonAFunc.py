import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import quad

# Исходная функция
def f(t):
    return np.sin(t) + np.cos(2*t) + 2*t

def periodF(t):
    tMod = (t + np.pi) % (2*np.pi) - np.pi 
    return f(tMod)

# Вещественные коэффициенты Фурье
def aN(n):
    return (1/np.pi) * quad(lambda t: periodF(t) * np.cos(n*t), -np.pi, np.pi)[0]

def bN(n):
    return (1/np.pi) * quad(lambda t: periodF(t) * np.sin(n*t), -np.pi, np.pi)[0]

# Комплексные коэффициенты Фурье
def cN(n):
    return (1/(2*np.pi)) * quad(lambda t: periodF(t) * np.exp(-1j*n*t), -np.pi, np.pi, complex_func=True)[0]

# Вещественный ряд Фурье
def fourierRe(t, N):
    a0 = aN(0)
    series = a0 / 2
    for n in range(1, N+1):
        series += aN(n) * np.cos(n*t) + bN(n) * np.sin(n*t)
    return series

# Комплексный ряд Фурье
def fourierIm(t, N):
    series = np.zeros_like(t, dtype=complex)
    for n in range(-N, N+1):
        series += cN(n) * np.exp(1j*n*t)
    return series.real  # Берём вещественную часть, так как f(t) вещественная

# Построение графиков
t = np.linspace(-3*np.pi, 3*np.pi, 200)
y = periodF(t)
N = 15  # Число гармоник

# Вычисляем ряды
fuRe = fourierRe(t, N)
fuIm = fourierIm(t, N)

plt.figure(figsize=(12, 6))
plt.plot(t, y, label='Исходная функция', color='green', linewidth=2)
plt.plot(t, fuRe, label=f'Вещественный ряд (N={N})', color='blue')
plt.plot(t, fuIm, label=f'Комплексный ряд (N={N})', color='red', linestyle=':')
plt.title('Сравнение функций')
plt.xlabel('t')
xticks = np.arange(-3*np.pi, 3.5*np.pi, np.pi/2)
xtick_labels = [f'{x/np.pi:.1f}π' if x != 0 else '0' for x in xticks]
plt.xticks(xticks, xtick_labels)
plt.ylabel('f(t)')
plt.grid(True)
plt.legend()
plt.show()