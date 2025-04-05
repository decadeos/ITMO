import cv2
import numpy as np
from sklearn.cluster import KMeans

def kMeans(image, k):
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

    imageLab = cv2.cvtColor(image, cv2.COLOR_RGB2Lab)
    L, a, b = cv2.split(imageLab)

    ab = np.stack((a.flatten(), b.flatten()), axis=1)

    kmeans = KMeans(n_clusters=k, random_state=42, n_init=3)
    labels = kmeans.fit_predict(ab)

    labels_2D = labels.reshape(image.shape[:2]) 

    segmentedImages = []

    for i in range(k):
        mask = (labels_2D == i)
        segment = np.zeros_like(image)
        segment[mask] = image[mask]
        segmentedImages.append(segment)

    return segmentedImages
