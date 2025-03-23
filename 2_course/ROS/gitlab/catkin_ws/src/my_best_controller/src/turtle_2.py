#!/usr/bin/env python3
import math

import rospy
from turtlesim.msg import Pose
from geometry_msgs.msg import Twist
from geometry_msgs.msg import Twist # geometry_msgs must be in package.xml also!!!


points = [[2, 3], [4, 2], [7, 1], [8, 4], [4, 2]]
pointer = 0

x1, y1 = points[pointer]
Dok=0.1

Rampa=0.5
Speed=1.5

omega_nom = 4

def cos_sin_between_2_vectors(Lx, Ly, Sx, Sy):
    # Вычисляем знаменатель
    z = math.sqrt(Lx**2 + Ly**2) * math.sqrt(Sx**2 + Sy**2)
    
    if z == 0:  # Если векторы нулевые
        return 1, 0  # CosFi = 1, SinFi = 0

    # Вычисляем косинус и синус угла
    CosFi = (Lx * Sx + Ly * Sy) / z
    if (1 - CosFi**2)<0:
        SinFi=0
    else:
        SinFi = math.sqrt(1 - CosFi**2)

    # Определяем знак синуса
    if (Lx * Sy - Ly * Sx) < 0:
        SinFi = -SinFi

    return CosFi, SinFi

def dist2(x0, y0, x1, y1):
    dx12 = x0 - x1
    dy12 = y0 - y1
    sqrx12 = dx12 ** 2
    sqry12 = dy12 ** 2
    return math.sqrt(sqrx12 + sqry12)

def sign(x):
    return -1 if x < 0 else 1

def smart_root(x):
    return -math.sqrt(-x) if x < 0 else math.sqrt(x)


def pose_callback(pose):
    global x1, y1, pointer
    cmd = Twist()
    dist =dist2(pose.x, pose.y, x1, y1) 
    if dist<Dok:
        pointer += 1
        if pointer >= len(points):
            pointer = 0

        x1, y1 = points[pointer]



    CosToTarget, SinToTarget = cos_sin_between_2_vectors(
        math.cos(pose.theta),math.sin(pose.theta),x1-pose.x,y1-pose.y)
    
    cmd.angular.x = CosToTarget
    cmd.angular.y = dist


    if dist>=Rampa:
        cmd.linear.x = Speed
    else:
        cmd.linear.x = math.sqrt(dist/Rampa)*Speed
        #cmd.linear.x = (dist/Rampa)*Speed

    if CosToTarget<0.0:
        cmd.angular.z=sign(SinToTarget)*omega_nom
        cmd.linear.x=0.1
    else:
        if abs(SinToTarget)>0.05:
            cmd.angular.z = sign(SinToTarget)*omega_nom
        else:   
            cmd.angular.z = smart_root(SinToTarget/0.05)*omega_nom   # поставить сюда хитрый корень!!!
        #cmd.angular.z = SinToTarget*1   # поставить сюда хитрый корень!!!

    publisher.publish(cmd)
    
 #rospy.loginfo('('+ str(msg.x) + ", " + str(msg.y) + ")")
if __name__ == '__main__':
    rospy.init_node("turtle_super_node")
    rospy.loginfo("Node started...")
    # rate = rospy.Rate(2)
    subscriber = rospy.Subscriber("/turtle1/pose", Pose, callback=pose_callback)
    publisher = rospy.Publisher("/turtle1/cmd_vel", Twist, queue_size=10)
    rospy.spin()