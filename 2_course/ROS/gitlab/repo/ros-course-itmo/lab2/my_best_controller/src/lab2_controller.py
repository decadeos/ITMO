#!/usr/bin/env python3
import math
import time
import rospy
from turtlesim.msg import Pose
from geometry_msgs.msg import Twist
from geometry_msgs.msg import Twist # geometry_msgs must be in package.xml also!!!
from std_msgs.msg import String


points = [[2, 3], [4, 2], [7, 1], [8, 4], [4, 2]] ## захардкоженные точки
pointer = 0

x1, y1 = points[pointer] ## текущие
Dok=0.1 ## типа погрешность, расстояние до целевой точки

Rampa=0.5 ## от этого зависит скорость. При приближении я вроде ее уменьшаю. Я бы сказала это радиус замедления
Speed1=1.5 ## ну скорость 1, очев
omega_nom1 = 4 ## угловая скорость 1 чепепахи

Speed2=1.2 ## скорость 2 черепахи (меньше, чтобы она модно срезала углы на поворотах)
omega_nom2 = 3 ## угл. скорость 2 чеерепахи, тоже меньше, чтобы она медленней поворачивалась и ее траектория была не точь в точь как у первой

tx1,ty1=0,0 ## глобальные переменные для хроанения координат первой чепепахи

start_time = time.time() ## начинаю фиксировать время

def cos_sin_between_2_vectors(Lx, Ly, Sx, Sy): ## использую для определения углового отклонения между текущим направлением движения и направлением на целевую точку
    # Вычисляем знаменатель
    z = math.sqrt(Lx**2 + Ly**2) * math.sqrt(Sx**2 + Sy**2) 
    
    if z == 0:  # Если векторы нулевые
        return 1, 0  # CosFi = 1, SinFi = 0

    # Вычисляем косинус и синус угла
    CosFi = (Lx * Sx + Ly * Sy) / z ## это модная формула из школьной математики. косинус между векторами, зная координаты
    if (1 - CosFi**2)<0: ## чтобы не было ошибок, проверка на
        SinFi=0
    else:
        SinFi = math.sqrt(1 - CosFi**2) ## типа я математически подкована)) использую ОТО

    # Определяем знак синуса
    if (Lx * Sy - Ly * Sx) < 0:
        SinFi = -SinFi

    return CosFi, SinFi

def dist2(x0, y0, x1, y1): ## расстояние между 2 точками по формуле Евклида 
    dx12 = x0 - x1
    dy12 = y0 - y1
    sqrx12 = dx12 ** 2
    sqry12 = dy12 ** 2
    return math.sqrt(sqrx12 + sqry12)

def sign(x): ## знак числа
    return -1 if x < 0 else 1

def smart_root(x): ## корень который еще учитывает отрицательность
    return -math.sqrt(-x) if x < 0 else math.sqrt(x)

####################################################################### ура калбек !!
def pose_callback1(pose):
    global x1, y1, pointer, start_time ## ну просто определила глобальные переменные

    cmd = Twist() ## экземпляр обьекта для управлоления угловой и скоростью


    dist =dist2(pose.x, pose.y, x1, y1) ## определяю расстояние между текущей позицией и целевой ЗАХАРДКОЖЕННОЙ точкой
    if dist<Dok: ## если я уже на епсилон близка
        pointer += 1 ## беру следующую точку из задания
        if pointer >= len(points): ## если конец списка надо бобнулить чтобы по кругу ездить и не выйти за гриницы массива так-то
            pointer = 0 ## 0
            d_time = str(time.time() - start_time) ## индексирую время. СТР чтобы его отправить можно было, а то ошибки были если флотом пушить
            start_time = time.time()

            publisherMSG.publish(d_time) ## ура публикую время в топик

        x1, y1 = points[pointer] ## непосредственно беру новую цель 

    CosToTarget, SinToTarget = cos_sin_between_2_vectors( ## определяю угол между направлением черепахи и напрввлением на целевую точку
        math.cos(pose.theta), math.sin(pose.theta), x1-pose.x, y1-pose.y) ## тут сложно. Что я туда передаю: угол черепахи относительно х и игрек, но не угол на самом деле, а проекцию и на ОБЕ ОСИ!!! икс и игрек. А также передаю (вторыми переменными) вектор от текущей позиции черепахи до цели
    ## по сути у меня есть нормированный вектор и обычный вектор и я их в функцию пихаю (но не их а их проекции на оси) для определения угла между ними. Надо не забыть, что есть рисунок в фигме по этому поводу !!!
    ## pose.theta - это угол ориентации черепахи относительно Х

    if dist>=Rampa: ##  если расстояние велико
        cmd.linear.x = Speed1 ## скорость большая
    else:
        cmd.linear.x = math.sqrt(dist/Rampa)*Speed1 ## иначе она зависит от отношения корень(0.1/0,5). Короче плавненько уменьшается для красоты
        #cmd.linear.x = (dist/Rampa)*Speed ## если буз хитрого корня траектории будут более круглые

    if CosToTarget<0.0: ## это значит, что цель позади черепахи
        cmd.angular.z=sign(SinToTarget)*omega_nom1 ## математическая магия со знаками. Это чтобы в ближайшую сторону поворачиваться, исто для красоты регулятора. Можно и без этого обойтись так-то
        cmd.linear.x=0.1 ## медленно вращаемся на места и не двигаемся никуда
    else: ## еслии все ок и цель примерно впереди
        if abs(SinToTarget)>0.05: ## если угол большой то мы нормально так разворачиваемся, чтобы быстрее у цели доехать, ведь мы же еще параллельно едем
            cmd.angular.z = sign(SinToTarget)*omega_nom1 ## ну типа вправо или лево, для красоты)
        else:   
            cmd.angular.z = smart_root(SinToTarget/0.05)*omega_nom1   # поставить сюда хитрый корень!!! ## если угол уже маленький, то помедленнее разварачиваемся
        #cmd.angular.z = SinToTarget*1   # поставить сюда хитрый корень!!!

        ## SinToTarget/0.05 - нормировка, если что

    publisher1.publish(cmd) ## публикация в turtle1/cmd_vel


