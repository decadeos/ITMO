import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
#имена файлов
name1 = '10_0_10' + '.csv'
# name2 = '10_0.1_0.7' + '.csv'
# name3 = '10_0_0.7' + '.csv'
# name4 = '15_0.3_7' + '.csv'

df1 = pd.read_csv(name1)
data1 = df1.to_numpy()
# df2 = pd.read_csv(name2)  
# data2 = df2.to_numpy()
# df3 = pd.read_csv(name3)  
# data3 = df3.to_numpy()
# df4 = pd.read_csv(name4)
# data4 = df4.to_numpy()
# Создание массива времени для данных
time1 = np.linspace(0, 10, data1.shape[0])
time2 = np.linspace(0, 10, data2.shape[0])
time3 = np.linspace(0, 10, data3.shape[0])
time4 = np.linspace(0, 10, data4.shape[0])
# Добавление линии на существующий график
plt.plot(time1, data1[:, 1], color="black", label=name1)
plt.plot(time2, data2[:, 1], color="red", label=name2)
plt.plot(time3, data3[:, 1], color="orange", label=name3)
plt.plot(time4, data4[:, 1], color="blue", label=name4)
plt.axhline(y=135, color='green', linestyle='--', label='y = 135')
plt.grid(True)
plt.xlabel('Time')
plt.ylabel('Angle')
plt.legend()
plt.show()
