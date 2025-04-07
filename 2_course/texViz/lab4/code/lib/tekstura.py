import cv2
import numpy as np
from skimage.filters.rank import entropy
from skimage.morphology import disk, closing, remove_small_objects

