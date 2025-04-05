from lib.tekstura import *


image = cv2.imread('../images/im4.jpg')
segmented = texture_segmentation(image)
cv2.imshow('Result', segmented)
cv2.waitKey(0)