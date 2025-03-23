import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import fft, ifft, fftfreq
from matplotlib.widgets import Slider

# Параметры сигнала
a = 4
t1 = 0
t2 = 3
b_init = 0.5  # Начальное значение параметра шума
c_init = 1.0  # Начальное значение амплитуды гармонической помехи
d_init = 2.0  # Начальное значение частоты гармонической помехи
nu0_init = 0.5  # Начальное значение частоты среза

# Временная ось
t = np.linspace(t1 - 1, t2 + 1, 1000)  # Увеличиваем количество точек

# Определение сигнала g(t)
def g(t):
    return np.where((t1 <= t) & (t <= t2), a, 0)

# Шум xi(t)
def xi(t):
    return np.random.normal(0, 1, size=len(t))  # Гауссов шум с нулевым средним

# Зашумленный сигнал u(t)
def u(t, b, c, d):
    return g(t) + b * xi(t) + c * np.sin(d * t)

# Фурье-образ сигнала u(t)
def U(t, u_t):
    n = len(t)
    dt = t[1] - t[0]  # Шаг по времени
    freqs = fftfreq(n, dt)  # Частоты
    fft_values = fft(u_t)  # Фурье-образ
    return freqs, fft_values

# Совмещённый фильтр
def combined_filter(freqs, nu0, d, delta=0.1):
    # Фильтр для гармонической помехи
    harmonic_filter = np.where((np.abs(freqs) < d - delta) | (np.abs(freqs) > d + delta), 1, 0)
    # Фильтр низких частот
    low_pass = np.where(np.abs(freqs) <= nu0, 1, 0)
    return harmonic_filter * low_pass

# Применение фильтра и обратное преобразование Фурье
def filtered_signal(t, u_t, nu0, d):
    freqs, fft_values = U(t, u_t)
    filter_values = combined_filter(freqs, nu0, d)
    filtered_fft = fft_values * filter_values
    return ifft(filtered_fft).real  # Обратное преобразование Фурье

# Создание графиков
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(10, 8))
plt.subplots_adjust(bottom=0.4)  # Оставляем место для слайдеров

# Начальные значения
u_t = u(t, b_init, c_init, d_init)
filtered_u_t = filtered_signal(t, u_t, nu0_init, d_init)

# Построение начального графика сигналов
l1, = ax1.plot(t, g(t), 'r', label='g(t)', linewidth=3)
l2, = ax1.plot(t, u_t, 'gray', label='u(t)', linewidth=0.7)
l3, = ax1.plot(t, filtered_u_t, 'b', label='Отфильтрованный сигнал')
ax1.legend(fontsize=13) 
ax1.grid()

# Построение начального графика Фурье-образов
freqs, fft_u = U(t, u_t)
_, fft_filtered = U(t, filtered_u_t)
_, fft_g = U(t, g(t))  # Фурье-образ для g(t)

l4, = ax2.plot(freqs, np.abs(fft_g), 'r', label='Фурье-образ g(t)')
l5, = ax2.plot(freqs, np.abs(fft_u), 'gray', label='Фурье-образ u(t)')
l6, = ax2.plot(freqs, np.abs(fft_filtered), 'b', label='Фурье-образ отфильтрованного сигнала')
ax2.legend(fontsize=13) 
ax2.grid()
ax2.set_xlim([-10, 10])  # Ограничиваем диапазон частот для наглядности

# Создание слайдеров
ax_b = plt.axes([0.25, 0.3, 0.65, 0.03])
b_slider = Slider(ax_b, 'b', 0.0, 2.0, valinit=b_init)
b_slider.label.set_fontsize(14)

ax_c = plt.axes([0.25, 0.25, 0.65, 0.03])
c_slider = Slider(ax_c, 'c', 0.0, 5.0, valinit=c_init)
c_slider.label.set_fontsize(14)

ax_d = plt.axes([0.25, 0.2, 0.65, 0.03])
d_slider = Slider(ax_d, 'd', 0.0, 5.0, valinit=d_init)
d_slider.label.set_fontsize(14)

ax_nu0 = plt.axes([0.25, 0.15, 0.65, 0.03])
nu0_slider = Slider(ax_nu0, 'ν0', 0.0, 10.0, valinit=nu0_init)
nu0_slider.label.set_fontsize(14)

# Функция обновления графиков при изменении слайдеров
def update(val):
    b = b_slider.val
    c = c_slider.val
    d = d_slider.val
    nu0 = nu0_slider.val
    
    # Пересчитываем сигнал u(t) с новыми значениями b, c, d
    u_t = u(t, b, c, d)
    filtered_u_t = filtered_signal(t, u_t, nu0, d)
    
    # Обновление первого графика (сигналы)
    l2.set_ydata(u_t)
    l3.set_ydata(filtered_u_t)
    
    # Обновление второго графика (Фурье-образы)
    freqs, fft_u = U(t, u_t)
    _, fft_filtered = U(t, filtered_u_t)
    _, fft_g = U(t, g(t))  # Фурье-образ для g(t)
    
    l4.set_ydata(np.abs(fft_g))
    l5.set_ydata(np.abs(fft_u))
    l6.set_ydata(np.abs(fft_filtered))
    
    # Динамическое обновление диапазона частот
    ax2.set_xlim([-nu0 * 2, nu0 * 2])
    
    fig.canvas.draw_idle()

# Привязка слайдеров к функции обновления
b_slider.on_changed(update)
c_slider.on_changed(update)
d_slider.on_changed(update)
nu0_slider.on_changed(update)

plt.show()