import cv2
import numpy as np
import matplotlib.pyplot as plt

# Чтение изображения
img = cv2.imread('../images/pic10.png')
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

# Применение оператора Собеля
sobel_x = cv2.Sobel(gray, cv2.CV_16S, 1, 0, ksize=3)
sobel_y = cv2.Sobel(gray, cv2.CV_16S, 0, 1, ksize=3)
abs_x = cv2.convertScaleAbs(sobel_x)
abs_y = cv2.convertScaleAbs(sobel_y)
edges = cv2.addWeighted(abs_x, 0.5, abs_y, 0.5, 0)
# 1489 11, \\\ 1200, 7 \\\ 1350, 20, 10
# Поиск кругов методом Хафа по градиенту
circles = cv2.HoughCircles(
    edges, cv2.HOUGH_GRADIENT, dp=1.2, minDist=40,
    param1=1350, param2=50, minRadius=15, maxRadius=100
)

# Отрисовка
out = img.copy()
if circles is not None:
    for x, y, r in np.uint16(np.around(circles[0])):
        cv2.circle(out, (x, y), r, (255, 0, 0), 2)
        cv2.circle(out, (x, y), 2, (0, 0, 255), 3)

# Визуализация
imgs = [cv2.cvtColor(img, cv2.COLOR_BGR2RGB), cv2.cvtColor(out, cv2.COLOR_BGR2RGB)]
titles = ['Оригинал', 'Круги после Собеля']

plt.figure(figsize=(10, 5))
for i, (im, title) in enumerate(zip(imgs, titles)):
    plt.subplot(1, 2, i+1)
    plt.imshow(im)
    plt.title(title)
    plt.axis('off')

plt.tight_layout()
plt.show()
