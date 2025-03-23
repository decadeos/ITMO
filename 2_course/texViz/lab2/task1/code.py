import cv2
import matplotlib.pyplot as plt
from defs import *
import os

image_path = os.path.join(os.path.dirname(__file__), "image.jpg")
I1 = cv2.imread(image_path)

I = cv2.imread(image_path)
I_rgb = convert_to_rgb(I)

operations = [
    ("Original", lambda img: img),
    ("Shifted", lambda img: sdvig(img, 50, 100)),
    ("Reflected by OX", lambda img: reflectOX(img)),
    ("Reflected by OY", lambda img: reflectOY(img)),
    ("Scaled", lambda img: scaling(img, 1.7, 0.5)),
    ("Rotated", lambda img: rotate(img, 30)),
    ("Affined", lambda img: affine_transform(img, 
        np.float32([[50, 300], [150, 200], [50, 50]]), 
        np.float32([[50, 200], [250, 200], [50, 100]]))),
    ("Beveled", lambda img: bevel(img, 0.5)),
    ("piecewiselineared", lambda img: (piecewiselinear(img, 2))),
    ("projectived", lambda img: (projective(img, 1.1, 0.35, 0, 0.2, 1.1, 0, 0.00075, 0.00005, 1))),
    ("polynomialed", lambda img: (polynomial(img, np.array([[0, 0], [1, 0], [0, 1], [0.0001, 0], [0.002, 0], [0.001, 0]])))),
    ("sinusoidaled", lambda img: (sinusoidal(img, 20, 90)))
]
for title, operation in operations:
    result = operation(I)
    result_rgb = convert_to_rgb(result)
    show(result_rgb, title)