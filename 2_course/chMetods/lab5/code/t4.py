import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import trapz
import time

# Настройка стиля
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

# Параметры
T = 40
dt = 0.04
V = 40
dnu = 0.04

def compute_analytical():
    """Аналитическое решение"""
    t_analog = np.linspace(-2, 2, 1000)
    rect_analog = np.where(np.abs(t_analog) <= 0.5, 1, 0)
    
    nu_analog = np.linspace(-5, 5, 1000)
    sinc_analog = np.sinc(nu_analog)
    
    return t_analog, rect_analog, nu_analog, sinc_analog

def compute_integral(T, dt, V, dnu):
    """Численное интегрирование"""
    t = np.arange(-T/2, T/2, dt)
    nu = np.arange(-V/2, V/2, dnu)
    
    signal = np.where(np.abs(t) <= 0.5, 1, 0)
    
    fourier_num = np.zeros_like(nu, dtype=complex)
    for i, freq in enumerate(nu):
        fourier_num[i] = trapz(signal * np.exp(-2j * np.pi * freq * t), t)
    
    reconstructed = np.zeros_like(t, dtype=complex)
    for i, time_val in enumerate(t):
        reconstructed[i] = trapz(fourier_num * np.exp(2j * np.pi * nu * time_val), nu)
    
    return t, signal, nu, fourier_num, reconstructed

def compute_dft(T, dt):
    """Дискретное преобразование Фурье"""
    t = np.arange(-T/2, T/2, dt)
    N = len(t)
    
    signal = np.where(np.abs(t) <= 0.5, 1, 0)
    
    fourier_dft = np.fft.fftshift(np.fft.fft(signal, norm='ortho'))
    nu = np.fft.fftshift(np.fft.fftfreq(N, dt))
    reconstructed = np.fft.ifft(np.fft.ifftshift(fourier_dft), norm='ortho')
    
    return t, signal, nu, fourier_dft, reconstructed

def compute_continuous_ft(T, dt):
    """Непрерывное преобразование Фурье с коррекцией"""
    t = np.arange(-T/2, T/2, dt)
    N = len(t)
    
    signal = np.where(np.abs(t) <= 0.5, 1, 0)
    
    nu = np.fft.fftshift(np.fft.fftfreq(N, dt))
    cm = dt * np.exp(-2j * np.pi * nu * (-T/2))
    fourier_hat = np.fft.fftshift(cm * np.fft.fft(signal))
    
    inv_cm = 1 / dt * np.exp(2j * np.pi * nu * (-T/2))
    reconstructed = np.fft.ifft(np.fft.ifftshift(fourier_hat * inv_cm))
    
    return t, signal, nu, fourier_hat, reconstructed

start_time = time.time()

# Создаем фигуру с двумя subplots
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 6))

# Цвета и стили для разных методов
colors = ['red', 'blue', 'green', 'orange']
line_styles = ['-', '--', '-.', ':']
labels = ['Аналитическое', 'trapz', 'DFT', 'Непрерывное FT']

# 1. Аналитическое решение
t_analog, rect_analog, nu_analog, sinc_analog = compute_analytical()
ax1.plot(t_analog, rect_analog, color=colors[0], linestyle=line_styles[0], 
         label=labels[0], linewidth=2.5)
ax2.plot(nu_analog, sinc_analog, color=colors[0], linestyle=line_styles[0], 
         label=labels[0], linewidth=2.5)

# 2. Численное интегрирование
t_int, signal_int, nu_int, fourier_int, recon_int = compute_integral(T, dt, V, dnu)
ax1.plot(t_int, recon_int.real, color=colors[1], linestyle=line_styles[1], 
         label=labels[1], linewidth=2)
ax2.plot(nu_int, fourier_int.real, color=colors[1], linestyle=line_styles[1], 
         label=labels[1], linewidth=2)

# 3. DFT
t_dft, signal_dft, nu_dft, fourier_dft, recon_dft = compute_dft(T, dt)
ax1.plot(t_dft, recon_dft.real, color=colors[2], linestyle=line_styles[2], 
         label=labels[2], linewidth=2)
ax2.plot(nu_dft, fourier_dft.real, color=colors[2], linestyle=line_styles[2], 
         label=labels[2], linewidth=2)

# 4. Непрерывное FT
t_cont, signal_cont, nu_cont, fourier_cont, recon_cont = compute_continuous_ft(T, dt)
ax1.plot(t_cont, recon_cont.real, color=colors[3], linestyle=line_styles[3], 
         label=labels[3], linewidth=2)
ax2.plot(nu_cont, fourier_cont.real, color=colors[3], linestyle=line_styles[3], 
         label=labels[3], linewidth=2)

# Настройка первого графика (сигнал)
ax1.set_xlabel('Time $t$', fontsize=16)
ax1.set_ylabel('Amplitude', fontsize=16)
ax1.legend(fontsize=12, loc='upper right')
ax1.set_xlim(-2, 2)
ax1.set_ylim(-0.2, 1.2)
ax1.grid(True, alpha=0.3)

# Настройка второго графика (спектр)
ax2.set_xlabel('Frequency $\\nu$', fontsize=16)
ax2.set_ylabel('Amplitude', fontsize=16)
ax2.legend(fontsize=12, loc='upper right')
ax2.set_xlim(-5, 5)
ax2.set_ylim(-0.3, 1.1)
ax2.grid(True, alpha=0.3)

plt.tight_layout()

# Сохранение
plt.savefig('../images/methods.png', dpi=300, bbox_inches='tight')
plt.show()
