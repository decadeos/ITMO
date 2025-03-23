import cv2
import numpy as np
import matplotlib.pyplot as plt
import math

## функции для удобства
def show(image, title):
    plt.imshow(image)
    plt.title(title)
    plt.axis('off')
    plt.show()

def convert_to_rgb(image):
    return cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

def size(image):
    rows, cols = image.shape[0:2]
    return rows, cols

## линейные функции
def sdvig(image, tx, ty):
    rows, cols = size(image)
    T = np.float32([[1, 0, tx], [0, 1, ty]])
    shifted_image = cv2.warpAffine(image, T, (cols, rows))
    return shifted_image

def reflectOX(image):
    rows, cols = size(image)
    T = np.float32([[1 , 0 , 0] ,[0, -1, rows - 1]])
    I_reflect = cv2.warpAffine(image, T, (cols, rows))
    return I_reflect

def reflectOY(image):
    rows, cols = size(image)
    T = np.float32([[-1, 0, cols - 1], [0, 1, 0]])
    I_reflect = cv2.warpAffine(image, T, (cols, rows))
    return I_reflect

def scaling(image, scale_x, scale_y):
    rows, cols = size(image)
    T = np.float32([[scale_x, 0, 0] ,[0, scale_y, 0]])
    I_scale = cv2.warpAffine(image, T, (int(cols * scale_x), int(rows*scale_y)))
    return I_scale

def rotate(image, phi):
    rows, cols = size(image)
    phi = math.radians(phi)
    T = np.float32([[ math.cos(phi), -math.sin(phi), 0], [math.sin(phi), math.cos(phi), 0]])
    I_rotate = cv2.warpAffine(image, T, (cols, rows))
    return I_rotate

def affine_transform(image, pts_src, pts_dst):
    rows, cols = size(image)
    T = cv2.getAffineTransform(pts_src, pts_dst)
    affine_image = cv2.warpAffine(image, T, (cols, rows))
    return affine_image

def bevel(image, skos):
    rows, cols = size(image)
    T = np.float32([[1, skos, 0], [0 ,1, 0]])
    I_bevel = cv2.warpAffine(image, T, (cols, rows))
    return I_bevel

def piecewiselinear(image, stretch):
    rows, cols = size(image)
    T = np.float32([[stretch, 0, 0], [0, 1, 0]])
    I_piecewiselinear = image.copy()
    I_piecewiselinear[:, int(cols/2):, :] = cv2.warpAffine(I_piecewiselinear[:, int(cols/2):, :], T, (cols - int(cols/2), rows))
    return I_piecewiselinear

## нелинейные функции

def projective(image, a, b, c, d, e, f, g, h, i):
    rows, cols = size(image)
    T = np.float32([[a, b, c], [d, e, f], [g, h, i]])
    I_projective = cv2.warpPerspective(image, T, (cols, rows))
    return I_projective

def polynomial(image, T):
    rows, cols = size(image)
    I_polynomial = np.zeros_like(image)
    x, y = np.meshgrid(np.arange(cols), np.arange(rows))
    xnew = np.round(T[0, 0] + x*T[1, 0] + y*T[2, 0] + x*x*T[3, 0] + x*y*T[4, 0] + y*y*T[5, 0]).astype(np.float32)
    ynew = np.round(T[0, 1] + x*T[1, 1] + y*T[2, 1] + x*x*T[3, 1] + x*y*T[4, 1] + y*y*T[5, 1]).astype(np.float32)
    mask = np.logical_and(np.logical_and(xnew >= 0, xnew < cols), np.logical_and(ynew >= 0, ynew < rows))
    if image.ndim == 2:
        I_polynomial[ynew[mask].astype(int), xnew[mask].astype(int)] = image[y[mask], x[mask]]
    else:
        I_polynomial[ynew[mask].astype(int), xnew[mask].astype(int), :] = image[y[mask], x[mask], :]
    return I_polynomial

def sinusoidal(image, amplitude=20, frequency=90):
    rows, cols = size(image)
    u, v = np.meshgrid(np.arange(cols), np.arange(rows))
    u = u + amplitude * np.sin(2 * math.pi * v / frequency)
    u = u.astype(np.float32)
    v = v.astype(np.float32)
    distorted_image = cv2.remap(image, u, v, interpolation=cv2.INTER_LINEAR)
    return distorted_image