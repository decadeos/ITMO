import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import fft, ifft, fftfreq
from matplotlib.widgets import Slider

# Параметры сигнала
a = 4
t1 = 0
t2 = 3
b_init = 0.5  # Начальное значение параметра шума
c = 0.0
d = 5

# Временная ось
t = np.linspace(t1 - 1, t2 + 1, 1000)

# Определение сигнала g(t)
def g(t):
    return np.where((t1 <= t) & (t <= t2), a, 0)

# Шум xi(t)
def xi(t):
    return np.random.normal(0, 1, size=len(t))

# Зашумленный сигнал u(t)
def u(t, b):
    return g(t) + b * xi(t) + c * np.sin(d * t)

# Фурье-образ сигнала u(t)
def U(t, u_t):
    n = len(t)
    dt = t[1] - t[0]  # Шаг по времени
    freqs = fftfreq(n, dt)  # Частоты
    fft_values = fft(u_t)  # Фурье-образ
    return freqs, fft_values

# Фильтр низких частот
def low_pass_filter(freqs, nu0):
    return np.where(np.abs(freqs) <= nu0, 1, 0)

# Применение фильтра и обратное преобразование Фурье
def filtered_signal(t, u_t, nu0):
    freqs, fft_values = U(t, u_t)
    filter_values = low_pass_filter(freqs, nu0)
    filtered_fft = fft_values * filter_values
    return ifft(filtered_fft).real  # Обратное преобразование Фурье

# Создание графиков
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(10, 8))
plt.subplots_adjust(bottom=0.35)

# Начальное значение nu0
nu0_init = 0.5

# Построение начального графика сигналов
u_t = u(t, b_init)
filtered_u_t = filtered_signal(t, u_t, nu0_init)
l1, = ax1.plot(t, g(t), 'r', label='g(t)', linewidth=3)
l2, = ax1.plot(t, u_t, 'gray', label='u(t)', linewidth=0.7)
l3, = ax1.plot(t, filtered_u_t, 'b', label='Отфильтрованный сигнал')
ax1.legend(fontsize=13) 
ax1.grid()

# Построение начального графика Фурье-образов
freqs, fft_u = U(t, u_t)
_, fft_filtered = U(t, filtered_u_t)
_, fft_g = U(t, g(t))  # Фурье-образ для g(t)

# Построение графиков Фурье-образов
l4, = ax2.plot(freqs, np.abs(fft_g), 'r', label='Фурье-образ g(t)')
l5, = ax2.plot(freqs, np.abs(fft_u), 'gray', label='Фурье-образ u(t)')
l6, = ax2.plot(freqs, np.abs(fft_filtered), 'b', label='Фурье-образ отфильтрованного сигнала')
ax2.legend(fontsize=13) 
ax2.grid()
ax2.set_xlim([-10, 10])

# Создание слайдера для nu0
ax_nu0 = plt.axes([0.25, 0.2, 0.65, 0.03])
nu0_slider = Slider(ax_nu0, 'ν0', 0.0, 10, valinit=nu0_init)
nu0_slider.label.set_fontsize(14)

# Создание слайдера для b
ax_b = plt.axes([0.25, 0.15, 0.65, 0.03])
b_slider = Slider(ax_b, 'b', 0.0, 2.0, valinit=b_init)
b_slider.label.set_fontsize(14)

# Функция обновления графиков при изменении слайдеров
def update(val):
    nu0 = nu0_slider.val
    b = b_slider.val
    
    # Пересчитываем сигнал u(t) с новым значением b
    u_t = u(t, b)
    filtered_u_t = filtered_signal(t, u_t, nu0)
    
    # Обновление первого графика (сигналы)
    l2.set_ydata(u_t)
    l3.set_ydata(filtered_u_t)
    
    # Обновление второго графика (Фурье-образы)
    freqs, fft_u = U(t, u_t)
    _, fft_filtered = U(t, filtered_u_t)
    _, fft_g = U(t, g(t))  # Фурье-образ для g(t)
    
    l4.set_ydata(np.abs(fft_g))  # Обновляем Фурье-образ g(t)
    l5.set_ydata(np.abs(fft_u))  # Обновляем Фурье-образ u(t)
    l6.set_ydata(np.abs(fft_filtered))  # Обновляем Фурье-образ отфильтрованного сигнала
    
    # Динамическое обновление диапазона частот
    ax2.set_xlim([-nu0 * 2, nu0 * 2])
    
    fig.canvas.draw_idle()

# Привязка слайдеров к функции обновления
nu0_slider.on_changed(update)
b_slider.on_changed(update)

plt.show()