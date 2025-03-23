#!/usr/bin/env python3

import rospy
from std_msgs.msg import Float64, String

number1 = None
number2 = None

def callback(msg, topic_name):
    global number1, number2

    if topic_name == "number1":
        number1 = msg.data
    elif topic_name == "number2":
        number2 = msg.data

    calculate_result()

def calculate_result():
    if number1 is not None and number2 is not None:
        if number2 != 0:
            result = number1 / number2
            message = f"result_409290 : {result}"
            rospy.loginfo(message)
            pub.publish(message)  # Публикация результата
        else:
            rospy.logwarn("Деление на ноль невозможно.")

if __name__ == '__main__':
    rospy.init_node("node3")
    rospy.loginfo("Node3 запущена и ожидает данные от node1 и node2")


    pub = rospy.Publisher("result", String, queue_size=10)


    rospy.Subscriber("number1", Float64, callback, callback_args="number1")
    rospy.Subscriber("number2", Float64, callback, callback_args="number2")

    rospy.spin()