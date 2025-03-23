import cv2
import numpy as np
import matplotlib.pyplot as plt
from defs import *
import os

# Путь к файлу 1
image_path1 = os.path.join(os.path.dirname(__file__), "podushka.png")
I1 = cv2.imread(image_path1)
I_rgb_1 = convert_to_rgb(I1)

# Путь к файлу 2
image_path2 = os.path.join(os.path.dirname(__file__), "bochka.png")
I2 = cv2.imread(image_path2)
I_rgb_2 = convert_to_rgb(I2)

I_barrel = correct_distortion(I_rgb_1, 0.1, 0.12, "barrel")
I_pincushion = correct_distortion(I_rgb_2, 0.1, 0.12, "pincushion")

show(I_barrel, "Barrel Distortion Correction")
show(I_pincushion, "Pincushion Distortion Correction")