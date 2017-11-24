############################################################
# Image: sibotBase to be used by the development image
#
# ROS Kinetic with rosserial for sibot
# To get rid of containers, run:
#   docker rm $(docker ps -a -q)
# Then build the image, in:
#   docker build -t ros:sibot .
# To get rid of dangdling images 
# docker rmi $(docker images --filter "dangling=true")
############################################################

FROM  ros:kinetic

SHELL ["/bin/bash","-c"]

#-------------- Install necessary packages/tools -----------
RUN apt-get update -y && apt-get upgrade -y &&\             
    apt-get install ros-kinetic-rosserial-client -y &&\
    apt-get install ros-kinetic-rosserial-arduino -y &&\
    apt-get install ros-kinetic-rqt-tf-tree -y

RUN apt-get update -y &&\
    easy_install pyserial &&\
    apt-get install python-pip -y &&\
    pip install --upgrade pip &&\
    pip install --user pyassimp

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
#------------------------------------------------------------

RUN source /opt/ros/kinetic/setup.bash &&\
    mkdir -p /catkin_ws/src && cd /catkin_ws/src &&\
    catkin_init_workspace && cd .. && catkin_make

RUN echo ". /opt/ros/kinetic/setup.bash" >> ~/.bashrc &&\
    echo ". /catkin_ws/devel/setup.bash" >> ~/.bashrc &&\
    . ~/.bashrc

RUN cd /catkin_ws/src &&\
    git clone https://github.com/ros-drivers/rosserial.git

RUN . /catkin_ws/devel/setup.bash && cd /catkin_ws/ && catkin_make

# Remember to source the catkin setup file in order to use the catkin_make command
RUN . /catkin_ws/devel/setup.bash &&\
    cd /catkin_ws/src && catkin_create_pkg sibot_msgs std_msgs rospy roscpp &&\
    cd /catkin_ws/ && catkin_make && . /catkin_ws/devel/setup.bash

RUN cd /catkin_ws/src/sibot_msgs &&\
    mkdir msg &&\
    echo "uint16[] data" > msg/Servo_Array.msg

RUN cd /catkin_ws/src/sibot_msgs/ &&\
    rm CMakeLists.txt &&\
    rm package.xml

COPY ./src/CMakeLists.txt /catkin_ws/src/sibot_msgs/CMakeLists.txt
COPY ./src/package.xml /catkin_ws/src/sibot_msgs/package.xml

RUN . /catkin_ws/devel/setup.bash &&\
    cd /catkin_ws/ && catkin_make 

RUN . /catkin_ws/devel/setup.bash &&\
    cd /catkin_ws/src &&\
    catkin_create_pkg sibot_core sibot_msgs std_msgs rospy roscpp &&\
    cd /catkin_ws/ && catkin_make && . /catkin_ws/devel/setup.bash

#--- Copy of source is performed in .sh script at entrypoint (catkin_make done after copy of source) 
RUN cd /catkin_ws/src/sibot_core && mkdir scripts && mkdir launch
RUN cd /catkin_ws/src/ && mkdir sibot_urdf

#-------------- Using ros3djs to visualize sibot on browser -----------

RUN apt-get update -y && apt-get install nginx -y

RUN apt-get install ros-kinetic-robot-state-publisher -y &&\
    apt-get install ros-kinetic-joint-state-publisher -y &&\
    apt-get install ros-kinetic-rosbridge-server -y &&\
    apt-get install ros-kinetic-tf2-web-republisher -y &&\
    apt-get install ros-kinetic-interactive-marker-proxy -y

RUN apt-get install ros-kinetic-xacro -y &&\
    apt-get install liburdfdom-tools -y

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./sibot_entrypoint.sh /
RUN ["chmod", "+x", "/sibot_entrypoint.sh"]
ENTRYPOINT ["/sibot_entrypoint.sh"]
CMD ["bash"]
