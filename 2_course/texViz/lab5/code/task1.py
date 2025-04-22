import numpy as np
import cv2
import matplotlib.pyplot as plt

img = cv2.imread('pic4.png')
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
edges = cv2.Canny(gray, 50, 200, apertureSize=3)
img_lines = img.copy()

lines = cv2.HoughLinesP(edges, 1, np.pi / 180, 100, minLineLength=30, maxLineGap=10)
count, max_len, min_len = 0, 0, float('inf')

if lines is not None:
    count = len(lines)
    for x1, y1, x2, y2 in lines[:, 0]:
        l = np.hypot(x2 - x1, y2 - y1)
        max_len, min_len = max(max_len, l), min(min_len, l)
        cv2.line(img_lines, (x1, y1), (x2, y2), (255, 0, 0), 1)
        for pt in [(x1, y1), (x2, y2)]:
            cv2.circle(img_lines, pt, 4, (0, 0, 255), -1)

hough = cv2.HoughLines(edges, 1, np.pi / 180, 100)
acc = np.zeros((180, 180), dtype=np.uint8)
if hough is not None:
    for rho, theta in hough[:, 0]:
        acc[int(rho) % 180, int(np.degrees(theta)) % 180] += 1

titles = ['Исходник', 'Canny', 'Хаф', 'Линии']
images = [cv2.cvtColor(img, cv2.COLOR_BGR2RGB), edges, acc, cv2.cvtColor(img_lines, cv2.COLOR_BGR2RGB)]
cmaps = ['gray', 'gray', 'hot', 'gray']

fig, axs = plt.subplots(1, 4, figsize=(18, 5))
for ax, title, img, cmap in zip(axs, titles, images, cmaps):
    ax.imshow(img, cmap=cmap if cmap != 'gray' else None)
    ax.set_title(title)
    ax.axis('off')

plt.tight_layout()
plt.show()

print('Линий:', count, 'Макс:', round(max_len, 2), 'Мин:', round(min_len, 2))
