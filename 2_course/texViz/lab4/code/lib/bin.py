import cv2
import numpy as np
import matplotlib.pyplot as plt

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