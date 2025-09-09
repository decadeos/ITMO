import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import fft, fftshift
from scipy.signal import lti, lsim

# Параметры сигнала
a = 10
t1 = 1
t2 = 5
c = 0
d = 15
b = 0.5
Timee = 20
dt = 0.001

# Генерация времени и сигналов
t = np.arange(0, Timee, dt)
n = len(t)
g = np.where((t >= t1) & (t <= t2), a, 0)
u = g + b*(2*np.random.rand(n) - 1) + c * np.sin(d*t)

# Функция для Фурье-анализа
def fourier(signal, t):
    spec = fftshift(fft(signal)) / len(t)
    omega = 2*np.pi*fftshift(np.fft.fftfreq(len(t), dt))
    return spec, omega

# Параметры фильтра
tau = 0.1
omega0 = 1/tau
system = lti([1], [tau, 1])

# Фильтрация сигнала
_, u_filtered, _ = lsim(system, u, t)

# Расчёт спектров
Gomega, omega = fourier(g, t)
Uomega, _ = fourier(u, t)
Ufiltered_omega, _ = fourier(u_filtered, t)

# Расчёт АЧХ фильтра
Womega = 1/(1 + 1j*omega*tau)
AChH = np.abs(Womega)

# Найдём точку пересечения с частотой среза
idx_omega0 = np.argmin(np.abs(omega - omega0))
W_at_omega0 = np.abs(1/(1 + 1j*omega0*tau))  # Теоретическое значение 1/sqrt(2) ≈ 0.707

# Найдём точку, где АЧХ равна W_at_omega0
idx_W = np.argmin(np.abs(AChH - W_at_omega0))

# Построение графика
plt.figure(figsize=(10, 6))

# 1. График АЧХ (тёмно-синий)
plt.plot(omega, AChH, color='darkblue', linewidth=2, label='АЧХ фильтра $|W(\omega)|$')

# 2. Вертикальная линия от оси Y до графика (красная пунктирная)
plt.plot([omega0, omega0], [0, AChH[idx_omega0]], 
         color='red', linestyle='--', linewidth=1.5,
         label=f'$\\omega_0 = {omega0:.1f}$ рад/с')

# 3. Горизонтальная линия от оси X до графика (красная пунктирная)
plt.plot([0, omega[idx_W]], [W_at_omega0, W_at_omega0],
         color='red', linestyle='--', linewidth=1.5,
         label=f'$W(\\omega_0) = {W_at_omega0:.3f}$')

# 4. Точки пересечения (красные кружки)
plt.scatter(omega0, AChH[idx_omega0], color='red', s=80, zorder=5)
plt.scatter(omega[idx_W], W_at_omega0, color='red', s=80, zorder=5)

# Настройки графика
plt.xlim(0, 50)
plt.ylim(0, 1.1)
plt.xlabel('Частота, $\omega$ (рад/с)', fontsize=12)
plt.ylabel('АЧХ, $|W(\omega)|$', fontsize=12)
plt.title('Амплитудно-частотная характеристика (АЧХ) ФНЧ', fontsize=14)
plt.grid(True, linestyle='--', alpha=0.6)
plt.legend(fontsize=10, loc='upper right')

plt.tight_layout()
plt.show()