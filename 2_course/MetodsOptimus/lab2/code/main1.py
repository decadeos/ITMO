from collections import defaultdict
from gradGess import *
from func import *
import matplotlib.pyplot as plt
import numpy as np

testPoints = [
    np.array([0.5, 1.0, -0.5]),
    np.array([1.0, -1.0, 2.0]),
    np.array([0.0, 0.5, 2.5])
]

hValues = np.logspace(-10, -1, 50)

def evaluateAccuracy():
    results = defaultdict(lambda: ([[] for _ in range(3)], [[] for _ in range(3)]))  # (grad_errors, hess_errors)
    
    functions = {
        'trig': (trigFunc, exactGradTrig, exactHessTrig, 2),
        'poly': (polyFunc, exactGradPoly, exactHessPoly, 3),
        'complex': (complexFunc, exactGradComplex, exactHessComplex, 3)
    }

    for name, (func, exactGrad, exactHess, dim) in functions.items():
        for i, xFull in enumerate(testPoints):
            x = xFull[:dim]
            gradErrors, hessErrors = results[name]
            
            for h in hValues:
                numGrad = numericalGradient(func, x, h)
                numHess = numericalHessian(func, x, h)
                
                gradErrors[i].append(np.linalg.norm(numGrad - exactGrad(x)))
                hessErrors[i].append(np.linalg.norm(numHess - exactHess(x)))
    
    return results

def plotResults(results):
    plt.figure(figsize=(15, 10))
    colors = ['b-', 'g-', 'r-']
    
    for idx, name in enumerate(['trig', 'poly', 'complex']):
        gradErrors, hessErrors = results[name]
        
        for plot_pos, errors, title in zip([1, 2], [gradErrors, hessErrors], ['градиент', 'гессиан']):
            plt.subplot(3, 2, 2*idx + plot_pos)
            for j in range(3):
                plt.loglog(hValues, errors[j], colors[j], label=f'Точка {j+1}')
            
            plt.title(f'{name} функция ({title})')
            plt.xlabel('Шаг h')
            plt.ylabel('Ошибка')
            plt.legend()
            plt.grid(True)
    
    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    results = evaluateAccuracy()
    plotResults(results)