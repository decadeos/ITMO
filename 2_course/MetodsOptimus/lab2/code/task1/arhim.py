import numpy as np

def arhim(f, gradF, x, d, alphaInit=1.0, c1=1e-4, c2=0.9, maxIter=100):
    alpha = alphaInit
    fx = f(x)
    gx = gradF(x)
    gxd = np.dot(gx, d)
    
    for _ in range(maxIter):
        xNew = x + alpha * d
        fxNew = f(xNew)
        gxNew = gradF(xNew)
        
        if fxNew > fx + c1 * alpha * gxd:
            alpha *= 0.5
        elif np.dot(gxNew, d) < c2 * gxd:
            alpha *= 1.5
        else:
            return alpha
            
    return alpha