import numpy as np

def arhim(f, grad_f, x, d, alpha_init=10.0, c1=1e-4, c2=0.9, max_iter=100):
    alpha = alpha_init
    fx = f(x)
    gx = grad_f(x)
    gxd = np.dot(gx, d)
    
    for _ in range(max_iter):
        x_new = x + alpha * d
        fx_new = f(x_new)
        gx_new = grad_f(x_new)
        gx_new_d = np.dot(gx_new, d)
        
        if fx_new > fx + c1 * alpha * gxd:
            alpha *= 0.5
        elif gx_new_d < c2 * gxd:
            alpha *= 1.5
        else:
            return alpha
            
    return alpha