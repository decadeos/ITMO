 #!/usr/bin/env python3
import ev3dev2.motor as motor
import time
f = open('lab3p.csv', 'w')

motor_a=motor.LargeMotor(motor.OUTPUT_A)
wish_pose = 135
curentTime = 0
kp = 0.8
t1 = 0
startTime = time.time()
startPos = motor_a.position
while t1 < 10:

    t1 = time.time() - startTime

    now_pose = motor_a.position - startPos
    e = wish_pose - now_pose
    voltage = kp * e

    if voltage > 100:
        voltage = 100
    elif voltage < -100:
        voltage = -100
    else:
        voltage = kp * e
    motor_a.run_direct(duty_cycle_sp=voltage)

    f.write('{}, {}, {},  {}\n'.format(voltage, now_pose, e, round(t1, 4)))

motor_a.run_direct(duty_cycle_sp=0)
f.close()
