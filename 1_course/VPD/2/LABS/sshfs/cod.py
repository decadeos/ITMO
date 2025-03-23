#!/usr/bin/env python3
import ev3dev2.motor as motor
import math

file = open("1_0.csv","w")

motor_a=motor.LargeMotor(motor.OUTPUT_A)
motor_b=motor.LargeMotor(motor.OUTPUT_B)

Ks = 0.1  ## коэффициент
Kr = 0.1  ## коэффициент

Yg = 1  ## точки, к которым мы едем
Xg = 0  ## точки, к которым мы едем

x = 0  ## init
y = 0  ## init

r =  0.05536/2   ## радиус колеса
B =  0.17  ## рассстояние между колесами

ksiR = motor_a.position  ## текущий Б угол
ksiL = motor_b.position  ## текущий А угол

p = 0  ## направляющий вектор 

teta = 0  ## угол между поворотом мотора и осью OX

h = 0.02

while p != 0:
    
    p = math.sqrt(math.pow((Xg - x), 2) + (math.pow((Yg - y), 2)))  ## длина направляющего вектора

    ksi = math.atan2(Yg, Xg)
    alpha = ksi - teta  ## курсовой угол

    ksiR = abs(ksiL - motor_a.position)  ## текущий дельта угол на правом колесе
    ksil = abs(ksiR - motor_b.position)  ## текущий дельта угол на левом колесе
    
###########################################################################
    ## вычисление текущего положения робота
    deltaX = (ksiR + ksiL) * (r/2) * h
    deltaY = (ksiR + ksiL) * (r/2) * h
    deltaTeta = (ksiR - ksiL) * (r/B)

    xNew = x + deltaX
    yNew = y + deltaY
    tetaNew = teta + deltaTeta

    x = xNew
    y = yNew
    teta = tetaNew
###########################################################################

    if Ks > 0:
        Us = Ks * p
    if Kr > 0:
        Ur = Kr * alpha 

    f.write('{}, {}\n'.format(round(x, 2), round(y, 2)))
    
    motor_a.run_direct(duty_cycle_sp=(Us + Ur))
    motor_b.run_direct(duty_cycle_sp=(Us - Ur))