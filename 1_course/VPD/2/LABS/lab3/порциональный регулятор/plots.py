import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Загрузка данных из файла
df1 = pd.read_csv('kp_10.csv', delimiter='\t')
data1 = df1.to_numpy()

df2 = pd.read_csv('kp_0.6.csv', delimiter='\t')  
data2 = df2.to_numpy()

df3 = pd.read_csv('kp_0.3.csv', delimiter='\t')  
data3 = df3.to_numpy()

# Создание массива времени для данных
time1 = np.linspace(0, 10, data1.shape[0])
time2 = np.linspace(0, 10, data2.shape[0])
time3 = np.linspace(0, 10, data3.shape[0])

print(data1.shape)

# Добавление линии на существующий график
plt.plot(time1, data1[:, 1], color="black", label='kp_10.csv')
plt.plot(time2, data2[:, 1], color="red", label='kp_0.6.csv')
plt.plot(time3, data3[:, 1], color="orange", label='kp_0.3.csv')

plt.axhline(y=135, color='green', linestyle='--', label='y = 135')

plt.grid(True)
plt.xlabel('Time')
plt.ylabel('Angle')
plt.legend()
plt.show()
