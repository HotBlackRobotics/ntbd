############################################################
# Image: NTBD Base - Image for RaspBerry Pi 3
# Contains:
#    - All needed system and ROS packages
#    - All NTBD necessary ROS Nodes
#
# To build the image, in:
#   docker build -t ros:ntbd_base_rpi3 .
############################################################

FROM  hbrobotics/ros-base:rpi3

SHELL ["/bin/bash","-c"]

#-------------- Install necessary system packages/tools -----------
RUN apt-get install ros-kinetic-rosserial \
        ros-kinetic-robot-state-publisher \
        ros-kinetic-joint-state-publisher \
        ros-kinetic-rosbridge-server \
        ros-kinetic-tf2-web-republisher \
        ros-kinetic-xacro -y

RUN apt-get update -y && apt-get install nginx -y
#--- Copy nginx configuration files ---
COPY ./NTBD_viz/index.nginx-debian.html /var/www/html/index.nginx-debian.html
COPY ./NTBD_viz/default /etc/nginx/sites-enabled/default

#-------------- Install necessary ROS packages --------------------
RUN source /opt/ros/kinetic/setup.bash &&\
    mkdir -p /catkin_ws/src && cd /catkin_ws/src &&\
    catkin_init_workspace &&\
    cd .. && catkin_make

#--------------ROS packages ---------------
COPY ./ntbd_msgs/ /catkin_ws/src/ntbd_msgs/
COPY ./ntbd_core/ /catkin_ws/src/ntbd_core/

RUN . /catkin_ws/devel/setup.bash &&\
    cd /catkin_ws/ && catkin_make 
RUN . /opt/ros/kinetic/setup.bash


COPY ./NTBD_base_entrypoint.sh /
RUN ["chmod", "+x", "/NTBD_base_entrypoint.sh"]
ENTRYPOINT ["/NTBD_base_entrypoint.sh"]
CMD ["bash"]
