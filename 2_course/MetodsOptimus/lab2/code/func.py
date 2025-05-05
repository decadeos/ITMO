import numpy as np
from math import sin, cos, exp, log, atan
## Для 1 задания функции 
def trigFunc(x):
    """sin(x1)*cos(x2) + sin(x1+x2)"""
    return sin(x[0]) * cos(x[1]) + sin(x[0] + x[1])

def polyFunc(x):
    """x1³ + 2x1²x2 - 3x1x2² + x2³ + x1x2x3"""
    return x[0]**3 + 2*x[0]**2*x[1] - 3*x[0]*x[1]**2 + x[1]**3 + x[0]*x[1]*x[2]

def complexFunc(x):
    """exp(x1)*ln(1+x2²) + arctan(x1*x3)"""
    return exp(x[0]) * log(1 + x[1]**2) + atan(x[0]*x[2])


# производные ' и ''
def exactGradTrig(x):
    return np.array([
        cos(x[0])*cos(x[1]) + cos(x[0] + x[1]),
        -sin(x[0])*sin(x[1]) + cos(x[0] + x[1])
    ])

def exactHessTrig(x):
    return np.array([
        [-sin(x[0])*cos(x[1]) - sin(x[0] + x[1]), -cos(x[0])*sin(x[1]) - sin(x[0] + x[1])],
        [-cos(x[0])*sin(x[1]) - sin(x[0] + x[1]), -sin(x[0])*cos(x[1]) - sin(x[0] + x[1])]
    ])

def exactGradPoly(x):
    return np.array([
        3*x[0]**2 + 4*x[0]*x[1] - 3*x[1]**2 + x[1]*x[2],
        2*x[0]**2 - 6*x[0]*x[1] + 3*x[1]**2 + x[0]*x[2],
        x[0]*x[1]
    ])

def exactHessPoly(x):
    return np.array([
        [6*x[0] + 4*x[1], 4*x[0] - 6*x[1], x[1]],
        [4*x[0] - 6*x[1], -6*x[0] + 6*x[1], x[0]],
        [x[1], x[0], 0]
    ])

def exactGradComplex(x):
    return np.array([
        exp(x[0])*log(1 + x[1]**2) + x[2]/(1 + (x[0]*x[2])**2),
        exp(x[0])*(2*x[1])/(1 + x[1]**2),
        x[0]/(1 + (x[0]*x[2])**2)
    ])

def exactHessComplex(x):
    h11 = exp(x[0])*log(1 + x[1]**2) - (2*x[0]*x[2]**2)/(1 + (x[0]*x[2])**2)**2
    h12 = exp(x[0])*(2*x[1])/(1 + x[1]**2)
    h13 = (1 - (x[0]*x[2])**2)/(1 + (x[0]*x[2])**2)**2
    h22 = exp(x[0])*(2 - 2*x[1]**2)/(1 + x[1]**2)**2
    return np.array([
        [h11, h12, h13],
        [h12, h22, 0],
        [h13, 0, -2*x[0]**2*x[2]/(1 + (x[0]*x[2])**2)**2]
    ])

# Для 2 задания функции

def f(x):
    A = np.array([[2, 1], 
              [1, 3]])
    b = np.array([1, -1])
    
    return x.T @ A @ x + b.T @ x