import numpy as np
import matplotlib.pyplot as plt
import time

directoryName = "../images/task2/"

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

adt = [0.01, 0.1, 0.4]
T = 20  # Different T values to test

def compute_dft(T, dt):
    t = np.arange(-T/2, T/2, dt)
    N = len(t)
    
    signal = np.where(np.abs(t) <= 0.5, 1, 0)
    
    # Compute DFT with unitary normalization
    fourier_dft = np.fft.fftshift(np.fft.fft(signal, norm='ortho'))
    
    # Frequency axis
    nu = np.fft.fftshift(np.fft.fftfreq(N, dt))
    
    # Inverse DFT
    reconstructed = np.fft.ifft(np.fft.ifftshift(fourier_dft), norm='ortho')
    
    return t, nu, signal, fourier_dft, reconstructed

for dt in adt:
    start_time = time.time()
    
    # Создаем фигуру с двумя subplots размером 16x6
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 6))
    
    # Первый график - сигнал
    t_first = np.arange(-10/2, 10/2, 0.005)
    rect_full = np.where(np.abs(t_first) <= 0.5, 1, 0)
    
    # Original signal (red)
    ax1.plot(t_first, rect_full, label=r'${\Pi}(t)$', color='red')
    
    # Reconstructed signal (dark blue)
    t, nu, signal, fourier_dft, reconstructed = compute_dft(T, dt)
    ax1.plot(t, reconstructed.real, '-', 
             color='darkblue', 
             label=r'$\mathcal{F}^{-1}\{\hat{\Pi}(\nu)\}$')
    
    ax1.set_xlabel('Time $t$', fontsize=16)
    ax1.set_ylabel('Amplitude', fontsize=16)
    ax1.legend(fontsize=16)
    ax1.set_xlim(-2, 2)
    ax1.grid(True)

    # Второй график - преобразование Фурье
    nu_first = np.arange(-10/2, 10/2, 0.005)
    
    # Theoretical sinc (red)
    ax2.plot(nu_first, np.sinc(nu_first), 
             label='$\\mathrm{sinc}(\\nu)$', 
             color='red')
    
    # Numerical DFT (dark blue) - take real part for comparison
    ax2.plot(nu, fourier_dft.real, '-', 
             color='darkblue', 
             label=r'$\hat{\Pi}(\nu)$')
    
    ax2.set_xlabel('Frequency $\\nu$', fontsize=16)
    ax2.set_ylabel('Amplitude', fontsize=16)
    ax2.legend(fontsize=16)
    ax2.set_xlim(-5, 5)
    ax2.grid(True)

    combined_filename = f"{directoryName}/combined_T_{T}_dt_{dt}.png"
    plt.savefig(combined_filename, dpi=300, bbox_inches='tight')
    plt.close(fig)  # Закрываем фигуру для освобождения памяти

    print(f"Время работы для T={T}: {time.time() - start_time:.2f} секунд")

# Reset style to default if needed
plt.rcParams.update(plt.rcParamsDefault)