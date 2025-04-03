from lib.segment import *
from lib.plot import *

image = cv2.imread('../images/im.jpg')
image = segment(image)
plot(image, "Сегментация по Веберу")