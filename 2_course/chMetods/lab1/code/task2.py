import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import quad

# --- Параметры ---
R = 1.0
T = 2.0
t = np.linspace(-T, 2*T, 1000)

# --- Комплексная кусочная функция ---
def f(t, T=T, R=R):
    t_mod = np.mod(t + T/8, T) - T/8
    Re_f = np.piecewise(t_mod,
        [(-T/8 <= t_mod) & (t_mod < T/8),
         (T/8 <= t_mod) & (t_mod < 3*T/8),
         (3*T/8 <= t_mod) & (t_mod < 5*T/8),
         (5*T/8 <= t_mod) & (t_mod < 7*T/8)],
        [R,
         lambda x: 2*R - 8*R*x/T,
         -R,
         lambda x: -6*R + 8*R*x/T])
    Im_f = np.piecewise(t_mod,
        [(-T/8 <= t_mod) & (t_mod < T/8),
         (T/8 <= t_mod) & (t_mod < 3*T/8),
         (3*T/8 <= t_mod) & (t_mod < 5*T/8),
         (5*T/8 <= t_mod) & (t_mod < 7*T/8)],
        [lambda x: 8*R*x/T,
         R,
         lambda x: 4*R - 8*R*x/T,
         -R])
    return Re_f + 1j * Im_f

# --- Коэффициенты Фурье ---
def cN(n, T=T):
    omega_n = 2 * np.pi * n / T
    integrand = lambda t: f(t, T) * np.exp(-1j * omega_n * t)
    return (1/T) * quad(integrand, -T/2, T/2, complex_func=True)[0]

# --- Частичная сумма ряда Фурье ---
def fourier_series(t, N, T=T):
    return sum(cN(n, T) * np.exp(1j * 2*np.pi*n*t/T) for n in range(-N, N+1))

def parseval_check(T, N):
    energy_time = (1/T) * quad(lambda t: abs(f(t, T))**2, -T/2, T/2, limit=200)[0]
    energy_freq = sum(abs(cN(n, T))**2 for n in range(-N, N+1))

    print("=== Проверка равенства Парсеваля ===")
    print(f"(1/T) ∫|f(t)|² dt ≈ {energy_time:.6f}")
    print(f"∑|cₙ|² от -{N} до {N} ≈ {energy_freq:.6f}")
    print(f"Разница: {abs(energy_time - energy_freq):.6e}\n")

def print_fourier_coefficients(N, T):
    print(f"\n=== Коэффициенты Фурье при N = {N} ===")
    for n in [-1, 0, 1]:
        coef = cN(n, T)
        print(f"c_{n} = {coef.real:.6f} + {coef.imag:.6f}j  | |c_{n}| = {abs(coef):.6f}")

# --- Графики Re и Im частей ---
def plot_real_imag(t, N, T):
    f_values = f(t, T)
    G_N = fourier_series(t, N, T)

    plt.figure(figsize=(12, 6))
    plt.subplot(2, 1, 1)
    plt.plot(t, f_values.real, label="Re(f(t))", color='blue')
    plt.plot(t, G_N.real, label=f"Re(G_{N}(t))", color='maroon')
    plt.legend(); plt.grid(); plt.ylabel("Re")
    
    plt.subplot(2, 1, 2)
    plt.plot(t, f_values.imag, label="Im(f(t))", color='green')
    plt.plot(t, G_N.imag, label=f"Im(G_{N}(t))", color='orange')
    plt.legend(); plt.grid(); plt.ylabel("Im"); plt.xlabel("t")
    plt.suptitle(f"Сравнение Re и Im частей (N={N})")
    plt.tight_layout()
    plt.show()

# --- Параметрический график на комплексной плоскости ---
def plot_parametric(N_list, t, T):
    plt.figure(figsize=(8, 8))
    for N in N_list:
        GN = fourier_series(t, N, T)
        plt.plot(GN.real, GN.imag, label=f"G_{N}(t)")
    plt.plot(f(t, T).real, f(t, T).imag, 'k--', label="f(t)", linewidth=1.5)
    plt.xlabel("Re"); plt.ylabel("Im"); plt.grid(); plt.axis('equal')
    plt.legend(); plt.title("Параметрические кривые в комплексной плоскости")
    plt.show()

def plot_original_function(t, T):
    f_values = f(t, T)
    plt.figure(figsize=(12, 6))

    plt.subplot(2, 1, 1)
    plt.plot(t, f_values.real, label="Re(f(t))", color='blue')
    plt.grid(); plt.legend(); plt.ylabel("Re"); plt.title("Оригинальная функция f(t)")

    plt.subplot(2, 1, 2)
    plt.plot(t, f_values.imag, label="Im(f(t))", color='green')
    plt.grid(); plt.legend(); plt.ylabel("Im"); plt.xlabel("t")

    plt.tight_layout()
    plt.show()


# --- Запуск ---
plot_original_function(t, T)

N_vals_to_check = [1, 2, 3, 10]
for N in N_vals_to_check:
    plot_real_imag(t, N, T)
    print_fourier_coefficients(N, T)

plot_parametric(N_vals_to_check, t, T)
print()
parseval_check(T, max(N_vals_to_check))
