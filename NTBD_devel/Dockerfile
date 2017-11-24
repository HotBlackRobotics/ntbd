############################################################
# Image: NTBD Devel - Intel Image
# 
# Development Image for NTBD Architecture
#
# To build the image, in:
#   docker build -t ros:ntbd_devel .
############################################################

FROM  ros:ntbd_base

SHELL ["/bin/bash","-c"]

#--- Copy of source is performed in .sh script at entrypoint (catkin_make done after copy of source) 

COPY ./NTBD_devel_entrypoint.sh /
RUN ["chmod", "+x", "/NTBD_devel_entrypoint.sh"]
ENTRYPOINT ["/NTBD_devel_entrypoint.sh"]
CMD ["bash"]