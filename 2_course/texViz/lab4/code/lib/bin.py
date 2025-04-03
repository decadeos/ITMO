import cv2
import numpy as np

def binarizazia(image, t1, t2):
    imageGray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    roi = np.uint8((imageGray >= t1) & (imageGray <= t2)) * 255
    return roi

def binarizaziaAutomaticSrArifmetic(image):
    t = (np.max(image) - np.min(image)) / 2
    result = binarizazia(image, 0, t)
    return result


def binarizaziaOptimzeT(image):
    image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    gradX = np.abs(image[2:, 1:-1] - image[:-2, 1:-1])
    gradY = np.abs(image[1:-1, 2:] - image[1:-1, :-2])
    G = np.zeros_like(image, dtype=np.float32)
    G[1:-1, 1:-1] = np.maximum(gradX, gradY)
    numerator = np.sum(image * G)
    denominator = np.sum(G)
    t = numerator / denominator if denominator != 0 else 0.0

    _, result = cv2.threshold(image, t, 255, cv2.THRESH_BINARY)
    return result

def binarizaziaStatisticNetodOzy(image):
    image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    hist = cv2.calcHist([image], [0], None, [256], [0, 256])
    hist = hist.flatten() 
    N = image.size 
    p_i = hist / N
    sigmaMax = t = 0

    for k in range(1, 256):
        w1 = np.sum(p_i[:k+1])
        w2 = 1 - w1

        if w1 < 1e-10 or w2 < 1e-10:
            continue

        mu1 = np.sum(np.arange(k+1) * p_i[:k+1]) / w1
        mu2 = np.sum(np.arange(k+1, 256) * p_i[k+1:]) / w2

        sigmaQuad = w1 * w2 * (mu1 - mu2)**2

        if sigmaQuad > sigmaMax:
            sigmaMax = sigmaQuad
            t = k
    
    _, result = cv2.threshold(image, t, 255, cv2.THRESH_BINARY)
    return result