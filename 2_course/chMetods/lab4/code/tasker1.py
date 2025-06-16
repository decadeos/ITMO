import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import fft, fftshift, ifft, ifftshift
from scipy.signal import lti, lsim

# Параметры
a = 10
t1 = 1
t2 = 5
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

# Параметр фильтра
current_tau = 0.1
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

# # Фигура 1: АЧХ фильтра
# fig1, ax1 = plt.subplots(figsize=(12, 6))
# ax1.plot(omega, np.abs(W_omega), color='darkblue', label='АЧХ', linewidth=2)
# ax1.set_xlabel('ω', fontsize=17)
# ax1.set_ylabel('Amplitude', fontsize=17)
# ax1.set_xlim(0, 300)
# ax1.set_ylim(0, 1.1)
# ax1.grid(True, linestyle='--', alpha=0.7)
# ax1.legend(fontsize=12, loc='upper right')
# ax1.tick_params(axis='both', which='major', labelsize=12)

# for spine in ax1.spines.values():
#     spine.set_linewidth(1.5)
    
# ax1.grid(True, which='both', linestyle=':', linewidth=0.7)
# plt.tight_layout()

# Фигура 2: Сигналы
# fig2, ax2 = plt.subplots(figsize=(15, 6))
# ax2.plot(t, g, 'r', label='Original', linewidth=2)
# ax2.plot(t, u, 'gray', alpha=0.5, label='Noisy', linewidth=1)
# ax2.plot(t, u_filtered, 'b', label=f'Filtreted (T={current_tau}, a={a})', linewidth=2, alpha=0.8)
# ax2.set_xlabel('Time', fontsize=19)
# ax2.set_ylabel('Amplitude', fontsize=19)
# ax2.set_xlim(0, 7)
# ax2.grid(True, linestyle='--', alpha=0.7)
# ax2.legend(fontsize=15)
# ax2.tick_params(axis='both', which='major', labelsize=15)

# for spine in ax2.spines.values():
#     spine.set_linewidth(1.5)
    
# ax2.grid(True, which='both', linestyle=':', linewidth=0.7)
# plt.tight_layout()
# fig2.savefig('../images/linearFilter/sig0.1.10.png', dpi=300, bbox_inches='tight', facecolor='white')

# График 3: Сравнение методов фильтрации
# product_time_corrected = ifft(ifftshift(product * len(t)))

# fig3, ax3 = plt.subplots(figsize=(15, 6))
# ax3.plot(t, u_filtered, 'b', label=f'Filtreted (lsim)', linewidth=2)
# ax3.plot(t, np.real(product_time_corrected), 'r--', 
#          label='inverse Fourier', linewidth=2)
# ax3.set_xlabel('Time', fontsize=19)
# ax3.set_ylabel('Amplitude', fontsize=19)
# ax3.set_xlim(0, 7)
# ax3.grid(True, linestyle='--', alpha=0.7)
# ax3.legend(fontsize=15, loc='upper right')
# ax3.tick_params(axis='both', which='major', labelsize=15)

# # Улучшенное оформление осей
# for spine in ax3.spines.values():
#     spine.set_linewidth(1.5)
    
# # Дополнительная сетка
# ax3.grid(True, which='both', linestyle=':', linewidth=0.7)

# plt.tight_layout()
# fig3.savefig('../images/linearFilter/3.10.0.1.png', dpi=300, bbox_inches='tight', facecolor='white')
# plt.close(fig3)

# График 4: Сравнение спектров
# fig4, ax4 = plt.subplots(figsize=(15, 6))
# ax4.plot(omega, np.abs(G_omega), 'red', label='Original', linewidth=2)
# ax4.plot(omega, np.abs(U_omega), 'gray', label='Noisy', alpha=0.7, linewidth=1.5)
# ax4.plot(omega, np.abs(U_filtered_omega), 'b', label='Filtered', linewidth=2)

# # Оформление в едином стиле
# ax4.set_xlabel('ω', fontsize=19)
# ax4.set_ylabel('Amplitude', fontsize=19)
# ax4.set_xlim(0, 50)
# ax4.grid(True, linestyle='--', alpha=0.7)
# ax4.legend(fontsize=15, loc='upper right')
# ax4.tick_params(axis='both', which='major', labelsize=15)

# # Оформление осей
# for spine in ax4.spines.values():
#     spine.set_linewidth(1.5)
    
# # Дополнительная сетка
# ax4.grid(True, which='both', linestyle=':', linewidth=0.7)

# plt.tight_layout()
# fig4.savefig('../images/linearFilter/s.png', dpi=300, bbox_inches='tight', facecolor='white')
# plt.close(fig4)


# График 5: Сравнение спектральных методов
fig5, ax5 = plt.subplots(figsize=(15, 6))
ax5.plot(omega, np.abs(U_filtered_omega), 'b', label='Filtered', linewidth=2)
ax5.plot(omega, np.abs(product), 'r--', label='W(iω)·U(ω)', linewidth=2)

# Оформление в едином стиле
ax5.set_xlabel('ω', fontsize=19)
ax5.set_ylabel('Amplitude', fontsize=19)
ax5.set_xlim(0, 50)  # Синхронизирован с диапазоном графика 4
ax5.grid(True, linestyle='--', alpha=0.7)
ax5.legend(fontsize=15, loc='upper right')
ax5.tick_params(axis='both', which='major', labelsize=15)

# Оформление осей
for spine in ax5.spines.values():
    spine.set_linewidth(1.5)
    
# Дополнительная сетка
ax5.grid(True, which='both', linestyle=':', linewidth=0.7)

plt.tight_layout()
fig5.savefig('../images/linearFilter/methods.10.0.1.png', dpi=300, bbox_inches='tight', facecolor='white')
plt.close(fig5)