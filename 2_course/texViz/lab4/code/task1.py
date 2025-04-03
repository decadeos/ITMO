from lib.bin import *
from lib.plot import *


image = cv2.imread('../images/im.jpg')

for f, t in [
    (lambda x: binarizazia(x, 0, 100), "бинаризация по двойному диапазону"),
    (binarizaziaAutomaticSrArifmetic, 'автоматическая бинаризация t = среднее арифметическое'),
    (binarizaziaOptimzeT, 'бинаризация оптимальное t'),
    (binarizaziaStatisticNetodOzy, "вычисление порога методом Оцу и бинаризация")
]: plot(f(image), t)