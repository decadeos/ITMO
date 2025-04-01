import cv2
import matplotlib.pyplot as plt
from skimage.util import *
import numpy as np

def kontrgarmonichesky(image, Q=0, kernel_size=3):
    # Конвертируем в float и добавляем малый коэффициент к нулевым пикселям
    image = image.astype(np.float32) + 1e-10
    
    # Создаем ядро
    kernel = np.ones((kernel_size, kernel_size), np.float32) / (kernel_size**2)
    
    # Вычисляем числитель и знаменатель с защитой от нулей
    numerator = cv2.filter2D(np.power(image, Q + 1), -1, kernel)
    denominator = cv2.filter2D(np.power(image, Q), -1, kernel)
    
    # Безопасное деление
    return np.divide(numerator, denominator, out=np.zeros_like(numerator), where=denominator>1e-10)

    