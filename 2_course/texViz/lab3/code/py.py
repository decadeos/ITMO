import cv2
from noises import *

image = cv2.imread("../images/flowers.jpg")

imImage = imNoise(image, 0.5)
plot(imImage, "impulsny", "../noise/impuls.png")

addImage = addNoise(image, 1)
plot(addImage, "additivny", "../noise/additive.png")

mulImage = mulNoise(image, 5)
plot(mulImage, "multiplicativny", "../noise/multiplicativny.png")

