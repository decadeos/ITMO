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

def gayNoise(image, mean, var): # (хихихи)
    rng = np.random.default_rng()
    gauss = (rng.normal(mean, var**0.5, image.shape)).reshape(image.shape)
    if image.dtype == np.uint8:
        noisyImage = (image.astype(np.float32) + gauss*255).clip(0, 255).astype(np.uint8)
    else :
        noisyImage = (image+gauss).astype(np.float32)
    return noisyImage

def kvantNoise(I):
    rng = np.random.default_rng()

    if I.dtype == np.uint8:
        I_f = I . astype ( np . float32 ) / 255
        vals = len ( np . unique ( I_f ))
        vals = 2 ** np . ceil ( np . log2 ( vals ))
        I_out = (255 * \
        ( rng . poisson ( I_f * vals ) / \
        float ( vals )). clip (0 , 1)). \
        astype ( np . uint8 )
    else :
        vals = len ( np . unique ( I ))
        vals = 2 ** np . ceil ( np . log2 ( vals ))
        I_out = \
        rng . poisson ( I * vals ) / float ( vals )

    return I_out