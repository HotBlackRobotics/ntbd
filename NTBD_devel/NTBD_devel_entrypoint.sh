#!/usr/bin/env bash
set -e
echo "export TERM=xterm" >> ~/.bashrc
echo ". /opt/ros/kinetic/setup.bash" >> ~/.bashrc
echo ". /catkin_ws/devel/setup.bash" >> ~/.bashrc
# Source form host:
# NTBD_core scripts & launch
cp /src/IK /catkin_ws/src/ntbd_core/scripts/IK
cp /src/physical_2_visual /catkin_ws/src/ntbd_core/scripts/physical_2_visual
cp /src/FK /catkin_ws/src/ntbd_core/scripts/FK
cp /src/motors_values /catkin_ws/src/ntbd_core/scripts/motors_values
# Make scripts executable to be used as nodes!
cd /catkin_ws/src/ntbd_core/scripts/
chmod +x IK && chmod +x physical_2_visual && chmod +x FK && chmod +x motors_values

cp /src/NTBD_launch.launch /catkin_ws/src/ntbd_core/launch/NTBD_launch.launch

# NTBD_urdf
cp -rf /src/manipulator_urdf/ /catkin_ws/src/manipulator_urdf/
# setup ros3djs config (comprehends nginx config)
cp -rf /src/manipulator_urdf/ /var/www/html/manipulator_urdf/
cp /src/NTBD_viz.html /var/www/html/NTBD_viz.html

cp -rf /src/ros3djs/roswebconsole/ /var/www/html/roswebconsole/ 

source /catkin_ws/devel/setup.bash
cd /catkin_ws/ && catkin_make

# setup ros environment
 source /opt/ros/kinetic/setup.bash
 source /catkin_ws/devel/setup.bash
 
# start nginx
service nginx start

# Launch my ROS nodes and ros3djs URDF visualization
roslaunch ntbd_core NTBD_launch.launch

exec "$@"
