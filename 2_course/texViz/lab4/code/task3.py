from lib.kMeans import *
from lib.plot import *

image = cv2.imread('../images/im3.jpg')
segments = kMeans(image, k=4)

fig, axes = plt.subplots(1, len(segments), figsize=(15, 5))

# Отображаем каждый кластер в отдельной части фигуры
for i, seg in enumerate(segments):
    axes[i].imshow(seg)
    axes[i].set_title(f"Кластер {i+1}")
    axes[i].axis("off")

plt.tight_layout()
plt.show()