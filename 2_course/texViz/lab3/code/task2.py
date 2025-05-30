import cv2
import numpy as np
import matplotlib.pyplot as plt
from skimage.filters import gaussian

def gaus(image, q):
    filtered = gaussian(image, sigma=abs(q), preserve_range=True)
    filtered = np.clip(filtered, 0, 255).astype(np.uint8)
    return filtered

# image = cv2.imread("../noise/impuls.png")
# image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB) 

# result_q0, result_q1, result_q_neg1 = [contraharmonicMean(image, q) for q in [0, 1, -1]]

# images = [image, result_q0, result_q1, result_q_neg1]
# titles = ['Оригинал', 'Q=0', 'Q=1', 'Q=-1']

# plt.figure(figsize=(20, 6)) 
# for i in range(4):
#     plt.subplot(1, 4, i+1) 
#     plt.imshow(images[i])
#     plt.title(titles[i])
#     plt.axis('off')

# plt.tight_layout()
# plt.show()



def contraharmonicMean(img, q=0, kernel_size=3):
    img_float = img.astype(np.float32) + 1e-10
    if q == 0:
        return img
    
    kernel = np.ones((kernel_size, kernel_size), np.float32)
    numerator = cv2.filter2D(np.power(img_float, q + 1), -1, kernel)
    denominator = cv2.filter2D(np.power(img_float, q), -1, kernel)
    filtered = np.zeros_like(img_float)
    np.divide(numerator, denominator, out=filtered, where=denominator!=0)
    return np.clip(filtered, 0, 255).astype(np.uint8)

image = cv2.imread("../noise/kvant.png")
image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB) 

result_q0 = contraharmonicMean(image, 0)
result_q1 = contraharmonicMean(image, 1)
result_q_neg1 = contraharmonicMean(image, -1)

images = [image, result_q0, result_q1, result_q_neg1]
titles = ['Оригинал', 'Q=0', 'Q=1', 'Q=-1']

plt.figure(figsize=(20, 6))
for i in range(4):
    plt.subplot(1, 4, i+1)
    plt.imshow(images[i])
    plt.title(titles[i])
    plt.axis('off')

plt.tight_layout()
plt.show()