import cv2
import matplotlib.pyplot as plt
from skimage.util import *
import numpy as np

def plot(image, title, save_path):
    plt.figure(figsize=(5, 5))
    plt.imshow(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
    plt.title(title)
    plt.axis('off')
    plt.savefig(save_path)
    plt.close()


def imNoise(image, amount=0.5):
    noisy_image = random_noise(image, mode="s&p", amount=amount)
    noisy_image = (noisy_image * 255).astype(np.uint8)
    return noisy_image


def addNoise(image, noise):
    noisy_image = image + noise
    return np.clip(noisy_image, 0, 255).astype(np.uint8)

def mulNoise(image, noise):
    noisy_image = image * noise
    return np.clip(noisy_image, 0, 255).astype(np.uint8)