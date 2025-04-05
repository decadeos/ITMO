import numpy as np
import matplotlib.pyplot as plt

theta = 0.5 
trueThetaKvadrat = theta**2
m = 1000 

sampleSizes = [i for i in range(10, 1000, 3)]

biases = []
variances = []
mses = []

for i in sampleSizes:
    ozenkaTheta = list()
    for extreptiza in range(m):
        sample = np.random.laplace(loc=0, scale=theta, size=i)

        ozenkaTheta.append(np.sum(sample**2) / (2 * i))

    ozenkaTheta = np.array(ozenkaTheta)

    bias = np.mean(ozenkaTheta) - trueThetaKvadrat
    variance = np.var(ozenkaTheta, ddof=1)
    mse = bias**2 + variance

    biases.append(bias)
    variances.append(variance)
    mses.append(mse)

plt.figure(figsize=(15, 5))

# График смещения
plt.subplot(1, 3, 1)
plt.plot(sampleSizes, biases, 'o-', color='blue', label='Смещение')
plt.xlabel('Размер выборки (n)', fontsize=12)
plt.ylabel('Смещение', fontsize=12)
plt.title('Зависимость смещения от n', fontsize=14)
plt.grid(True, linestyle='--', alpha=0.7)
plt.axhline(0, color='black', linestyle='-', linewidth=0.5)  # Нулевая линия, так как график колеблется около нуля

# График дисперсии
plt.subplot(1, 3, 2)
plt.plot(sampleSizes, variances, 'o-', color='green', label='Дисперсия')
plt.xlabel('Размер выборки (n)', fontsize=12)
plt.ylabel('Дисперсия', fontsize=12)
plt.title('Зависимость дисперсии от n', fontsize=14)
plt.grid(True, linestyle='--', alpha=0.7)

# График MSE
plt.subplot(1, 3, 3)
plt.plot(sampleSizes, mses, 'o-', color='red', label='MSE')
plt.xlabel('Размер выборки (n)', fontsize=12)
plt.ylabel('MSE', fontsize=12)
plt.title('Зависимость MSE от n', fontsize=14)
plt.grid(True, linestyle='--', alpha=0.7)

plt.tight_layout()
plt.show()