#!/usr/bin/env bash
set -e
echo "export TERM=xterm" >> ~/.bashrc
# Source form host:
# sibot_core scripts & launch
cp /src/interpP /catkin_ws/src/sibot_core/scripts/interpP
cp /src/IK /catkin_ws/src/sibot_core/scripts/IK
cp /src/limitJ /catkin_ws/src/sibot_core/scripts/limitJ
cp /src/convSJ /catkin_ws/src/sibot_core/scripts/convSJ
cp /src/FK /catkin_ws/src/sibot_core/scripts/FK
cp /src/gripper /catkin_ws/src/sibot_core/scripts/gripper
# Make scripts executable to be used as nodes!
cd /catkin_ws/src/sibot_core/scripts/
chmod +x interpP && chmod +x IK && chmod +x limitJ && chmod +x convSJ && chmod +x FK && chmod +x gripper

cp /src/sibot_launch.launch /catkin_ws/src/sibot_core/launch/sibot_launch.launch

# sibot_urdf
cp -rf /src/sibot_urdf/ /catkin_ws/src/sibot_urdf/
# setup ros3djs config (comprehends nginx config)
cp -rf /src/sibot_urdf/ /var/www/html/sibot_urdf/
cp /src/ros3djs/index.nginx-debian.html /var/www/html/index.nginx-debian.html
cp /src/ros3djs/tutorialurdf.html /var/www/html/tutorialurdf.html
cp /src/ros3djs/default /etc/nginx/sites-enabled/default

rm /opt/ros/kinetic/share/rosbridge_server/launch/rosbridge_websocket.launch
cp /src/rosbridge_websocket.launch /opt/ros/kinetic/share/rosbridge_server/launch/rosbridge_websocket.launch

cp -rf /src/ros3djs/roswebconsole/ /var/www/html/roswebconsole/ 

source /catkin_ws/devel/setup.bash
cd /catkin_ws/ && catkin_make

# apt-get update -y
# apt-get install curl -y
# curl -sL https://deb.nodesource.com/setup_8.x | -E bash -
# apt-get install -y nodejs
# cd /src/ros3djs/
# npm install https://github.com/RobotWebTools/ros3djs
# npm install https://github.com/RobotWebTools/roslibjs
# npm install https://github.com/mrdoob/three.js/

# setup ros environment
 source /opt/ros/kinetic/setup.bash
 source /catkin_ws/devel/setup.bash
 
# start nginx
service nginx start

# Launch my ROS nodes and ros3djs URDF visualization
roslaunch sibot_core sibot_launch.launch

exec "$@"
