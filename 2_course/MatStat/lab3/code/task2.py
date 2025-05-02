import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import laplace

mu = 2
n_list = [25, 10000]
fig, ax = plt.subplots(1, 2, figsize=(12, 4))

for i, n in enumerate(n_list):
    oshibki = []
    popalo = 0
    
    for _ in range(1000):
        data = laplace.rvs(loc=mu, size=n)
        sred = np.median(data)
        granica = 1.96 / np.sqrt(n)
        niz = sred - granica
        verh = sred + granica
        
        if niz <= mu <= verh:
            popalo += 1
            
        oshibki.append(sred)

    ax[i].hist(oshibki, bins=30, density=True, alpha=0.6, color='skyblue')
    ax[i].axvline(mu, color='red', linestyle='--')
    ax[i].axvspan(niz, verh, color='green', alpha=0.2)
    ax[i].set_title(f'n={n}')
    ax[i].set_xlabel('mu')
    ax[i].set_ylabel('Плотность')
    
    print(f"При n={n} попали {popalo/10}% раз")

plt.tight_layout()
plt.show()