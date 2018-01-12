#!/usr/bin/env bash
set -e
echo "export TERM=xterm" >> ~/.bashrc
# setup ros environment in each command line window
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc
# setup ros environment
source /opt/ros/kinetic/setup.bash
source /catkin_ws/devel/setup.bash
# start nginx
service nginx start
# Launch my ROS nodes and ros3djs URDF visualization
roslaunch ntbd_core NTBD_launch.launch
exec "$@"
