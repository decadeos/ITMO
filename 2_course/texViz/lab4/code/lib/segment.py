import cv2
import numpy as np

def weber(i):
    if 0 <= i <= 88:
        return 20 - (12 * i) / 88
    elif 88 < i <= 138:
        return 0.002 * (i - 88)**2
    elif 138 < i <= 255:
        return 7 * (i - 138) / 117 + 13
    else:
        return 0


def segment(image):
    image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    segmented = image.copy()
    
    n = 0
    iN = 0
    
    while iN <= 255:
        w = weber(iN)
        upperBound = min(iN + w, 255)
        
        mask = (image >= iN) & (image <= upperBound)
        segmented[mask] = min(n * 30, 255)
        
        iN = upperBound + 1
        n += 1
        
        if upperBound == 255:
            break
    
    return segmented