def hiQuad(array):

    sm = sum(array)
    ln = len(array)
    expected = sm / ln

    hiQuad = sum((i - expected)**2 / expected for i in array)   

    return round(hiQuad, 4)

import numpy as np

def kolmogorovSmirnov(array):

    ln = len(array)
    sortArray = np.sort(array)
    
    y = np.arange(1, ln+1) / ln
    teoria = sortArray / np.max(sortArray)
    kriteriy = np.max(np.abs(y - teoria))
    
    return round(kriteriy, 4)

