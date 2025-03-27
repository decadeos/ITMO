import cv2
from noises import *

image = cv2.imread("../images/flowers.jpg")

imImage = imNoise(image, 0.1)
plot(imImage, "impulsny", "../noise/impuls.png")

addImage = addNoise(image, 100)
plot(addImage, "additivny", "../noise/additive.png")

mulImage = mulNoise(image, 5)
plot(mulImage, "multiplicativny", "../noise/multiplicativny.png")

gayImage = gayNoise(image, 1, 12)
plot(gayImage, "gaussian", "../noise/gaussian.png")

kvantImage = kvantNoise(image)
plot(kvantImage, "kvant", "../noise/kvant.png")

