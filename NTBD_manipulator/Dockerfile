############################################################
# Image: NTBD + Manipulator - Intel Image
# Contains:
#    - All needed system and ROS packages
#    - All NTBD necessary ROS Nodes
#    - All NTBD abstract ROS Nodes for the chosen manipulator
#
# To build the image, in:
#   docker build -t ros:ntbd_manipulator .
############################################################

FROM  ros:ntbd_base

SHELL ["/bin/bash","-c"]

#-------------- Copy NTBD ROS abstract nodes -------------------------------
COPY ./NTBD_abstract_nodes/IK /catkin_ws/src/ntbd_core/scripts/IK
COPY ./NTBD_abstract_nodes/FK /catkin_ws/src/ntbd_core/scripts/FK
COPY ./NTBD_abstract_nodes/motors_values /catkin_ws/src/ntbd_core/scripts/motors_values
COPY ./NTBD_abstract_nodes/physical_2_visual /catkin_ws/src/ntbd_core/scripts/physical_2_visual
RUN cd /catkin_ws/src/ && mkdir manipulator_urdf
COPY ./NTBD_abstract_nodes/manipulator_urdf/ /catkin_ws/src/manipulator_urdf/
COPY ./launch/NTBD_launch.launch /catkin_ws/src/ntbd_core/launch/NTBD_launch.launch
    
#-------------- Copy urdf package for nginx -------------------------------
COPY ./NTBD_abstract_nodes/manipulator_urdf/ /var/www/html/manipulator_urdf/
COPY ./NTBD_abstract_nodes/NTBD_viz.html /var/www/html/NTBD_viz.html
COPY ./NTBD_abstract_nodes/roswebconsole/ /var/www/html/roswebconsole/ 

RUN . /catkin_ws/devel/setup.bash &&\
    cd /catkin_ws/ && catkin_make

COPY ./NTBD_entrypoint.sh /
RUN ["chmod", "+x", "/NTBD_entrypoint.sh"]
ENTRYPOINT ["/NTBD_entrypoint.sh"]
CMD ["bash"]