#######################################################################
def pose_callback21(pose):
    global tx1,ty1
    tx1,ty1 = pose.x, pose.y ## просто сохраняем в глобальные переменные координаты черепахи 1
    
#######################################################################
def pose_callback2(pose): ## регулятор для 2 черепахи. Ну только целевые точки у нее другие
    global tx1,ty1 ## ее получили глобальные координаты 1 черепахи
    x1,y1 = tx1,ty1 ## зафиксировали, глобальные переменные не круто использовать
    

    cmd = Twist() ## ура создали экземпляр обьекта твист
    dist =dist2(pose.x, pose.y, x1, y1) ## вычислили расстояние до цели

    CosToTarget, SinToTarget = cos_sin_between_2_vectors( ## определили угол между чем и чем написнао выше. Также есть рисунок обьяснение в фигме
        math.cos(pose.theta),math.sin(pose.theta),x1-pose.x,y1-pose.y)
    
    if dist>=Rampa: ## если мы далеко одна скорость
        cmd.linear.x = Speed2
    else:
        cmd.linear.x = math.sqrt(dist/Rampa)*Speed1 ## иначе плавно-модно уменьшаем скорость при приближении к точке
        #cmd.linear.x = (dist/Rampa)*Speed ## можно без корня, но с ним круче

    if CosToTarget<0.0: ##
        cmd.angular.z=sign(SinToTarget)*omega_nom1 ## тут определяем вправо или влево разворачиваться и подаем угловую скорость
        cmd.linear.x=0.1 ## разворачиваемся
    else:
        if abs(SinToTarget)>0.05: ## это значит, что нам долго развораыиваться
            cmd.angular.z = sign(SinToTarget)*omega_nom1 ## поэтому мы делаем это быстро
        else:   
            cmd.angular.z = smart_root(SinToTarget/0.05)*omega_nom1   # поставить сюда хитрый корень!!! 
        #cmd.angular.z = SinToTarget*1   # поставить сюда хитрый корень!!!
        
    publisher2.publish(cmd) ## публикуем в топик для 2 черепахи
    
########################################   
    
if __name__ == '__main__': ## это вообще жесть
    rospy.init_node("turtle_super_node") ## Эта нода будет управлять движением черепах

    NS = rospy.get_namespace() ## получили немспейс текущей ноды

    rospy.loginfo("Node started...") ## ввожу чтото в терминал
    
    rospy.loginfo(f"/pose")

    rospy.loginfo("Node started1...")
    rospy.loginfo(NS) ## это все ради отладки


    publisher1 = rospy.Publisher(f"turtle1/cmd_vel", Twist, queue_size=10) ## создаю публишера для 1 черепахи. публикуем в turtle1/cmd_vel. Сообщения в этот топик будут управлять скоростью и поворотом черепахи
 
    
    if NS == "/NS2_409290/": ## если мы во 2 немспейсе
        subscriber21 = rospy.Subscriber(f"/NS1_409290/turtle1/pose", Pose, callback=pose_callback21) ## сделали подпищика на 1 черепаху. Тут мы слушаем топик /NS1_409290/turtle1/pose
        publisher2 = rospy.Publisher(f"turtle1/cmd_vel", Twist, queue_size=10) ## сделали публикатора для управения 2 черепахой. Сообщения отправляются в turtle1/cmd_vel 

        subscriber1 = rospy.Subscriber(f"turtle1/pose", Pose, callback=pose_callback2) ## подпищик слушает позицию второй черепахи (turtle1/pose)
    else:
        subscriber1 = rospy.Subscriber(f"turtle1/pose", Pose, callback=pose_callback1) ## подпищик слушает позицию первой черепахи (turtle1/pose)
        publisherMSG = rospy.Publisher("/result_409290", String, queue_size=10)  ## сделали публикатора в топик времени
    
    rospy.spin()
