import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import fft, fftshift
import time

# Custom style settings
plt.rcParams.update({
    'axes.linewidth': 2,
    'lines.linewidth': 2,
    'grid.linewidth': 0.5,
    'font.size': 12,
    'axes.labelsize': 14,
    'axes.titlesize': 16,
    'axes.edgecolor': 'black',
    'figure.facecolor': 'white',
    'axes.facecolor': 'white',
})

# Параметры сигналов
a1, a2 = 2, 1.5
omega1, omega2 = 3 * np.pi, 8 * np.pi
phi1, phi2 = np.pi / 3, np.pi / 4
b = 3 * np.pi
B = 6

# Оптимизированные параметры дискретизации
T = 50
dt_cont = 0.005
dt_sample1 = 0.2 # Нарушение Найквиста
dt_sample2 = 0.01  # Соблюдение Найквиста
dt_sample_sinc1 = 0.1  # Нарушение Найквиста
dt_sample_sinc2 = 0.04  # Соблюдение Найквиста

# Непрерывное время (ограниченный диапазон для визуализации)
t_cont = np.arange(-2, 2, dt_cont)

# Функция сигнала y1(t)
def y1(t):
    return a1 * np.sin(omega1 * t + phi1) + a2 * np.sin(omega2 * t + phi2)

y1_cont = y1(t_cont)

# Функция сигнала y2(t) - sinc
def y2(t):
    return np.sinc(b * t)

y2_cont = y2(t_cont)

# Оптимизированная функция восстановления (векторизованная)
def interp_optimized(f_samples, t_samples, t_cont, B):
    dt_s = t_samples[1] - t_samples[0]
    t_matrix = t_cont[:, np.newaxis] - t_samples
    sinc_matrix = np.sinc(2 * B * t_matrix)
    reconstructed = np.dot(sinc_matrix, f_samples) * 2 * B * dt_s
    return reconstructed

# Функция для вычисления спектра
def compute_spectrum(t, y):
    N = len(t)
    dt = t[1] - t[0]
    freq = fftshift(np.fft.fftfreq(N, dt))
    spectrum = fftshift(fft(y) / N)
    return freq, np.abs(spectrum)

# =============================================================================
# ГРАФИК 1: Исходный сигнал y1(t)
# =============================================================================
plt.figure(figsize=(10, 6))
plt.plot(t_cont, y1_cont, 'red', linewidth=2)
plt.xlabel('Time $t$')
plt.ylabel('Amplitude')
plt.xlim([-1, 1])
plt.grid(True, alpha=0.3)
plt.savefig('../images/original_y1.png', dpi=300, bbox_inches='tight')
plt.close()

# =============================================================================
# ГРАФИК 2: Исходный сигнал y2(t)
# =============================================================================
plt.figure(figsize=(10, 6))
plt.plot(t_cont, y2_cont, 'red', linewidth=2)
plt.xlabel('Time $t$')
plt.ylabel('Amplitude')
plt.xlim([-1, 1])
plt.grid(True, alpha=0.3)
plt.savefig('../images/original_y2.png', dpi=300, bbox_inches='tight')
plt.close()

# =============================================================================
# ГРАФИКИ 3-4: Дискретизация y1(t) с нарушением и соблюдением Найквиста
# =============================================================================
t_sample1 = np.arange(-2, 2, dt_sample1)
y1_sample1 = y1(t_sample1)

plt.figure(figsize=(10, 6))
plt.plot(t_cont, y1_cont, 'red', linewidth=2)
plt.stem(t_sample1, y1_sample1, 'black', markerfmt='ko', linefmt='k-', basefmt=' ')
plt.xlabel('Time $t$')
plt.ylabel('Amplitude')

plt.xlim([-1, 1])
plt.grid(True, alpha=0.3)
plt.legend(['$y_1(t)$', 'Sampling $y_1(t)$'])
plt.axhline(y=0.0, color='black', linestyle='-', linewidth=1, alpha=0.7)
plt.savefig('../images/sampling_y1_violation.png', dpi=300, bbox_inches='tight')
plt.close()

