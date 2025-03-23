#!/usr/bin/env python3

#### Паблишер 2

import rospy
from geometry_msgs.msg import Twist
from std_msgs.msg import Float64


if __name__ == '__main__':

    rospy.init_node("node2")
    rospy.loginfo("Node started...")
    pub = rospy.Publisher("number2", Float64, queue_size=10)

    rate = rospy.Rate(10)

    num2 = 5.0

    while not rospy.is_shutdown():
        pub.publish(num2)
        rate.sleep()

