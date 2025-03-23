import numpy as np
import matplotlib.pyplot as plt
from scipy.io.wavfile import read
from scipy.signal import find_peaks

def load_audio(file_path):
    sample_rate, audio_data = read(file_path)
    if len(audio_data.shape) > 1:
        audio_data = audio_data[:, 0]
        return sample_rate, audio_data

def plot_time_domain(sample_rate, audio_data):
    time = np.arange(0, len(audio_data)) / sample_rate
    plt.figure(figsize=(10, 4))
    plt.plot(time, audio_data)
    plt.title("График f(t)")
    plt.xlabel("Время (с)")
    plt.ylabel("Амплитуда")
    plt.grid()
    plt.show()

def compute_fourier_transform(audio_data, sample_rate):
    n = len(audio_data)
    frequencies = np.fft.fftfreq(n, d=1/sample_rate)
    fourier_transform = np.fft.fft(audio_data) / n
    return frequencies[:n // 2], fourier_transform[:n // 2]

def plot_frequency_domain(frequencies, fourier_transform):
    plt.figure(figsize=(10, 4))
    plt.plot(frequencies, np.abs(fourier_transform))
    plt.title("График |f(ν)|")
    plt.xlabel("Частота (Гц)")
    plt.ylabel("Амплитуда")
    plt.grid()
    plt.show()

def find_peak_frequencies(frequencies, fourier_transform, num_peaks=3):
    peaks, _ = find_peaks(np.abs(fourier_transform), height=np.max(np.abs(fourier_transform)) * 0.1)
    peak_indices = np.argsort(np.abs(fourier_transform[peaks]))[-num_peaks:]
    return frequencies[peaks[peak_indices]]

def main(file_path):
    sample_rate, audio_data = load_audio(file_path)
    plot_time_domain(sample_rate, audio_data)
    frequencies, fourier_transform = compute_fourier_transform(audio_data, sample_rate)
    plot_frequency_domain(frequencies, fourier_transform)
    peak_frequencies = find_peak_frequencies(frequencies, fourier_transform)
    print("Основные частоты:", peak_frequencies)

if __name__ == "__main__":
    file_path = "/home/eva/Документы/itmo/2_course/chMetods/lab2/audio.wav"
    main(file_path)