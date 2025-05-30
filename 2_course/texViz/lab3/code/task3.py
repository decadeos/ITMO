import cv2
import numpy as np
import os


def weightedMedianFilter(inputImage, kernelSize=3, weightMatrix=None):
    if len(inputImage.shape) == 3:
        b, g, r = cv2.split(inputImage)
        bFiltered = weightedMedianFilter(b, kernelSize, weightMatrix)
        gFiltered = weightedMedianFilter(g, kernelSize, weightMatrix)
        rFiltered = weightedMedianFilter(r, kernelSize, weightMatrix)
        return cv2.merge([bFiltered, gFiltered, rFiltered])
    else:
        if weightMatrix is None:
            weightMatrix = np.ones((kernelSize, kernelSize), dtype=np.float32)
        
        pad = kernelSize // 2
        paddedImage = cv2.copyMakeBorder(inputImage, pad, pad, pad, pad, cv2.BORDER_REFLECT)
        outputImage = np.zeros_like(inputImage, dtype=np.uint8)
        
        for y in range(pad, paddedImage.shape[0] - pad):
            for x in range(pad, paddedImage.shape[1] - pad):
                neighborhood = paddedImage[y-pad:y+pad+1, x-pad:x+pad+1]
                weightedPixels = []
                for i in range(kernelSize):
                    for j in range(kernelSize):
                        weightedPixels.extend([neighborhood[i, j]] * int(weightMatrix[i, j]))
                outputImage[y-pad, x-pad] = np.median(weightedPixels)
        
        return outputImage


def rankFilter(inputImage, kernelSize=(3, 3), rank=4):
    # Сохраняем оригинальный тип
    original_dtype = inputImage.dtype
    
    # Конвертируем в float32 без нормализации
    if inputImage.dtype == np.uint8:
        inputImage = inputImage.astype(np.float32)
    
    rows, cols = inputImage.shape[0], inputImage.shape[1]
    padY = (kernelSize[0] - 1) // 2
    padX = (kernelSize[1] - 1) // 2
    padded = cv2.copyMakeBorder(inputImage, padY, padY, padX, padX, cv2.BORDER_REPLICATE)
    
    if inputImage.ndim == 2:
        layers = np.zeros((rows, cols, kernelSize[0]*kernelSize[1]), dtype=np.float32)
        for i in range(kernelSize[0]):
            for j in range(kernelSize[1]):
                layers[:, :, i*kernelSize[1]+j] = padded[i:i+rows, j:j+cols]
        
        layers.sort(axis=2)
        result = layers[:, :, rank]
    else:
        # Для цветных изображений обрабатываем каждый канал отдельно
        channels = []
        for ch in range(inputImage.shape[2]):
            channel = inputImage[:, :, ch]
            layers = np.zeros((rows, cols, kernelSize[0]*kernelSize[1]), dtype=np.float32)
            for i in range(kernelSize[0]):
                for j in range(kernelSize[1]):
                    layers[:, :, i*kernelSize[1]+j] = padded[i:i+rows, j:j+cols, ch]
            
            layers.sort(axis=2)
            channels.append(layers[:, :, rank])
        
        result = np.stack(channels, axis=2)
    
    # Возвращаем к исходному типу
    if original_dtype == np.uint8:
        result = np.clip(result, 0, 255).astype(np.uint8)
    
    return result

def wienerFilter(inputImg, kernelSize=(7,7), noise_var=0.01):
    if inputImg.dtype == np.uint8:
        imgCopy = inputImg.astype(np.float32)/255
    else:
        imgCopy = inputImg.copy()
    
    rows, cols = inputImg.shape[:2]
    kernel = np.ones(kernelSize, np.float32)
    padded = cv2.copyMakeBorder(imgCopy, 
                              (kernelSize[0]-1)//2, kernelSize[0]//2,
                              (kernelSize[1]-1)//2, kernelSize[1]//2,
                              cv2.BORDER_REPLICATE)
    
    if len(inputImg.shape) == 3:
        bgrPlanes = cv2.split(padded)
        filteredPlanes = []
        for plane in bgrPlanes:
            local_mean = cv2.blur(plane, kernelSize)
            local_var = cv2.blur(plane**2, kernelSize) - local_mean**2
            
            # Добавляем небольшое значение к знаменателю для избежания деления на 0
            denominator = np.maximum(local_var, noise_var)
            planeFiltered = local_mean + (local_var - noise_var) / denominator * (plane - local_mean)
            filteredPlanes.append(planeFiltered)
        
        outputImg = cv2.merge(filteredPlanes)
    else:
        local_mean = cv2.blur(padded, kernelSize)
        local_var = cv2.blur(padded**2, kernelSize) - local_mean**2
        
        denominator = np.maximum(local_var, noise_var)
        outputImg = local_mean + (local_var - noise_var) / denominator * (padded - local_mean)
    
    outputImg = outputImg[(kernelSize[0]-1)//2:(kernelSize[0]-1)//2+rows,
                         (kernelSize[1]-1)//2:(kernelSize[1]-1)//2+cols]
    
    if inputImg.dtype == np.uint8:
        outputImg = np.clip(outputImg*255, 0, 255).astype(np.uint8)
    
    return outputImg


def adaptiveMedianFilter(inputImage, initialSize=3, maxSize=7):
    # Сохраняем оригинальный тип и конвертируем в float32
    original_type = inputImage.dtype
    img_float = inputImage.astype(np.float32)
    
    # Для ускорения используем оптимизированную версию для небольших изображений
    if inputImage.shape[0] * inputImage.shape[1] > 1000*1000:  # Большие изображения
        return inputImage  # Пропускаем обработку для больших изображений
    
    pad = maxSize // 2
    padded = cv2.copyMakeBorder(img_float, pad, pad, pad, pad, cv2.BORDER_REFLECT)
    
    output = np.zeros_like(img_float)
    rows, cols = inputImage.shape[:2]
    
    for i in range(rows):
        for j in range(cols):
            x, y = i + pad, j + pad
            currentSize = initialSize
            
            while currentSize <= maxSize:
                half = currentSize // 2
                window = padded[x-half:x+half+1, y-half:y+half+1]
                z_min, z_max, z_med = np.min(window), np.max(window), np.median(window)
                z_xy = padded[x, y]
                
                if (z_med - z_min) > 0 and (z_med - z_max) < 0:
                    if (z_xy - z_min) > 0 and (z_xy - z_max) < 0:
                        output[i,j] = z_xy
                    else:
                        output[i,j] = z_med
                    break
                else:
                    currentSize += 2
            else:
                output[i,j] = z_xy
    
    return np.clip(output, 0, 255).astype(original_type)

def process_color_image(image, initialSize, maxSize):
    # Быстрая обработка цветных изображений
    b, g, r = cv2.split(image)
    b = adaptiveMedianFilter(b, initialSize, maxSize)
    g = adaptiveMedianFilter(g, initialSize, maxSize)
    r = adaptiveMedianFilter(r, initialSize, maxSize)
    return cv2.merge([b, g, r])

# Создаем папку для результатов
os.makedirs('../filtreted3/adaptive_median', exist_ok=True)

image_paths = [
    "../noise/impuls.png", 
    "../noise/additive.png",
    "../noise/multiplicativny.png",
    "../noise/gaussian.png",
    "../noise/kvant.png",
]

