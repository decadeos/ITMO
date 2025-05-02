import numpy as np

def numericalGradient(f, x, h=1e-5):
    grad = np.zeros_like(x)
    fx = f(x)
    for i in range(len(x)):
        xT = x.copy()
        xT[i] += h
        grad[i] = (f(xT) - fx) / h
    return grad

def numericalHessian(f, x, h=1e-5):
    n = len(x)
    hess = np.zeros((n, n))
    for i in range(n):
        for j in range(i, n):
            x1, x2 = x.copy(), x.copy()
            x1[i] += h; x1[j] += h
            x2[i] += h; x2[j] -= h
            x3, x4 = x.copy(), x.copy()
            x3[i] -= h; x3[j] += h
            x4[i] -= h; x4[j] -= h
            hess[i,j] = (f(x1) - f(x2) - f(x3) + f(x4)) / (4 * h**2)
            hess[j,i] = hess[i,j]
    return hess