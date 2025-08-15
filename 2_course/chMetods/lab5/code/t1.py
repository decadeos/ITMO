import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import trapz

directoryName = "../images"


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
arrayT = [0.6, 1, 10]  # Example T values
dt = 0.01
V = 10
dnu = 0.01

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

for T in arrayT:
    # Signal plot
    plt.figure(figsize=(10, 6))
    t_first = np.arange(-10/2, 10/2, 0.005)
    rect_full = np.where(np.abs(t_first) <= 0.5, 1, 0)
    
    # Original signal (red)
    plt.plot(t_first, rect_full, label='Original', color='red')
    
    # Reconstructed signal (dark blue)
    t, nu, signal, fourier_num, reconstructed = compute_fourier(T, dt, V, dnu)
    plt.plot(t, reconstructed.real, '--', 
             color='darkblue', 
             label=f'T={T}, dt={dt}, V={V}, dν={dnu}')
    
    plt.xlabel('Time')  # LaTeX math mode
    plt.ylabel('Amplitude')
    plt.legend()
    plt.xlim(-5, 5)
    plt.grid(True)

    signal_filename = f"{directoryName}/signal_T_{T}_dt_{dt}_V_{V}_dnu_{dnu}.png"
    plt.savefig(signal_filename, dpi=300, bbox_inches='tight')
    
    # Fourier transform plot
    plt.figure(figsize=(10, 6))
    nu_first = np.arange(-10/2, 10/2, 0.005)
    
    # Theoretical sinc (red)
    plt.plot(nu_first, np.sinc(nu_first), 
             label='$\\mathrm{sinc}(\\nu)$', 
             color='red')
    
    # Numerical FT (dark blue)
    plt.plot(nu, fourier_num, '--', 
             color='darkblue', 
             label=f'T={T}, dt={dt}, V={V}, dν={dnu}')
    
    plt.xlabel('$\\nu$')  # LaTeX math mode
    plt.ylabel('Amplitude')
    plt.legend()
    plt.xlim(-5, 5)
    plt.grid(True)

    fourier_filename = f"{directoryName}/fourier_T_{T}_dt_{dt}_V_{V}_dnu_{dnu}.png"
    plt.savefig(fourier_filename, dpi=300, bbox_inches='tight')

plt.tight_layout()
plt.show()