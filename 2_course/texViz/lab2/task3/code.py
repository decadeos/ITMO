import cv2
import os
import numpy as np

top_path = os.path.join(os.path.dirname(__file__), "ulitkiTop.jpg")
bot_path = os.path.join(os.path.dirname(__file__), "ulitkiBottom.jpg")
topPart = cv2.imread(top_path, cv2.IMREAD_COLOR)
botPart = cv2.imread(bot_path, cv2.IMREAD_COLOR)
templ_size = 10
templ = topPart[-templ_size:, :, :]
res = cv2.matchTemplate(botPart, templ, cv2.TM_CCOEFF)
min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(res)
result_height = topPart.shape[0] + botPart.shape[0] - max_loc[1] - templ_size
result_width = topPart.shape[1]
result_channels = topPart.shape[2]
result_img = np.zeros((result_height, result_width, result_channels), dtype=np.uint8)
result_img[0:topPart.shape[0], :, :] = topPart
result_img[topPart.shape[0]:, :, :] = botPart[max_loc[1] + templ_size:, :, :]
cv2.imwrite("stitchedImage.jpg", result_img)
cv2.imshow("Stitched Image", result_img)
cv2.waitKey(0)
cv2.destroyAllWindows()