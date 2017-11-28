docker build -f NTBD_base/Dockerfile.rpi3 -t hbrobotics/ntbd_base:rpi3 ./NTBD_base/
docker build -f NTBD_manipulator/Dockerfile.rpi3 -t hbrobotics/ntbd_manipulator:rpi3 ./NTBD_manipulator/
docker push hbrobotics/ntbd_base:rpi3
docker push hbrobotics/ntbd_manipulator:rpi3
