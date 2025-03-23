import cv2
import numpy as np
import matplotlib.pyplot as plt

def uniform_transform(I):
    if I.dtype == np.uint8:
        Inew = I.astype(np.float32) / 255
    else:
        Inew = I
    
    I_BGR = cv2.split(Inew)
    Inew_BGR = []
    
    for layer in I_BGR:
        Imin = layer.min()
        Imax = layer.max()
        Inew_layer = (layer - Imin) / (Imax - Imin)
        Inew_BGR.append(Inew_layer)
    
    Inew = cv2.merge(Inew_BGR)
    
    if I.dtype == np.uint8:
        Inew = (255 * Inew).clip(0, 255).astype(np.uint8)
    
    return Inew

def arithmetic_operations(I, value=50):
    Inew = I.astype(np.float32) + value / 255
    Inew = np.clip(Inew, 0, 1)
    if I.dtype == np.uint8:
        Inew = (255 * Inew).clip(0, 255).astype(np.uint8)
    return Inew

def dynamic_range_stretching(I):
    if I.dtype == np.uint8:
        Inew = I.astype(np.float32) / 255
    else:
        Inew = I
    
    I_BGR = cv2.split(Inew)
    Inew_BGR = []
    
    for layer in I_BGR:
        Imin = layer.min()
        Imax = layer.max()
        Inew_layer = (layer - Imin) / (Imax - Imin)
        Inew_BGR.append(Inew_layer)
    
    Inew = cv2.merge(Inew_BGR)
    
    if I.dtype == np.uint8:
        Inew = (255 * Inew).clip(0, 255).astype(np.uint8)
    
    return Inew

def exponential_transform(I, gamma=1.0):
    if I.dtype == np.uint8:
        Inew = I.astype(np.float32) / 255
    else:
        Inew = I
    
    Inew = np.power(Inew, gamma)
    Inew = np.clip(Inew, 0, 1)
    
    if I.dtype == np.uint8:
        Inew = (255 * Inew).clip(0, 255).astype(np.uint8)
    
    return Inew

def rayleigh_transform(I, sigma=0.4):
    if I.dtype == np.uint8:
        Inew = I.astype(np.float32) / 255
    else:
        Inew = I
    
    Inew = 1 - np.exp(-np.power(Inew, 2) / (2 * sigma**2))
    Inew = np.clip(Inew, 0, 1)
    
    if I.dtype == np.uint8:
        Inew = (255 * Inew).clip(0, 255).astype(np.uint8)
    
    return Inew

def power_law_transform(I):
    if I.dtype == np.uint8:
        Inew = I.astype(np.float32) / 255
    else:
        Inew = I
    
    Inew = np.power(Inew, 2/3)
    Inew = np.clip(Inew, 0, 1)
    
    if I.dtype == np.uint8:
        Inew = (255 * Inew).clip(0, 255).astype(np.uint8)
    
    return Inew

def hyperbolic_transform(I):
    if I.dtype == np.uint8:
        Inew = I.astype(np.float32) / 255
    else:
        Inew = I
    
    Inew = np.log(1 + Inew)
    Inew = Inew / np.log(2)
    Inew = np.clip(Inew, 0, 1)
    
    if I.dtype == np.uint8:
        Inew = (255 * Inew).clip(0, 255).astype(np.uint8)
    
    return Inew

def plot_histograms(original, transformed, title):
    colors = ('b', 'g', 'r')
    plt.figure(figsize=(14, 6))
    
    plt.subplot(2, 2, 1)
    for i, color in enumerate(colors):
        hist = cv2.calcHist([original], [i], None, [256], [0, 256])
        hist = hist / (original.shape[0] * original.shape[1])
        plt.plot(hist, color=color)
        plt.xlim([0, 256])
    plt.title("Гистограмма исходного изображения")
    plt.xlabel('Интенсивность пикселей')
    plt.ylabel('Плотность пикселей')
    
    plt.subplot(2, 2, 2)
    for i, color in enumerate(colors):
        hist = cv2.calcHist([original], [i], None, [256], [0, 256])
        hist = hist / (original.shape[0] * original.shape[1])
        cum_hist = np.cumsum(hist)
        plt.plot(cum_hist, color=color)
        plt.xlim([0, 256])
        plt.ylim([0, 1.1])
    plt.title("Кумулятивная гистограмма исходного изображения")
    plt.xlabel('Интенсивность пикселей')
    plt.ylabel('Накопленная плотность')
    
    plt.subplot(2, 2, 3)
    for i, color in enumerate(colors):
        hist = cv2.calcHist([transformed], [i], None, [256], [0, 256])
        hist = hist / (transformed.shape[0] * transformed.shape[1])
        plt.plot(hist, color=color)
        plt.xlim([0, 256])
    plt.title(f"Гистограмма после {title}")
    plt.xlabel('Интенсивность пикселей')
    plt.ylabel('Плотность пикселей')
    
    plt.subplot(2, 2, 4)
    for i, color in enumerate(colors):
        hist = cv2.calcHist([transformed], [i], None, [256], [0, 256])
        hist = hist / (transformed.shape[0] * transformed.shape[1])
        cum_hist = np.cumsum(hist)
        plt.plot(cum_hist, color=color)
        plt.xlim([0, 256])
        plt.ylim([0, 1.1])
    plt.title(f"Кумулятивная гистограмма после {title}")
    plt.xlabel('Интенсивность пикселей')
    plt.ylabel('Накопленная плотность')
    
    plt.tight_layout()
    plt.show()

# Загрузка изображения
I = cv2.imread('lab1/im.jpg')

if I is None:
    print("Ошибка: Не удалось загрузить изображение. Проверьте путь к файлу.")
else:
    # Применение различных преобразований
    transformations = {
        "линейного преобразования": uniform_transform(I),
        "арифметических операций": arithmetic_operations(I),
        "растяжения динамического диапазона": dynamic_range_stretching(I),
        "экспоненциального преобразования": exponential_transform(I, gamma=1.5),
        "преобразования по закону Рэлея": rayleigh_transform(I),
        "преобразования по закону степени 2_3": power_law_transform(I),  # Заменяем "/" на "_"
        "гиперболического преобразования": hyperbolic_transform(I),
    }
    
    for title, transformed in transformations.items():
        # Заменяем пробелы на "_" в названии файла
        filename = title.replace(" ", "_") + ".jpg"
        # Сохраняем изображение
        cv2.imwrite(filename, transformed)
        # Строим гистограммы
        plot_histograms(I, transformed, title)
    
    print("Все преобразования выполнены и сохранены в файлы.")