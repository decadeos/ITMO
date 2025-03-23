#!/usr/bin/env python3
import rospy
from turtlesim.msg import Pose
from geometry_msgs.msg import Twist
from geometry_msgs.msg import Twist # geometry_msgs must be in package.xml also!!!

def pose_callback(pose):
    cmd = Twist()
    if pose.x > 9.0 or pose.x < 2.0:
        cmd.linear.x = 1.0
        cmd.angular.z = 1.4
    else:
        cmd.linear.x = 2.0
        cmd.angular.z = 0.0

    publisher.publish(cmd)
 
v=1
b=2
c=v*b 
    
 #rospy.loginfo('('+ str(msg.x) + ", " + str(msg.y) + ")")
if __name__ == '__main__':
    rospy.init_node("turtle_super_node")
    rospy.loginfo("Node started...")
    # rate = rospy.Rate(2)
    subscriber = rospy.Subscriber("/turtle1/pose", Pose, callback=pose_callback)
    publisher = rospy.Publisher("/turtle1/cmd_vel", Twist, queue_size=10)
    rospy.spin()