t_sample2 = np.arange(-2, 2, dt_sample2)
y1_sample2 = y1(t_sample2)

plt.figure(figsize=(10, 6))
plt.plot(t_cont, y1_cont, 'red', linewidth=2)
plt.stem(t_sample2, y1_sample2, 'black', markerfmt='ko', linefmt='k-', basefmt=' ')
plt.xlabel('Time $t$')
plt.ylabel('Amplitude')
plt.xlim([-1, 1])
plt.grid(True, alpha=0.3)
plt.legend(['$y_1(t)$', 'Sampling $y_1(t)$'])
plt.axhline(y=0.0, color='black', linestyle='-', linewidth=1, alpha=0.7)
plt.savefig('../images/sampling_y1_nyquist.png', dpi=300, bbox_inches='tight')
plt.close()

# =============================================================================
# ГРАФИКИ 5-6: Дискретизация y2(t) с нарушением и соблюдением Найквиста
# =============================================================================
t_sample_sinc1 = np.arange(-2, 2, dt_sample_sinc1)
y2_sample1 = y2(t_sample_sinc1)

plt.figure(figsize=(10, 6))
plt.plot(t_cont, y2_cont, 'red', linewidth=2)
plt.stem(t_sample_sinc1, y2_sample1, 'black', markerfmt='ko', linefmt='k-', basefmt=' ')
plt.title(f'Дискретизация $y_2(t)$ с $\Delta t = {dt_sample_sinc1}$ (нарушение Найквиста)')
plt.xlabel('Время $t$')
plt.ylabel('Амплитуда')
plt.xlim([-1, 1])
plt.grid(True, alpha=0.3)
plt.legend(['Исходный', 'Дискретный'])
plt.savefig('../images/sampling_y2_violation.png', dpi=300, bbox_inches='tight')
plt.close()

t_sample_sinc2 = np.arange(-2, 2, dt_sample_sinc2)
y2_sample2 = y2(t_sample_sinc2)

plt.figure(figsize=(10, 6))
plt.plot(t_cont, y2_cont, 'red', linewidth=2)
plt.stem(t_sample_sinc2, y2_sample2, 'black', markerfmt='ko', linefmt='k-', basefmt=' ')
plt.title(f'Дискретизация $y_2(t)$ с $\Delta t = {dt_sample_sinc2}$ (соблюдение Найквиста)')
plt.xlabel('Время $t$')
plt.ylabel('Амплитуда')
plt.xlim([-1, 1])
plt.grid(True, alpha=0.3)
plt.legend(['Исходный', 'Дискретный'])
plt.savefig('../images/sampling_y2_nyquist.png', dpi=300, bbox_inches='tight')
plt.close()

# =============================================================================
# ГРАФИКИ 7-8: Восстановление y1(t)
# =============================================================================
start_time = time.time()
y1_rec1 = interp_optimized(y1_sample1, t_sample1, t_cont, B)
y1_rec2 = interp_optimized(y1_sample2, t_sample2, t_cont, B)
print(f"Время восстановления y1: {time.time() - start_time:.3f} сек")

plt.figure(figsize=(10, 6))
plt.plot(t_cont, y1_cont, 'red', linewidth=2)
plt.plot(t_cont, y1_rec1, 'green', linewidth=2)
plt.xlabel('Time $t$')
plt.ylabel('Amplitude')
plt.xlim([-2, 2])
plt.grid(True, alpha=0.3)
plt.legend(['$y_1(t)$', 'Interpolation $y_1(t)$'])
plt.savefig('../images/reconstruction_y1_violation.png', dpi=300, bbox_inches='tight')
plt.close()

plt.figure(figsize=(10, 6))
plt.plot(t_cont, y1_cont, 'red', linewidth=2)
plt.plot(t_cont, y1_rec2, 'darkblue', linewidth=2)
plt.xlabel('Time $t$')
plt.ylabel('Amplitude')
plt.xlim([-2, 2])
plt.grid(True, alpha=0.3)
plt.legend(['$y_1(t)$', 'Interpolation $y_1(t)$'])
plt.savefig('../images/reconstruction_y1_nyquist.png', dpi=300, bbox_inches='tight')
plt.close()

