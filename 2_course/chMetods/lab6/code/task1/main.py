import numpy as np
import matplotlib . pyplot as plt
from PIL import Image

directoryPath = "../../images/"
image = Image.open(directoryPath + "10.png")
imageArray = np.array(image)

imageFloat = imageArray.astype(np.float64) / 255.0

fftChannels = list()

for ch in range(imageFloat.shape[2]):
    fftChannel = np.fft.fftshift(np.fft.fft2(imageFloat[:, :, ch]))
    fftChannels.append(fftChannel)
fftImage = np.stack(fftChannels, axis=-1)

magnitude = np.abs(fftImage)
phase = np.angle(fftImage)

logMagnitude = np.log(magnitude + 1)
normalizedLogMagnitude = (logMagnitude - np.min(logMagnitude)) / (np.max(logMagnitude) - np.min(logMagnitude))

logMagnitudeImage = (normalizedLogMagnitude * 255).astype(np.uint8)
Image.fromarray(logMagnitudeImage).save(directoryPath + "logMagnitude.png")

logMagnitudeCorrect = Image.open(directoryPath + "rec4.jpg")

if logMagnitudeCorrect.mode == 'RGBA':
    logMagnitudeCorrect = logMagnitudeCorrect.convert('RGB')

logMagnitudeCorrect = np.array(logMagnitudeCorrect).astype(np.float64) / 255.0
minOriginal = np.min(np.log(np.abs(fftImage) + 1))
maxOriginal = np.max(np.log(np.abs(fftImage) + 1))
logMagnitudeScaled = logMagnitudeCorrect * (maxOriginal - minOriginal) + minOriginal
magnitudeCorrect = np.exp(logMagnitudeScaled) - 1

filteredFft = magnitudeCorrect * np.exp(1j * phase)
filteredImage = np.zeros_like(imageFloat)
for channel in range(3):
    ifft = np.fft.ifft2(np.fft.ifftshift(filteredFft[:, :, channel]))
    filteredImage[:, :, channel] = np.abs(ifft)

filteredImage = np.clip(filteredImage, 0, 1)  
filteredImage = (filteredImage * 255).astype(np.uint8)
Image.fromarray(filteredImage).save(directoryPath + "final4.png")