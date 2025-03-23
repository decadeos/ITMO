import numpy as np
import pandas as pd

def f(x, y):
    return 3 * x - y / x

def modified_euler_method(f, x0, y0, h, x_end):
    x_values = [x0]
    y_values = [y0]
    
    x = x0
    y = y0
    
    while x < x_end:
        y_pred = y + h * f(x, y)   
        x_next = x + h           
        y = y + (h / 2) * (f(x, y) + f(x_next, y_pred))  
        x = x_next
        
        x_values.append(round(x, 4))  
        y_values.append(round(y, 4)) 
    
    return np.array(x_values), np.array(y_values)

x0 = 1    
y0 = 1    
h = 0.2   
x_end = 2

x_vals, y_vals = modified_euler_method(f, x0, y0, h, x_end)

results = pd.DataFrame({'x': x_vals, 'y (Mod. Eiler)': y_vals})
print("Results:")
print(results)