import pandas as pd
import matplotlib.pyplot as plt

# Загрузка данных из файла sqrt.csv
df = pd.read_csv('1.1.csv', header=None)
x = df[0]
y = df[1]

plt.xlim(-1, 1)
plt.ylim(-1, 1)

# Построение графика
plt.plot(x, y, linestyle='solid', color="red")
plt.title('Зависимость координат x и y')
plt.xlabel('x')
plt.ylabel('y')
plt.grid(True)
plt.show()