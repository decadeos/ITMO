import numpy as np
import matplotlib.pyplot as plt
from PIL import Image
from scipy.signal import convolve2d
from scipy.fft import fft2, ifft2, fftshift

# Загрузка и подготовка изображения
image_path = "../../images/pic.jpg"
original_image = Image.open(image_path).convert('L')
image_data = np.array(original_image) / 255.0

# Функции для создания ядер свертки
def create_gaussian_kernel(size):
    sigma = (size - 1) / 6
    axis = np.linspace(-(size - 1) / 2, (size - 1) / 2, size)
    x_grid, y_grid = np.meshgrid(axis, axis)
    kernel = np.exp(-(x_grid**2 + y_grid**2) / (2 * sigma**2))
    return kernel / np.sum(kernel)

def create_box_kernel(size):
    return np.ones((size, size)) / (size**2)

# Словарь ядер свертки
convolution_kernels = {
    "Гаусс (5)": create_gaussian_kernel(5),
    "Гаусс (7)": create_gaussian_kernel(7),
    "Гаусс (21)": create_gaussian_kernel(21),
    "Блок (5)": create_box_kernel(5),
    "Блок (7)": create_box_kernel(7),
    "Блок (11)": create_box_kernel(11),
    "Резкость": np.array([[0, -1, 0], [-1, 5, -1], [0, -1, 0]]),
    "Края": np.array([[-1, -1, -1], [-1, 8, -1], [-1, -1, -1]]),
    "Канни (Sobel X)": np.array([[-1, 0, 1], [-2, 0, 2], [-1, 0, 1]]),
    "Канни (Sobel Y)": np.array([[-1, -2, -1], [0, 0, 0], [1, 2, 1]])
}

# Вычисление Фурье-образа исходного изображения
fft_original = fft2(image_data)
log_fft_original = np.log(1 + np.abs(fftshift(fft_original)))

# Отображение исходного изображения и его спектра
# fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 5))
# ax1.imshow(image_data, cmap='gray')
# ax1.axis('off')

# ax2.imshow(log_fft_original, cmap='gray')
# ax2.axis('off')
# plt.tight_layout()

# Обработка каждого ядра свертки
for kernel_name, kernel_matrix in convolution_kernels.items():
    # Подготовка ядра для FFT
    image_height, image_width = image_data.shape
    kernel_height, kernel_width = kernel_matrix.shape
    
    padded_kernel = np.zeros_like(image_data)
    padded_kernel[:kernel_height, :kernel_width] = kernel_matrix
    
    # Фурье-образ ядра
    fft_kernel = fft2(padded_kernel)
    log_fft_kernel = np.log(1 + np.abs(fftshift(fft_kernel)))
    
    # Фильтрация в частотной области
    filtered_fft = fft_original * fft_kernel
    filtered_image_freq = np.real(ifft2(filtered_fft))
    log_filtered_fft = np.log(1 + np.abs(fftshift(filtered_fft)))
    
    # Свертка в пространственной области
    conv_result_spatial = convolve2d(image_data, kernel_matrix, 
                                   mode='same', boundary='symm')
    
    # Создание фигуры для сравнения результатов
    fig, axes = plt.subplots(2, 2, figsize=(12, 8))
    fig.suptitle(f'Ядро: {kernel_name}', fontsize=16)
    
    # Пространственная свертка
    axes[0, 0].imshow(conv_result_spatial, cmap='gray')
    axes[0, 0].set_title('Свертка')
    axes[0, 0].axis('off')
    
    # Частотная фильтрация
    axes[0, 1].imshow(filtered_image_freq, cmap='gray')
    axes[0, 1].set_title('Частотная фильтрация')
    axes[0, 1].axis('off')
    
    # Спектр ядра
    axes[1, 0].imshow(log_fft_kernel, cmap='gray')
    axes[1, 0].set_title('Спектр ядра')
    axes[1, 0].axis('off')
    
    # Спектр фильтрованного изображения
    axes[1, 1].imshow(log_filtered_fft, cmap='gray')
    axes[1, 1].set_title('Спектр после фильтрации')
    axes[1, 1].axis('off')
    
    plt.tight_layout()
plt.show()