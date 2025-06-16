# from lib.func import *

# image = getImage("../../images/10.png")

# b, g, r = getImageChannel(image)

# magnitudeNormB, phaseB = computeFFT(b)
# magnitudeNormG, phaseG = computeFFT(g)
# magnitudeNormR, phaseR = computeFFT(r)

# fft_b_uint8 = (magnitudeNormB * 255).astype(np.uint8)
# fft_g_uint8 = (magnitudeNormG * 255).astype(np.uint8) 
# fft_r_uint8 = (magnitudeNormR * 255).astype(np.uint8)

# fft_combined = cv2.merge([fft_b_uint8, fft_g_uint8, fft_r_uint8])

# cv2.imwrite("pectrum.jpg", fft_combined)


# channelB = inverseFFT(magnitudeNormB, phaseB)
# channelG = inverseFFT(magnitudeNormG, phaseG)
# channelR = inverseFFT(magnitudeNormR, phaseR)

# reconstructed_img = np.stack([channelR, channelG, channelB], axis=-1)

# # 2. Нормализуем в диапазон 0-255 и преобразуем в uint8
# reconstructed_img = np.clip(reconstructed_img, 0, 255)  # обрезаем выбросы
# reconstructed_img = reconstructed_img.astype(np.uint8)  # в целочисленный тип

# # 3. Показать или сохранить изображение
# cv2.imshow("Reconstructed Image", reconstructed_img)
# cv2.waitKey(0)
# cv2.destroyAllWindows()




import cv2
import numpy as np

def computeFFT(channel):
    fft = np.fft.fft2(channel)
    fftShift = np.fft.fftshift(fft)
    magnitude = np.abs(fftShift)
    phase = np.angle(fftShift)
    logMagnitude = np.log(magnitude + 1)
    return logMagnitude, phase

def inverseFFT(logMagnitude, phase):
    magnitude = np.exp(logMagnitude) - 1
    fftShift = magnitude * np.exp(1j * phase)
    fft = np.fft.ifftshift(fftShift)
    channel = np.fft.ifft2(fft)
    return np.real(channel)

def reconstruct_from_spectrum_image(spectrum_img_path, original_phase):
    # 1. Загружаем сохраненный Фурье-образ
    spectrum_img = cv2.imread(spectrum_img_path, cv2.IMREAD_GRAYSCALE)
    
    # 2. Обратная нормализация (предполагая, что сохраняли через log и нормализацию)
    spectrum_img = spectrum_img.astype(np.float32) / 255.0
    log_magnitude = spectrum_img * global_log_max  # global_log_max должен быть известен!
    magnitude = np.exp(log_magnitude) - 1
    
    # 3. Восстанавливаем комплексный спектр
    # Используем фазы из оригинального преобразования
    fft_shift = magnitude * np.exp(1j * original_phase)
    
    # 4. Обратное Фурье-преобразование
    fft = np.fft.ifftshift(fft_shift)
    reconstructed = np.fft.ifft2(fft)
    reconstructed = np.abs(reconstructed)  # Берем модуль
    
    # Нормализация
    reconstructed = cv2.normalize(reconstructed, None, 0, 255, cv2.NORM_MINMAX)
    return reconstructed.astype(np.uint8)   

from scipy.ndimage import median_filter
import numpy as np
import cv2

def deletePeaks(spectrum_img, threshold=350):
    # Разделяем на каналы
    b, g, r = cv2.split(spectrum_img.astype(np.float32))
    
    # Вычисляем яркость (амплитуду спектра в этой точке)
    magnitude = np.sqrt(b**2 + g**2 + r**2)
    
    # Создаем маску для "пиков"
    mask = magnitude > threshold
    
    # Медианное фильтрование
    b_median = median_filter(b, size=3)
    g_median = median_filter(g, size=3)
    r_median = median_filter(r, size=3)
    
    # Заменяем пики на медианные значения
    b[mask] = b_median[mask]
    g[mask] = g_median[mask]
    r[mask] = r_median[mask]
    
    # Собираем обратно
    filtered_image = cv2.merge([b, g, r]).astype(np.uint8)
    
    return filtered_image, [b, g, r]
ч

image = cv2.imread("../../images/10.png")
b, g, r = cv2.split(image.astype(np.float32) / 255.0)

# Вычисление FFT
logMagnitudeB, phaseB = computeFFT(b)
logMagnitudeG, phaseG = computeFFT(g)
logMagnitudeR, phaseR = computeFFT(r)

# Визуализация и сохранение спектра
global_log_max = max(np.max(logMagnitudeB), np.max(logMagnitudeG), np.max(logMagnitudeR))
fft_b_vis = (logMagnitudeB / global_log_max * 255).astype(np.uint8)
fft_g_vis = (logMagnitudeG / global_log_max * 255).astype(np.uint8)
fft_r_vis = (logMagnitudeR / global_log_max * 255).astype(np.uint8)
obraz = cv2.merge([fft_b_vis, fft_g_vis, fft_r_vis])
cv2.imwrite("spectrum.jpg", obraz)

result, channels = deletePeaks(obraz)
cv2.imwrite("deletePeaks.jpg", result)


channelB = inverseFFT(channels[0]/255.0 * global_log_max, phaseB)
channelG = inverseFFT(channels[1]/255.0 * global_log_max, phaseG)
channelR = inverseFFT(channels[2]/255.0 * global_log_max, phaseR)

reconstructed = cv2.merge([channelB, channelG, channelR])
reconstructed = np.clip(reconstructed, 0, 1)
cv2.imwrite("reconstructed.jpg", (reconstructed * 255).astype(np.uint8))