import numpy as np
from arhim import *
from gradGess import *

def newton(f, x0, alpha='wolfe', tol=1e-6, maxIter=100, h=1e-5):
	x = np.array(x0, dtype=float)
	history = [x.copy()]
	
	for _ in range(maxIter):
		grad = numericalGradient(f, x, h)
		if np.linalg.norm(grad) < tol:
			break
		
		hessian = numericalHessian(f, x, h)
		direction = -np.linalg.solve(hessian, grad)
	
		if alpha == 'wolfe':
			step = arhim(f, lambda x: numericalGradient(f, x, h), x, direction)
		else:
			step = 1.0
	
		x += step * direction
		history.append(x.copy())
	
	return x, np.array(history)