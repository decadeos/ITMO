import cv2
import numpy as np
from skimage.filters.rank import entropy
from skimage.morphology import disk, closing, remove_small_objects

def texture_segmentation(image):
    # 1. Конвертация в grayscale
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    
    # 2. Расчёт энтропии (размер окна можно регулировать)
    E = entropy(gray, disk(7))  # Увеличил размер окна для лучшего выделения
    
    # 3. Нормализация и бинаризация
    E_norm = ((E - E.min()) / (E.max() - E.min()) * 255).astype(np.uint8)
    _, binary = cv2.threshold(E_norm, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)
    
    # 4. Удаление мелких объектов
    cleaned = remove_small_objects(binary.astype(bool), min_size=1000)
    
    # 5. Морфологическое замыкание
    closed = closing(cleaned, np.ones((15,15)))  # Увеличил размер ядра
    
    # 6. Поиск границ
    edges = cv2.Canny(closed.astype(np.uint8)*255, 50, 150)
    
    # 7. Наложение границ на исходное изображение
    result = image.copy()
    result[edges > 0] = [0, 0, 255]  # Красные границы (BGR формат)
    
    return result
