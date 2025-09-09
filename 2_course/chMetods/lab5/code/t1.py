import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import trapz
import time

directoryName = "../images/task1/"


# Custom style settings
plt.rcParams.update({
    'axes.linewidth': 2,          # Thick axes borders
    'lines.linewidth': 2,         # Thick plot lines
    'grid.linewidth': 0.5,        # Grid line width
    'font.size': 12,              # Larger font size
    'axes.labelsize': 14,         # Axis label size
    'axes.titlesize': 16,         # Title size
    'axes.edgecolor': 'black',    # Black axes edges
    'figure.facecolor': 'white',  # White figure background
    'axes.facecolor': 'white',    # White axes background
})

# Parameters
T = 20  # Example T values
dt = 0.005
V = 20
arraydnu = [0.4]

def compute_fourier(T, dt, V, dnu):
    t = np.arange(-T/2, T/2, dt)
    nu = np.arange(-V/2, V/2, dnu)
    
    signal = np.where(np.abs(t) <= 0.5, 1, 0)
    
    fourier_num = np.zeros_like(nu, dtype=complex)
    for i, freq in enumerate(nu):
        fourier_num[i] = trapz(signal * np.exp(-2j * np.pi * freq * t), t)
    
    reconstructed = np.zeros_like(t, dtype=complex)
    for i, time in enumerate(t):
        reconstructed[i] = trapz(fourier_num * np.exp(2j * np.pi * nu * time), nu)
    
    return t, nu, signal, fourier_num, reconstructed

for dnu in arraydnu:
    start_time = time.time()
    
    # Создаем фигуру с двумя subplots размером 12x6
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 6))
    
    # Первый график - сигнал
    t_first = np.arange(-10/2, 10/2, 0.005)
    rect_full = np.where(np.abs(t_first) <= 0.5, 1, 0)
    
    # Original signal (red)
    ax1.plot(t_first, rect_full, label=r'${\Pi}(t)$', color='red')
    
    # Reconstructed signal (dark blue)
    t, nu, signal, fourier_num, reconstructed = compute_fourier(T, dt, V, dnu)
    ax1.plot(t, reconstructed.real, '-', 
             color='darkblue', 
             label=r'${\mathcal{F}^{-1}\{\hat{\Pi}(\nu)\}}$')
    
    ax1.set_xlabel('Time $t$', fontsize=16)
    ax1.set_ylabel('Amplitude', fontsize=16)
    ax1.legend(fontsize=16)
    ax1.set_xlim(-4, 4)
    ax1.grid(True)

    # Второй график - преобразование Фурье
    nu_first = np.arange(-10/2, 10/2, 0.005)
    
    # Theoretical sinc (red)
    ax2.plot(nu_first, np.sinc(nu_first), 
             label='$\\mathrm{sinc}(\\nu)$', 
             color='red')
    
    # Numerical FT (dark blue)
    ax2.plot(nu, fourier_num, '-', 
             color='darkblue', 
             label=r'$\hat{\Pi}(\nu)$')
    
    ax2.set_xlabel('Frequency $\\nu$', fontsize=16)
    ax2.set_ylabel('Amplitude', fontsize=16)
    ax2.legend(fontsize=16)
    ax2.set_xlim(-5, 5)
    ax2.grid(True)

    combined_filename = f"{directoryName}/combined_T_{T}_dt_{dt}_V_{V}_dnu_{dnu}.png"
    plt.savefig(combined_filename, dpi=300, bbox_inches='tight')
    plt.close(fig)  # Закрываем фигуру для освобождения памяти

    print("время работы " + str(time.time() - start_time))

plt.tight_layout()

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

# # Создаем временную ось
# t = np.linspace(-2, 2, 1000)
# # Прямоугольная функция
# rect = np.where(np.abs(t) <= 0.5, 1, 0)

# # Создаем частотную ось
# nu = np.linspace(-5, 5, 1000)
# # Теоретический Фурье-образ (sinc функция)
# sinc = np.sinc(nu)

# # Создаем фигуру с двумя подграфиками
# plt.figure(figsize=(16, 6))
# plt.subplot(1, 2, 1)
# plt.plot(t, rect, color='red', label='$\Pi(t)$')
# plt.xlabel('Time $t$', fontsize=16)  # Увеличенный шрифт
# plt.ylabel('Amplitude', fontsize=16) # Увеличенный шрифт
# plt.legend(fontsize=16) # Увеличенный шрифт легенды
# plt.grid(True)
# plt.xlim(-2, 2)
# plt.ylim(-0.1, 1.1)

# # Второй график - Фурье-образ (sinc)
# plt.subplot(1, 2, 2)
# plt.plot(nu, sinc, color='darkblue', label='$\\mathrm{sinc}(\\nu)$')
# plt.xlabel('Frequency $\\nu$', fontsize=16) # Увеличенный шрифт
# plt.ylabel('Amplitude', fontsize=16) # Увеличенный шрифт
# plt.legend(fontsize=16) # Увеличенный шрифт легенды
# plt.grid(True)
# plt.xlim(-5, 5)
# plt.ylim(-0.3, 1.1)

# plt.tight_layout()
# plt.savefig(f"{directoryName}/first.png", dpi=300, bbox_inches='tight')
