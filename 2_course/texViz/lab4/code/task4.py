import cv2
import numpy as np
from skimage.filters import rank
from skimage.morphology import rectangle
from skimage.feature import graycomatrix, graycoprops
import matplotlib.pyplot as plt

def texture_segmentation(I):
    E = rank.entropy(I, rectangle(9, 9))
    E_norm = (E - E.min()) / (E.max() - E.min())
    _, BW = cv2.threshold(np.uint8(E_norm * 255), 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)
    
    num_labels, labels, stats, _ = cv2.connectedComponentsWithStats(BW, 8, cv2.CV_32S)
    for i in range(1, num_labels):
        if stats[i, cv2.CC_STAT_AREA] < 2000:
            BW[labels == i] = 0
    
    kernel = np.ones((9,9), np.uint8)
    closed = cv2.morphologyEx(BW, cv2.MORPH_CLOSE, kernel)
    contours, _ = cv2.findContours(closed, cv2.RETR_CCOMP, cv2.CHAIN_APPROX_SIMPLE)
    mask = np.zeros_like(closed)
    cv2.drawContours(mask, contours, -1, 255, -1)
    return mask

image = cv2.imread('../images/im4.jpg', cv2.IMREAD_GRAYSCALE)
mask = texture_segmentation(image)
texture1 = image.copy()
texture1[mask != 255] = 0
texture2 = image.copy()
texture2[mask == 255] = 0

def analyze_texture(img, name):
    glcm = graycomatrix(img, [1], [0], symmetric=True, normed=True)
    contrast = graycoprops(glcm, 'contrast')[0, 0]
    energy = graycoprops(glcm, 'energy')[0, 0]
    homogeneity = graycoprops(glcm, 'homogeneity')[0, 0]
    print(f"\n{name}:")
    print(f"Контраст: {contrast:.4f}")
    print(f"Энергия: {energy:.4f}")
    print(f"Однородность: {homogeneity:.4f}")
    return contrast, energy, homogeneity

params1 = analyze_texture(texture1, "Текстура 1")
params2 = analyze_texture(texture2, "Текстура 2")

plt.figure(figsize=(15, 5))
plt.subplot(131), plt.imshow(image, cmap='gray'), plt.title('Оригинал')
plt.subplot(132), plt.imshow(texture1, cmap='gray'), plt.title('Текстура 1')
plt.subplot(133), plt.imshow(texture2, cmap='gray'), plt.title('Текстура 2')
plt.tight_layout()
plt.show()

def classify_texture(contrast, energy, homogeneity):
    if contrast < 5 and energy > 0.8:
        return "Гладкая"
    elif contrast > 10 and energy < 0.5:
        return "Шершавая"
    else:
        return "Средняя"

print("\nКлассификация:")
print("Текстура 1:", classify_texture(*params1))
print("Текстура 2:", classify_texture(*params2))