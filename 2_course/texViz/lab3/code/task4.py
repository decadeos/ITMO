import cv2
import numpy as np
import os

# Функции фильтров (исправленные)
def robertsFilter(img):
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) if len(img.shape) == 3 else img
    kernelX = np.array([[1, 0], [0, -1]], dtype=np.float32)
    kernelY = np.array([[0, 1], [-1, 0]], dtype=np.float32)
    gradX = cv2.filter2D(gray.astype(np.float32), -1, kernelX)
    gradY = cv2.filter2D(gray.astype(np.float32), -1, kernelY)
    return cv2.normalize(np.sqrt(gradX**2 + gradY**2), None, 0, 255, cv2.NORM_MINMAX, cv2.CV_8U)

def prewittFilter(img):
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) if len(img.shape) == 3 else img
    kernelX = np.array([[-1, 0, 1], [-1, 0, 1], [-1, 0, 1]], dtype=np.float32)
    kernelY = np.array([[-1, -1, -1], [0, 0, 0], [1, 1, 1]], dtype=np.float32)
    gradX = cv2.filter2D(gray.astype(np.float32), -1, kernelX)
    gradY = cv2.filter2D(gray.astype(np.float32), -1, kernelY)
    return cv2.normalize(np.sqrt(gradX**2 + gradY**2), None, 0, 255, cv2.NORM_MINMAX, cv2.CV_8U)

def sobelFilter(img):
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) if len(img.shape) == 3 else img
    return cv2.Sobel(gray, cv2.CV_8U, 1, 1, ksize=3)

def laplacianFilter(img):
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) if len(img.shape) == 3 else img
    return cv2.Laplacian(gray, cv2.CV_8U)

def cannyEdge(img):
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) if len(img.shape) == 3 else img
    return cv2.Canny(gray, 50, 150)

# Обработка изображения
img = cv2.imread('../images/house.jpg')
os.makedirs('../filtreted4', exist_ok=True)

for filter_func, name in [(robertsFilter, 'roberts'), 
                         (prewittFilter, 'prewitt'),
                         (sobelFilter, 'sobel'),
                         (laplacianFilter, 'laplacian'),
                         (cannyEdge, 'canny')]:
    result = filter_func(img)
    cv2.imwrite(f'../filtreted4/{name}.jpg', result)

print("Все фильтры применены успешно!")