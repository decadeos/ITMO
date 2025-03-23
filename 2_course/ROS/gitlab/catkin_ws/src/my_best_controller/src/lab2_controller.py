#!/usr/bin/env python3
import math
import time
import rospy
from turtlesim.msg import Pose
from geometry_msgs.msg import Twist
from geometry_msgs.msg import Twist # geometry_msgs must be in package.xml also!!!
from std_msgs.msg import String


points = [[2, 3], [4, 2], [7, 1], [8, 4], [4, 2]]
pointer = 0

x1, y1 = points[pointer]
Dok=0.1

Rampa=0.5 ## дистанция для плавного уменьшения скорости перед точкой
Speed1=1.5
omega_nom1 = 4

Speed2=1.2
omega_nom2 = 3

tx1,ty1=0,0

start_time = time.time()

def cos_sin_between_2_vectors(Lx, Ly, Sx, Sy):
    # Вычисляем знаменатель
    z = math.sqrt(Lx**2 + Ly**2) * math.sqrt(Sx**2 + Sy**2)
    
    if z == 0:  # Если векторы нулевые
        return 1, 0  # CosFi = 1, SinFi = 0

    # Вычисляем косинус и синус угла
    CosFi = (Lx * Sx + Ly * Sy) / z ## делим для нормализации вектора же не единичные
    if (1 - CosFi**2)<0:
        SinFi=0
    else:
        SinFi = math.sqrt(1 - CosFi**2)

    # Определяем знак синуса
    if (Lx * Sy - Ly * Sx) < 0:
        SinFi = -SinFi

    return CosFi, SinFi

def dist2(x0, y0, x1, y1): ## расстояние между точками по формуле евклидового расстояния
    dx12 = x0 - x1
    dy12 = y0 - y1
    sqrx12 = dx12 ** 2
    sqry12 = dy12 ** 2
    return math.sqrt(sqrx12 + sqry12)

def sign(x):
    return -1 if x < 0 else 1

def smart_root(x):
    return -math.sqrt(-x) if x < 0 else math.sqrt(x)


def pose_callback1(pose):
    global x1, y1, pointer, start_time

    cmd = Twist()


    dist =dist2(pose.x, pose.y, x1, y1) 
    if dist<Dok: ## если доехали до точки типа
        pointer += 1
        if pointer >= len(points):
            pointer = 0
            d_time = str(time.time() - start_time)
            start_time = time.time()

            publisherMSG.publish(d_time)

        x1, y1 = points[pointer]

    CosToTarget, SinToTarget = cos_sin_between_2_vectors(
        math.cos(pose.theta),math.sin(pose.theta),x1-pose.x,y1-pose.y)
    
    if dist>=Rampa:
        cmd.linear.x = Speed1
    else:
        cmd.linear.x = math.sqrt(dist/Rampa)*Speed1
        #cmd.linear.x = (dist/Rampa)*Speed

    if CosToTarget<0.0:
        cmd.angular.z=sign(SinToTarget)*omega_nom1
        cmd.linear.x=0.1
    else:
        if abs(SinToTarget)>0.05:
            cmd.angular.z = sign(SinToTarget)*omega_nom1
        else:   
            cmd.angular.z = smart_root(SinToTarget/0.05)*omega_nom1   # поставить сюда хитрый корень!!!
        #cmd.angular.z = SinToTarget*1   # поставить сюда хитрый корень!!!

    publisher1.publish(cmd)


def pose_callback21(pose):
    global tx1,ty1
    tx1,ty1 = pose.x, pose.y

    
def pose_callback2(pose):
    global tx1,ty1
    x1,y1 = tx1,ty1

    cmd = Twist()
    dist =dist2(pose.x, pose.y, x1, y1) 

    CosToTarget, SinToTarget = cos_sin_between_2_vectors(
        math.cos(pose.theta),math.sin(pose.theta),x1-pose.x,y1-pose.y)
    
    if dist>=Rampa:
        cmd.linear.x = Speed2
    else:
        cmd.linear.x = math.sqrt(dist/Rampa)*Speed2 ## Если меньше, скорость пропорциональна квадратному корню от расстояния

    if CosToTarget<0.0:
        cmd.angular.z=sign(SinToTarget)*omega_nom2
        cmd.linear.x=0.1
    else:
        if abs(SinToTarget)>0.05:
            cmd.angular.z = sign(SinToTarget)*omega_nom2
        else:   
            cmd.angular.z = smart_root(SinToTarget/0.05)*omega_nom2   # поставить сюда хитрый корень!!!
        
    publisher2.publish(cmd)
    
 #rospy.loginfo('('+ str(msg.x) + ", " + str(msg.y) + ")")
if __name__ == '__main__':
    rospy.init_node("turtle_super_node")

    #rospy.init_node("result_409290")

    turtle1_namespace = rospy.get_param("~turtle1_namespace", "")
    turtle2_namespace = rospy.get_param("~turtle2_namespace", "")

    rospy.loginfo("Node started...")
    rospy.loginfo("Node started1...")
    
    rospy.loginfo(f"{turtle1_namespace}/pose")
    rospy.loginfo(f"{turtle2_namespace}/pose")

    rospy.loginfo("Node started1...")
    # rate = rospy.Rate(2)


    subscriber1 = rospy.Subscriber(f"{turtle1_namespace}/turtle1/pose", Pose, callback=pose_callback1)
    publisher1 = rospy.Publisher(f"{turtle1_namespace}/turtle1/cmd_vel", Twist, queue_size=10)

    subscriber2 = rospy.Subscriber(f"{turtle2_namespace}/turtle1/pose", Pose, callback=pose_callback2)
    subscriber21 = rospy.Subscriber(f"{turtle1_namespace}/turtle1/pose", Pose, callback=pose_callback21)
    publisher2 = rospy.Publisher(f"{turtle2_namespace}/turtle1/cmd_vel", Twist, queue_size=10)

    publisherMSG = rospy.Publisher("result_409290", String, queue_size=10)

    rospy.spin()
