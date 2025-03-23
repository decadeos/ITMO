#!/usr/bin/env python3
import ev3dev2.motor as motor
import time
f = open('lab3pid.csv', 'w')
kp = 0.65
ki = 0
kd = 0
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
    P = kp * e
    I = I + ki * (e + e_prev) * h / 2
    D = kd * (e - e_prev) / h
    voltage = P + I + D
    if voltage >100:
        voltage = 100
    elif voltage < -100:
        voltage = -100
    motor_a.run_direct(duty_cycle_sp=voltage)
    e_prev = e
    t2 = time.time()
    dt = t2 - t1
    tm = dt
    f.write('{}, {}, {},  {}\n'.format(voltage, now_pose, e, round((dt+tm), 4)))
    if h >= dt:
        time.sleep(h - dt)
    else:
        print("")
motor_a.run_direct(duty_cycle_sp=0)
f.close()