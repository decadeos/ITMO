import cv2
import numpy as np
import matplotlib.pyplot as plt

def plot_brightness_profile(image, line_start, line_end):

    height, width = image.shape[:2]
    
    num_points = 1000
    x = np.linspace(line_start[0], line_end[0], num_points)
    y = np.linspace(line_start[1], line_end[1], num_points)

    profile = [image[int(y[i]), int(x[i])] for i in range(num_points)]

    plt.figure(figsize=(8, 4))
    plt.plot(profile, color='black')
    plt.title("Профиль яркости")
    plt.xlabel("Позиция вдоль линии")
    plt.ylabel("Яркость")
    plt.grid(True)
    plt.tight_layout()
    plt.show()

image = cv2.imread('lab1/im2.jpg', cv2.IMREAD_GRAYSCALE)
if image is None:
    print("Ошибка: Не удалось загрузить изображение. Проверьте путь к файлу.")
else:
    # Задаем начальную и конечную точки линии
    line_start = (50, 100)  # (x1, y1)
    line_end = (400, 300)   # (x2, y2)

    plot_brightness_profile(image, line_start, line_end)