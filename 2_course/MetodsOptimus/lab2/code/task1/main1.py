from gradGess import *
from func import *
import matplotlib.pyplot as plt
import numpy as np

# Общие тестовые точки для всех функций (адаптируются под размерность)
testPoints = [
    np.array([0.5, 1.0, -0.5]),    # Точка 1 (3D)
    np.array([1.0, -1.0, 2.0]),    # Точка 2 (3D)
    np.array([0.0, 0.5, 2.5])      # Точка 3 (3D)
]

hValues = np.logspace(-10, -1, 50)

def evaluateAccuracy():
    results = {}
    funcMap = {
        'trig': trigFunc,
        'poly': polyFunc,
        'complex': complexFunc
    }
    exactGrads = {
        'trig': exactGradTrig,
        'poly': exactGradPoly,
        'complex': exactGradComplex
    }
    exactHessians = {
        'trig': exactHessTrig,
        'poly': exactHessPoly,
        'complex': exactHessComplex
    }

    for name in ['trig', 'poly', 'complex']:
        gradErrors = [[] for _ in range(3)]  # По три точки для каждой функции
        hessErrors = [[] for _ in range(3)]
        
        for h in hValues:
            for i in range(3):  # Для каждой тестовой точки
                # Берем только нужное количество координат для текущей функции
                dim = 2 if name == 'trig' else 3
                x = testPoints[i][:dim]
                
                numGrad = numericalGradient(funcMap[name], x, h)
                numHess = numericalHessian(funcMap[name], x, h)
                
                gradErrors[i].append(np.linalg.norm(numGrad - exactGrads[name](x)))
                hessErrors[i].append(np.linalg.norm(numHess - exactHessians[name](x)))
        
        results[name] = (gradErrors, hessErrors)
    
    return results

def plotResults(results):
    plt.figure(figsize=(15, 10))
    colors = ['b-', 'g-', 'r-']  # Разные цвета для разных точек
    
    for i, name in enumerate(['trig', 'poly', 'complex']):
        gradErrors, hessErrors = results[name]
        
        plt.subplot(3, 2, 2*i+1)
        for j in range(3):
            plt.loglog(hValues, gradErrors[j], colors[j], label=f'Точка {j+1}')
        plt.title(f'{name} функция (градиент)')
        plt.xlabel('Шаг h')
        plt.ylabel('Ошибка')
        plt.legend()
        plt.grid(True)
        
        plt.subplot(3, 2, 2*i+2)
        for j in range(3):
            plt.loglog(hValues, hessErrors[j], colors[j], label=f'Точка {j+1}')
        plt.title(f'{name} функция (гессиан)')
        plt.xlabel('Шаг h')
        plt.ylabel('Ошибка')
        plt.legend()
        plt.grid(True)
    
    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    results = evaluateAccuracy()
    plotResults(results)