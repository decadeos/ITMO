import cv2
import numpy as np
import matplotlib.pyplot as plt

## функции для удобства
def show(image, title):
    plt.imshow(image)
    plt.title(title)
    plt.axis('off')
    plt.show()

def convert_to_rgb(image):
    return cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

def size(image):
    rows, cols = image.shape[0:2]
    return rows, cols

## дистории
def correct_distortion(image, F3, F5, type):
    rows, cols = size(image)
    xi, yi = np.meshgrid(np.arange(cols), np.arange(rows))
    xmid = cols / 2.0
    ymid = rows / 2.0
    xi = xi - xmid
    yi = yi - ymid
    r, theta = cv2.cartToPolar(xi / xmid, yi / ymid)
    if type == "barrel": r = r + F3 * r**3 + F5 * r**5  # Бочкообразная
    elif type == "pincushion": r = r - F3 * r**3 - F5 * r**5  # Подушкообразная
    else: raise ValueError("Используйте 'barrel' или 'pincushion'.")
    u, v = cv2.polarToCart(r, theta)
    u = u * xmid + xmid
    v = v * ymid + ymid
    corrected_image = cv2.remap(image, u.astype(np.float32), v.astype(np.float32), interpolation=cv2.INTER_LINEAR,)
    return corrected_image
    
