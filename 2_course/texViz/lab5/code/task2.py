import cv2
import numpy as np
import matplotlib.pyplot as plt

# Чтение и преобразование изображения
img = cv2.imread('../images/pic11.png')
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
gray = cv2.GaussianBlur(gray, (9, 9), 2)

# Поиск кругов
circles = cv2.HoughCircles(
    gray, cv2.HOUGH_GRADIENT, dp=1.2, minDist=40,
    param1=400, param2=30, minRadius=15, maxRadius=100
)

# Отрисовка
out = img.copy()
if circles is not None:
    for x, y, r in np.uint16(np.around(circles[0])):
        cv2.circle(out, (x, y), r, (255, 0, 0), 2)
        cv2.circle(out, (x, y), 2, (0, 0, 255), 3)

# Визуализация
imgs = [cv2.cvtColor(img, cv2.COLOR_BGR2RGB), cv2.cvtColor(out, cv2.COLOR_BGR2RGB)]
titles = ['Оригинал', 'Найденные круги']

plt.figure(figsize=(10, 5))
for i, (im, title) in enumerate(zip(imgs, titles)):
    plt.subplot(1, 2, i+1)
    plt.imshow(im)
    plt.title(title)
    plt.axis('off')

plt.tight_layout()
plt.show()
