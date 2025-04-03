import matplotlib.pyplot as plt
import cv2

def plot(image, title):
    plt.imshow(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
    plt.title(title)
    plt.axis('off')
    plt.show()

def save(image, path):
    cv2.imwrite(path, image)