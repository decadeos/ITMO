import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

data = pd.read_csv('U(I).csv', sep='\t', header=None)

# Извлечение данных из столбцов
U = data[0]  
I = data[1]  

degree = 1  
coefficients = np.polyfit(I, U, degree)
polynomial = np.poly1d(coefficients)
U_appr = polynomial(I)

# Построение графика
plt.plot(I, U, linestyle='-', label='Исходные данные')
plt.plot(I, U_appr, label='Аппроксимация '.format(degree))
plt.title('Зависимость напряжения от силы тока')
plt.xlabel('Сила тока, А')
plt.ylabel('Напряжение, В')
plt.grid(True)
plt.legend()
plt.show()
