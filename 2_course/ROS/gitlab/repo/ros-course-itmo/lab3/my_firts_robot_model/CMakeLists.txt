cmake_minimum_required(VERSION 3.0.2)
project(my_firts_robot_model)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
)

catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES my_firts_robot_model
#  CATKIN_DEPENDS roscpp rospy std_msgs
#  DEPENDS system_lib
)
