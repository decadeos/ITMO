#!/usr/bin/env python3

#### Паблишер 1

import rospy
from geometry_msgs.msg import Twist
from std_msgs.msg import Float64


if __name__ == '__main__':

    rospy.init_node("node1")
    rospy.loginfo("Node started...")
    pub = rospy.Publisher("number1", Float64, queue_size=10)

    rate = rospy.Rate(1)

    num1 = 3.0

    while not rospy.is_shutdown():
        pub.publish(num1)    
        rate.sleep()


