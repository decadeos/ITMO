from lib.func import *

image = getImage("../../images/10.png")

r, g, b = getImageChannel(image)

magnitudeNormR, phaseR = computeFFT(r)
magnitudeNormG, phaseG = computeFFT(g)
magnitudeNormB, phaseB = computeFFT(b)


fft_b_uint8 = (magnitudeNormR * 255).astype(np.uint8)
fft_g_uint8 = (magnitudeNormG * 255).astype(np.uint8)
fft_r_uint8 = (magnitudeNormB * 255).astype(np.uint8)

fft_combined = cv2.merge([fft_b_uint8, fft_g_uint8, fft_r_uint8])

cv2.imwrite("pectrum.jpg", fft_combined)

