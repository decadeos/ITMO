import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import fft, fftshift, ifft, ifftshift
from scipy.signal import lti, lsim

# Параметры
a = 0.1
t1 = 7
t2 = 14
c = 0
d = 15
b = 0.5
T_total = 20
dt = 0.001

# Временная ось
t = np.arange(0, T_total, dt)
n = len(t)

# Генерация сигналов
g = np.where((t >= t1) & (t <= t2), a, 0)
u = g + b * (2 * np.random.rand(n) - 1) + c * np.sin(d * t)

# Функция для Фурье-образа
def compute_fourier(signal, t):
    spectrum = fftshift(fft(signal)) / len(t)
    omega = 2 * np.pi * fftshift(np.fft.fftfreq(len(t), dt))
    return spectrum, omega

# Параметр фильтра (оставляем только последнее значение)
current_tau = 0.01

# Фильтрация сигнала
system = lti([1], [current_tau, 1])
_, u_filtered, _ = lsim(system, u, t)

# Расчет спектров
G_omega, omega = compute_fourier(g, t)
U_omega, _ = compute_fourier(u, t)
U_filtered_omega, _ = compute_fourier(u_filtered, t)

# Теоретическая АЧХ и произведение
W_omega = 1 / (1 + 1j * omega * current_tau)
product = W_omega * U_omega

# Основные графики
fig1, (ax1, ax2) = plt.subplots(2, 1, figsize=(12, 12))

# График 1: АЧХ
ax1.plot(omega, np.abs(W_omega), 'b-', label='Теоретическая АЧХ')
ax1.plot(omega, np.abs(U_filtered_omega/U_omega), 'r--', label='Практическая АЧХ')
ax1.set_title(f'АЧХ фильтра (τ={current_tau})')
ax1.set_xlabel('Частота [рад/с]')
ax1.set_ylabel('Коэффициент передачи')
ax1.set_xlim(0, 100)
ax1.set_ylim(0, 1.1)
ax1.grid(True)
ax1.legend()

# График 2: Сигналы
ax2.plot(t, g, 'k', label='Исходный сигнал', linewidth=1.5)
ax2.plot(t, u, 'r', alpha=0.3, label='Зашумленный сигнал')
ax2.plot(t, u_filtered, 'b', label=f'Фильтрованный (τ={current_tau})', alpha=0.8)
ax2.set_title(f'Сравнение сигналов (τ={current_tau})')
ax2.set_xlabel('Время [с]')
ax2.set_ylabel('Амплитуда')
ax2.set_xlim(0, 20)
ax2.grid(True)
ax2.legend()

# Дополнительные графики
product_time = ifft(ifftshift(product))

fig2, (ax3, ax4, ax5) = plt.subplots(3, 1, figsize=(12, 15))

# График 3: Сравнение методов фильтрации
ax3.plot(t, u_filtered, label=f'Фильтрованный сигнал (lsim), τ={current_tau}')
ax3.plot(t, np.real(product_time), '--', label='Обратное Фурье от W(iω)·U(ω)')
ax3.set_title(f'Сравнение методов фильтрации (τ={current_tau})')
ax3.set_xlabel('Время')
ax3.set_ylabel('Амплитуда')
ax3.legend()
ax3.grid(True)

# График 4: Сравнение спектров
ax4.plot(omega, np.abs(G_omega), label='Спектр исходного сигнала')
ax4.plot(omega, np.abs(U_omega), label='Спектр зашумленного сигнала', alpha=0.7)
ax4.plot(omega, np.abs(U_filtered_omega), label='Спектр после фильтрации')
ax4.set_title(f'Сравнение спектров (τ={current_tau})')
ax4.set_xlabel('Угловая частота [рад/с]')
ax4.set_ylabel('Амплитуда')
ax4.set_xlim(0, 200)
ax4.legend()
ax4.grid(True)

# График 5: Сравнение спектральных методов
ax5.plot(omega, np.abs(U_filtered_omega), label='Спектр фильтрованного сигнала')
ax5.plot(omega, np.abs(product), '--', label='W(iω)·U(ω)')
ax5.set_title(f'Сравнение спектральных методов (τ={current_tau})')
ax5.set_xlabel('Угловая частота [рад/с]')
ax5.set_ylabel('Амплитуда')
ax5.set_xlim(0, 200)
ax5.legend()
ax5.grid(True)

plt.tight_layout()
plt.show()