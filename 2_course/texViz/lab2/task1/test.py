import matplotlib; matplotlib.use('Agg')
import matplotlib.pyplot as plt
plt.plot([1,2,3])
plt.savefig('test.png')
print("Успешно! Проверьте файл test.png")
