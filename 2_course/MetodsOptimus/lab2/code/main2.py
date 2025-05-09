import numpy as np
import matplotlib.pyplot as plt
from gradGess import numericalGradient, numericalHessian
from newton import newton

from mpl_toolkits.mplot3d import Axes3D

A = np.array([[2, 1], 
              [1, 3]])
b = np.array([1, -1])

f = lambda x: x.T @ A @ x + b.T @ x

x0 = np.array([1000.0, 1100.0])
x_opt, history = newton(f, x0, alpha='wolfe', tol=1e-6)
history = np.array(history)

fig = plt.figure(figsize=(16, 8))

ax1 = fig.add_subplot(121, projection='3d')

x1 = np.linspace(-1500, 1500, 100)
x2 = np.linspace(-1500, 1500, 100)
X1, X2 = np.meshgrid(x1, x2)
Z = np.array([f(np.array([x, y])) for x, y in zip(X1.ravel(), X2.ravel())]).reshape(X1.shape)

ax1.plot_surface(X1, X2, Z, cmap='viridis', alpha=0.6)

# Траектория метода
f_history = [f(x) for x in history]
ax1.plot(history[:,0], history[:,1], f_history, 'ro-', linewidth=2, markersize=5)
ax1.set_title('3D', fontsize=14)
ax1.set_xlabel('x1', fontsize=12)
ax1.set_ylabel('x2', fontsize=12)
ax1.set_zlabel('f(x)', fontsize=12)

# 2. Графики сходимости
ax2 = fig.add_subplot(222)
ax2.plot([f(x) for x in history], 'o-', color='#2c3e50', linewidth=2)
ax2.set_title('Function Value', fontsize=14)
ax2.set_ylabel('f(x)', fontsize=12)
ax2.grid(True, linestyle='--', alpha=0.7)

ax3 = fig.add_subplot(224)
ax3.semilogy([np.linalg.norm(2*A@x+b) for x in history], 's-', color='#e74c3c', linewidth=2)
ax3.set_title('Gradient Norm', fontsize=14)
ax3.set_xlabel('Iteration', fontsize=12)
ax3.set_ylabel('||∇f||', fontsize=12)
ax3.grid(True, linestyle='--', alpha=0.7)

plt.tight_layout()
plt.show()
