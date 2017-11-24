#!/usr/bin/env bash
set -e
echo "export TERM=xterm" >> ~/.bashrc
echo ". /opt/ros/kinetic/setup.bash" >> ~/.bashrc
echo ". /catkin_ws/devel/setup.bash" >> ~/.bashrc

# setup ROS environment
 source /opt/ros/kinetic/setup.bash
 source /catkin_ws/devel/setup.bash
 
exec "$@"
