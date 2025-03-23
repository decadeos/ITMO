import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


df = pd.read_csv('data.csv')
data = df.to_numpy()

time = np.linspace(0, 10, data.shape[0])
plt.plot(time, data[:, 1], color='black')
plt.grid(True)
plt.xlabel('timeуу')  
plt.ylabel('angle')
plt.show()
