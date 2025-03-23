import numpy as np
import matplotlib.pyplot as plt
from scipy.io.wavfile import read, write
from scipy.signal import butter, filtfilt, find_peaks

# 1. Загрузка звукового файла
samplerate, data = read('./lab3/src/MUHA.wav')

# Если файл стерео, берем только один канал (моно)
if len(data.shape) > 1:
    data = data[:, 0]

# 2. Временная ось
time = np.arange(len(data)) / samplerate

# 3. Функция для создания полосового фильтра Баттерворта
def butter_bandpass(lowcut, highcut, fs, order=5):
    nyquist = 0.5 * fs
    low = lowcut / nyquist
    high = highcut / nyquist
    b, a = butter(order, [low, high], btype='band')
    return b, a

# 4. Функция для применения фильтра
def apply_filter(data, lowcut, highcut, fs, order=5):
    b, a = butter_bandpass(lowcut, highcut, fs, order=order)
    y = filtfilt(b, a, data)
    return y

# 5. Применение фильтра (диапазон голоса: 300–3400 Гц)
lowcut = 300
highcut = 3400
filtered_data = apply_filter(data, lowcut, highcut, samplerate)

# 6. Фурье-преобразование для исходного и фильтрованного сигналов
n = len(data)
frequencies = np.fft.fftfreq(n, d=1/samplerate)
fft_values = np.fft.fft(data)
fft_filtered = np.fft.fft(filtered_data)

# Модули Фурье-образов
magnitude = np.abs(fft_values)
magnitude_filtered = np.abs(fft_filtered)

# 7. Нахождение пиков на спектре исходного сигнала
peaks, _ = find_peaks(magnitude[:n // 2], height=np.max(magnitude[:n // 2]) * 0.1)  # Порог 10% от максимума

# 8. Построение графиков
fig, axs = plt.subplots(3, 1, figsize=(12, 12))

# График исходного и фильтрованного сигналов
axs[0].plot(time, data, label='Исходный сигнал', alpha=0.7)
axs[0].plot(time, filtered_data, label='Фильтрованный сигнал', alpha=0.7)
axs[0].set_title('Исходный и фильтрованный сигналы')
axs[0].set_xlabel('Время (с)')
axs[0].set_ylabel('Амплитуда')
axs[0].legend()
axs[0].grid()

# График спектра исходного сигнала с пиками
axs[1].plot(frequencies[:n // 2], magnitude[:n // 2], label='Спектр исходного сигнала')
axs[1].plot(frequencies[peaks], magnitude[peaks], "x", label='Пики', color='red')
axs[1].set_title('Спектр исходного сигнала с пиками')
axs[1].set_xlabel('Частота (Гц)')
axs[1].set_ylabel('Амплитуда')
axs[1].legend()
axs[1].grid()

# Ограничение осей для лучшего отображения пиков (0–700 Гц)
axs[1].set_xlim(0, 700)  # Ограничение по частоте до 700 Гц
axs[1].set_ylim(0, np.max(magnitude[:n // 2]) * 1.1)  # Ограничение по амплитуде

# График спектра фильтрованного сигнала
axs[2].plot(frequencies[:n // 2], magnitude_filtered[:n // 2], label='Спектр фильтрованного сигнала', color='orange')
axs[2].set_title('Спектр фильтрованного сигнала')
axs[2].set_xlabel('Частота (Гц)')
axs[2].set_ylabel('Амплитуда')
axs[2].legend()
axs[2].grid()

# Ограничение осей для лучшего отображения пиков (0–700 Гц)
axs[2].set_xlim(0, 700)  # Ограничение по частоте до 700 Гц
axs[2].set_ylim(0, np.max(magnitude_filtered[:n // 2]) * 1.1)  # Ограничение по амплитуде

plt.tight_layout()
plt.show()

# 9. Сохранение фильтрованного сигнала
write('filtered_MUHA.wav', samplerate, filtered_data.astype(np.int16))