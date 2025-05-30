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
    noisyImage = image + noise
    return np.clip(noisyImage, 0, 255).astype(np.uint8)

def mulNoise(image, noise):
    noisyImage = image * noise
    return np.clip(noisyImage, 0, 255).astype(np.uint8)

def gayNoise(img, mean, var):
    noise = np.random.normal(mean, var**0.5, img.shape)
    return np.clip(img + noise * (255 if img.dtype == np.uint8 else 1), 0, 255).astype(img.dtype)

def kvantNoise(img):
    rng = np.random.default_rng()
    if img.dtype == np.uint8:
        img = img.astype(float) / 255
        noisy = rng.poisson(img * 2) / 2
        noisy = (255 * noisy.clip(0, 1)).astype(np.uint8)
    else:
        noisy = rng.poisson(img * 2) / 2
    
    return noisy