# =============================================================================
# ГРАФИКИ 9-10: Восстановление y2(t)
# =============================================================================
start_time = time.time()
y2_rec1 = interp_optimized(y2_sample1, t_sample_sinc1, t_cont, B)
y2_rec2 = interp_optimized(y2_sample2, t_sample_sinc2, t_cont, B)
print(f"Время восстановления y2: {time.time() - start_time:.3f} сек")

plt.figure(figsize=(10, 6))
plt.plot(t_cont, y2_cont, 'red', linewidth=2)
plt.plot(t_cont, y2_rec1, 'green', linewidth=2)
plt.title('Восстановление $y_2(t)$ (нарушение Найквиста)')
plt.xlabel('Время $t$')
plt.ylabel('Амплитуда')
plt.xlim([-1, 1])
plt.grid(True, alpha=0.3)
plt.legend(['Исходный', 'Восстановленный'])
plt.savefig('../images/reconstruction_y2_violation.png', dpi=300, bbox_inches='tight')
plt.close()

plt.figure(figsize=(10, 6))
plt.plot(t_cont, y2_cont, 'red', linewidth=2)
plt.plot(t_cont, y2_rec2, 'darkblue', linewidth=2)
plt.title('Восстановление $y_2(t)$ (соблюдение Найквиста)')
plt.xlabel('Время $t$')
plt.ylabel('Амплитуда')
plt.xlim([-1, 1])
plt.grid(True, alpha=0.3)
plt.legend(['Исходный', 'Восстановленный'])
plt.savefig('../images/reconstruction_y2_nyquist.png', dpi=300, bbox_inches='tight')
plt.close()

# =============================================================================
# ГРАФИКИ 11-12: Спектры сигналов
# =============================================================================
freq, Y1_cont = compute_spectrum(t_cont, y1_cont)
_, Y1_rec1 = compute_spectrum(t_cont, y1_rec1)
_, Y1_rec2 = compute_spectrum(t_cont, y1_rec2)

_, Y2_cont = compute_spectrum(t_cont, y2_cont)
_, Y2_rec1 = compute_spectrum(t_cont, y2_rec1)
_, Y2_rec2 = compute_spectrum(t_cont, y2_rec2)

plt.figure(figsize=(10, 6))
plt.plot(freq, Y1_cont, 'red', linewidth=2)
plt.plot(freq, Y1_rec1, 'green', linewidth=1.5)
plt.plot(freq, Y1_rec2, 'darkblue', linewidth=1.5)
plt.axvline(B, color='black', linestyle=':', linewidth=2)
plt.axvline(-B, color='black', linestyle=':', linewidth=2)
plt.title('Спектры сигнала $y_1(t)$')
plt.xlabel('Частота (Гц)')
plt.ylabel('Амплитуда')
plt.xlim([-15, 15])
plt.grid(True, alpha=0.3)
plt.legend(['Исходный', 'Восст. (нарушение)', 'Восст. (соблюдение)'])
plt.savefig('../images/spectrum_y1.png', dpi=300, bbox_inches='tight')
plt.close()

plt.figure(figsize=(10, 6))
plt.plot(freq, Y2_cont, 'red', linewidth=2)
plt.plot(freq, Y2_rec1, 'green', linewidth=1.5)
plt.plot(freq, Y2_rec2, 'darkblue', linewidth=1.5)
plt.axvline(B, color='black', linestyle=':', linewidth=2)
plt.axvline(-B, color='black', linestyle=':', linewidth=2)
plt.title('Спектры сигнала $y_2(t)$')
plt.xlabel('Частота (Гц)')
plt.ylabel('Амплитуда')
plt.xlim([-15, 15])
plt.grid(True, alpha=0.3)
plt.legend(['Исходный', 'Восст. (нарушение)', 'Восст. (соблюдение)'])
plt.savefig('../images/spectrum_y2.png', dpi=300, bbox_inches='tight')
plt.close()

print("Все графики сохранены в папке ../images/")