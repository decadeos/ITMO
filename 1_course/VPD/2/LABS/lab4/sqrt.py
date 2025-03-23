#!/usr/bin/env python3
import ev3dev2.motor as motor
import math
import time

file = open("sqrt.csv","w")

motor_a = motor.LargeMotor(motor.OUTPUT_A)
motor_b = motor.LargeMotor(motor.OUTPUT_B)

Ks = 100  ## коэффициент
Kr = 150  ## коэффициент

# xg = [ 1, 0, -1, 0]
# yg = [ 0, 1, 0, -1]

xg = [ 1, -1, -1, 1, 1]
yg = [ 1, 1, -1, -1, 1]

x = 0  ## init
y = 0  ## init

r = 0.05536 / 2  ## радиус колеса
B = 0.17  ## рассстояние между колесами

p = 0  ## направляющий вектор

theta = 0  ## угол между поворотом мотора и осью OX

h = 0.02

omega_l = 0
omega_r = 0

u_left = 0
u_right = 0

omega = (omega_l + omega_r) * r / B

V = (omega_r + omega_l) * r / 2

deltaX = V * math.cos(theta)
deltaY = V * math.sin(theta)
deltaTheta = omega
p = 1000
i = 0

while i < 5:

    t1 = time.time()

    omega_l = motor_b.speed * math.pi / 180
    omega_r = motor_a.speed * math.pi / 180

    Xg = xg[i]
    Yg = yg[i]

    omega = (omega_r - omega_l) * r / B
    V = (omega_r + omega_l) * r / 2

    deltaX_prev = deltaX
    deltaY_prev = deltaY
    deltaTheta_prev = deltaTheta

    deltaX = V * math.cos(theta)
    deltaY = V * math.sin(theta)
    deltaTheta = omega

    x = x + (deltaX + deltaX_prev) * h / 2
    y = y + (deltaY + deltaY_prev) * h / 2
    theta = theta + (deltaTheta + deltaTheta_prev) * h / 2

    ex = Xg - x
    ey = Yg - y
    p = math.sqrt(ex * ex + ey * ey)  ## длина направляющего вектора

    ksi = math.atan2(ey, ex)  ## угол между ОХ и вектором р
    alpha = ksi - theta  ## курсовой угол

    Us = Ks * p
    Ur = Kr * alpha

    u_left = Us - Ur
    u_right = Us + Ur

    file.write('{}, {}\n'.format(round(x, 2), round(y, 2)))

    if (u_left > 100):
        u_left = 100
    if (u_right > 100):
        u_right = 100
    if (u_left < -100):
        u_left = -100
    if (u_right < -100):
        u_right = -100

    motor_a.run_direct(duty_cycle_sp = u_right)
    motor_b.run_direct(duty_cycle_sp = u_left)

    t2 = time.time()
    dt = t2 - t1

    if (h >= dt):
        time.sleep(h - dt)
    else:
        print("warning")
    p = round(p, 2)
    if p < 0.1:
        print("DONE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
              "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")

        i += 1

    print(x, y, p)

motor_a.run_direct(duty_cycle_sp = 0)
motor_b.run_direct(duty_cycle_sp = 0)