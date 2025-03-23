#!/usr/bin/env python3
import ev3dev2.motor as motor
import time
f = open('lab3pid.csv', 'w')

AngReg = 50.0 # угол регулирования, менять его!!! 0-100

motor_a=motor.LargeMotor(motor.OUTPUT_A)
wish_pose = 135
startTime = time.time()
I = 0
e_prev = 0
t1 = time.time()
h = 0.01
# for i in range(300):
# 	motor_a.run_direct(duty_cycle_sp = 50)
# time.sleep(2)
startPos = motor_a.position
while startTime - time.time() < 10:
    t1 = time.time()
    now_pose = motor_a.position - startPos
    # now_pose = motor_a.position
    e = wish_pose - now_pose


    if e>=AngReg:
        voltage = 100   # менять знак +-
    elif e<=-AngReg:
        voltage = -100  # менять знак -+
    else:
        e=e/AngReg  # нормализация ошибки
        if e>=0:
            voltage=100*(e)**0.5     # менять знак +-
        else:
            voltage=-100*(-e)**0.5   # менять знак +-
        

    motor_a.run_direct(duty_cycle_sp=voltage)
    e_prev = e
    t2 = time.time()
    dt = t2 - t1
    f.write('{}, {}, {},  {}\n'.format(voltage, now_pose, e, round((dt), 4)))
    if h >= dt:
        time.sleep(h - dt)
    else:
        print("Увеличить h!!")
motor_a.run_direct(duty_cycle_sp=0)
f.close()