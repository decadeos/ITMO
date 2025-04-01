import cv2
from lib.filters import *
from lib.noises import *
image = cv2.imread("../noise/impuls.png")

result_q0, result_q1, result_q_neg1 = [kontrgarmonichesky(image, Q=q).astype(np.uint8) for q in [0, 1, -1]]

plot(result_q0, "отфильтрованный1", "../filtreted/отфильтрованный1.png")
plot(result_q1, "отфильтрованный2", "../filtreted/отфильтрованный2.png")
plot(result_q_neg1, "отфильтрованный3", "../filtreted/отфильтрованный3.png")