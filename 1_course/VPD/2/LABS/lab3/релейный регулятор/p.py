
#!/usr/bin/env python3
import ev3dev2.motor as motor
import time
f = open('lab3pid.csv', 'w')

motor_a=motor.LargeMotor(motor.OUTPUT_A)
wish_pose = 135
startTime = time.time()

t1 = time.time()
startPos = motor_a.position
while startTime - time.time() < 10:
    t1 = time.time()
    now_pose = motor_a.position - startPos
    # now_pose = motor_a.position
    e = wish_pose - now_pose

    if e > 0:
        voltage = 100
    elif e < 0:
        voltage = -100
    else:
        voltage = 0

    motor_a.run_direct(duty_cycle_sp=voltage)
    
    t2 = time.time()
    f.write('{}, {}, {},  {}\n'.format(voltage, now_pose, e, round((dt+tm), 4)))
    
motor_a.run_direct(duty_cycle_sp=0)
f.close()