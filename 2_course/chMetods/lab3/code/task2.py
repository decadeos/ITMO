import numpy as np
import matplotlib.pyplot as plt
import soundfile as sf
from scipy.signal import butter, filtfilt
from scipy.fft import fft, fftfreq

data, samplerate = sf.read("MUHA.wav")

def bandpass_filter(data, lowcut, highcut, fs, order=5):
    nyq = 0.5 * fs
    low = lowcut / nyq
    high = highcut / nyq
    b, a = butter(order, [low, high], btype='band')
    return filtfilt(b, a, data)


lowcut = 500
highcut = 3000
filtered_data = bandpass_filter(data, lowcut, highcut, samplerate)

sf.write("MUHA_filtered.wav", filtered_data, samplerate)

T = len(data) / samplerate
time = np.linspace(0, T, len(data))

plt.figure(figsize=(12, 4))
plt.plot(time, data, label="Исходный", alpha=0.6)
plt.plot(time, filtered_data, label="Фильтрованный", alpha=0.7)
plt.title("Сравнение сигналов во времени")
plt.xlabel("Время [с]")
plt.ylabel("Амплитуда")
plt.legend()
plt.grid()
plt.tight_layout()
plt.show()

N = len(data)
xf = fftfreq(N, 1 / samplerate)[:N // 2]
yf_orig = fft(data)
yf_filt = fft(filtered_data)

amp_orig = 2.0 / N * np.abs(yf_orig[:N // 2])
amp_filt = 2.0 / N * np.abs(yf_filt[:N // 2])

amp_orig /= np.max(amp_orig)
amp_filt /= np.max(amp_filt)

plt.figure(figsize=(12, 5))
plt.plot(xf, amp_orig, label="Исходный")
plt.plot(xf, amp_filt, label="Фильтрованный")
plt.title("Сравнение спектров")
plt.xlabel("Частота [Гц]")
plt.ylabel("Нормализованная амплитуда")
plt.xlim(0, 2000)
plt.grid(True)
plt.legend()
plt.tight_layout()
plt.show()
