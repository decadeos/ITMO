import cv2
import numpy as np
import matplotlib.pyplot as plt

def render_projections(img):
    gray_img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    projection_x = np.sum(gray_img, axis=0) / gray_img.shape[0]
    projection_y = np.sum(gray_img, axis=1) / gray_img.shape[1]

    plt.figure(figsize=(12, 6))

    plt.subplot(2, 2, 1)
    plt.title("Исходное изображение")
    plt.imshow(cv2.cvtColor(img, cv2.COLOR_BGR2RGB))
    plt.axis('off')

    plt.subplot(2, 2, 2)
    plt.title("Проекция на X")
    plt.plot(projection_x, color='blue')
    plt.xlabel("Позиция по X")
    plt.ylabel("Интенсивность")
    plt.grid(True)

    plt.subplot(2, 2, 3)
    plt.title("Проекция на Y")
    plt.plot(projection_y, range(gray_img.shape[0]), color='red')
    plt.xlabel("Интенсивность")
    plt.ylabel("Позиция по Y")
    plt.grid(True)

    plt.tight_layout()
    plt.show()

image = cv2.imread('lab1/im.jpg')
if image is None:
    print("Ошибка: Не удалось загрузить изображение. Проверьте путь к файлу.")
else:
    render_projections(image)