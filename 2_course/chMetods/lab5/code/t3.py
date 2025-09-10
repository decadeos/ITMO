import numpy as np
import matplotlib.pyplot as plt
import time
import os

directoryName = "../images/task3/"
os.makedirs(directoryName, exist_ok=True)

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

def compute_continuous_ft(T, dt):
    t = np.arange(-T/2, T/2, dt)
    N = len(t)
    
    signal = np.where(np.abs(t) <= 0.5, 1, 0)
    
    # Frequency axis
    nu = np.fft.fftshift(np.fft.fftfreq(N, dt))
    
    # Correction coefficients for continuous FT approximation
    cm = dt * np.exp(-2j * np.pi * nu * (-T/2))
    fourier_hat = np.fft.fftshift(cm * np.fft.fft(signal))
    
    # Inverse transformation coefficients
    inv_cm = 1 / dt * np.exp(2j * np.pi * nu * (-T/2))
    reconstructed = np.fft.ifft(np.fft.ifftshift(fourier_hat * inv_cm))
    
    return t, nu, signal, fourier_hat, reconstructed

# Исследование влияния T при фиксированном dt
print("Исследование влияния параметра T:")
T_values = [40, 10, 1]
dt_fixed = 0.005

for T in T_values:
    start_time = time.time()
    
    t, nu, signal, fourier_hat, reconstructed = compute_continuous_ft(T, dt_fixed)
    
    # Create figure with two subplots
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 6))
    
    # First plot - signal comparison
    t_analog = np.linspace(-2, 2, 1000)
    rect_analog = np.where(np.abs(t_analog) <= 0.5, 1, 0)
    
    ax1.plot(t_analog, rect_analog, label=r'$\Pi(t)$', color='red', linewidth=2)
    ax1.plot(t, reconstructed.real, '-', 
            color='darkblue', 
            label=r'$\mathcal{F}^{-1}\{\hat{\Pi}(\nu)\}$')
    
    ax1.set_xlabel('Time $t$', fontsize=16)
    ax1.set_ylabel('Amplitude', fontsize=16)
    ax1.legend(fontsize=16)
    ax1.set_xlim(-2, 2)
    ax1.grid(True)

    # Second plot - Fourier transform comparison
    nu_analog = np.linspace(-5, 5, 1000)
    
    ax2.plot(nu_analog, np.sinc(nu_analog), 
            label=r'$\mathrm{sinc}(\nu)$', 
            color='red', linewidth=2)
    
    ax2.plot(nu, fourier_hat.real, '-', 
            color='darkblue', 
            label=r'$\hat{\Pi}(\nu)$')
    
    ax2.set_xlabel('Frequency $\\nu$', fontsize=16)
    ax2.set_ylabel('Amplitude', fontsize=16)
    ax2.legend(fontsize=16)
    ax2.set_xlim(-5, 5)
    ax2.grid(True)

    combined_filename = f"{directoryName}/continuous_T_{T}_dt_{dt_fixed}.png"
    plt.savefig(combined_filename, dpi=300, bbox_inches='tight')
    plt.close(fig)

    print(f"Время работы для T={T}, dt={dt_fixed}: {time.time() - start_time:.2f} секунд")

# Исследование влияния dt при фиксированном T
print("\nИсследование влияния параметра dt:")
T_fixed = 20
dt_values = [0.01, 0.1, 0.5]

for dt in dt_values:
    start_time = time.time()
    
    t, nu, signal, fourier_hat, reconstructed = compute_continuous_ft(T_fixed, dt)
    
    # Create figure with two subplots
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 6))
    
    # First plot - signal comparison
    t_analog = np.linspace(-2, 2, 1000)
    rect_analog = np.where(np.abs(t_analog) <= 0.5, 1, 0)
    
    ax1.plot(t_analog, rect_analog, label=r'$\Pi(t)$', color='red', linewidth=2)
    ax1.plot(t, reconstructed.real, '-', 
            color='darkblue', 
            label=r'$\mathcal{F}^{-1}\{\hat{\Pi}(\nu)\}$')
    
    ax1.set_xlabel('Time $t$', fontsize=16)
    ax1.set_ylabel('Amplitude', fontsize=16)
    ax1.legend(fontsize=16)
    ax1.set_xlim(-2, 2)
    ax1.grid(True)

    # Second plot - Fourier transform comparison
    nu_analog = np.linspace(-5, 5, 1000)
    
    ax2.plot(nu_analog, np.sinc(nu_analog), 
            label=r'$\mathrm{sinc}(\nu)$', 
            color='red', linewidth=2)
    
    ax2.plot(nu, fourier_hat.real, '-', 
            color='darkblue', 
            label=r'$\hat{\Pi}(\nu)$')
    
    ax2.set_xlabel('Frequency $\\nu$', fontsize=16)
    ax2.set_ylabel('Amplitude', fontsize=16)
    ax2.legend(fontsize=16)
    ax2.set_xlim(-5, 5)
    ax2.grid(True)

    combined_filename = f"{directoryName}/continuous_T_{T_fixed}_dt_{dt}.png"
    plt.savefig(combined_filename, dpi=300, bbox_inches='tight')
    plt.close(fig)

    print(f"Время работы для T={T_fixed}, dt={dt}: {time.time() - start_time:.2f} секунд")

# Reset style to default
plt.rcParams.update(plt.rcParamsDefault)