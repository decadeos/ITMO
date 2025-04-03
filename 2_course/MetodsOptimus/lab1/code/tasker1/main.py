from plot import plot, plot_convergence
import numpy as np
from golden import golden
from parabolic import parabolic
from brent import brent

def f(x):
    return -3*x*np.sin(0.75*x) + np.exp(-2*x)

def main():
    limLeft, limRight = 0, 2*np.pi
    
    # Golden Section
    x_min_g, f_min_g, golden_data, errors1 = golden(f, limLeft, limRight, 0.0001, 100)
    x_range = np.linspace(limLeft, limRight, 400)
    plot(f, x_range, golden_data, "Golden Section")
    
    # Parabolic (нужны 3 начальные точки)
    a, c, b = limLeft, (limLeft+limRight)/2, limRight  # Правильные начальные точки
    x_min_p, f_min_p, parabolic_data, errors2 = parabolic(f, a, c, b, 0.0001, 100)
    plot(f, x_range, parabolic_data, "Parabolic Method")
    
    # Brent
    x_min_b, f_min_b, brent_data, errors3 = brent(f, limLeft, limRight, 0.0001, 100)
    plot(f, x_range, brent_data, "Brent's Method")
    
    # Сравнение сходимости
    plot_convergence(
        [errors1, errors2[:-1], errors3],
        method_names=["Golden Section", "Parabolic", "Brent"]
    )
    
    print("\nResults:")
    print(f"Golden Section: x = {x_min_g:.6f}, f(x) = {f_min_g:.6f}")
    print(f"Parabolic: x = {x_min_p:.6f}, f(x) = {f_min_p:.6f}")
    print(f"Brent: x = {x_min_b:.6f}, f(x) = {f_min_b:.6f}")

if __name__ == "__main__":
    main()