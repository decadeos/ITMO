#!/usr/bin/env python3
f = open('lab1.csv', 'w')
import ev3dev2.motor as motor
import time

motor_a=motor.LargeMotor(motor.OUTPUT_A)
for voltage in range(10, 51, 5):
    startTime=time.time()
    while (True):
        currentTime=time.time()-startTime
        motor_pose=motor_a.position
        motor_vel=motor_a.speed
        motor_a.run_direct(duty_cycle_sp=voltage)

        f.write('{}, {}, {}, {}\n'.format(voltage, currentTime, motor_vel, motor_pose))

        if currentTime>3:
            motor_a.run_direct(duty_cycle_sp=0)
            break
    time.sleep(1)






