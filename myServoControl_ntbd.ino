/* NTBD integration with siBOT
 * Servo motors control exploiting rosserial
 * 
 * Author: fiorella.sibona@gmail.com
 * 
 * RMK: If you are using an Arduino Mega Board:
 *      in directory sketch_folder/libraries/ros_lib, open file "ArduinoHardware.h" and set baud= 115200 anywhere baud appears 
 */
 
#include <Servo.h> 
#include <ros.h>
#include <ntbd_msgs/Motors_Array.h>
#define USE_USBCON

ros::NodeHandle  nh;

Servo servo1, servo2, servo3, servo4;

// Callback funtion ("as message is read, perform these actions")
void servos_cb( const ntbd_msgs::Motors_Array& angles_msg){
  
  servo1.write(angles_msg.data[0]);  
  servo2.write(angles_msg.data[1]);
  servo3.write(angles_msg.data[2]);
  servo4.write(angles_msg.data[3]);
  
}

// Subscriber node declaration, specifies the topic to which subscribe and the callback funtion
ros::Subscriber<ntbd_msgs::Motors_Array> sub("motors", servos_cb);

// Arduino setup function
void setup(){
    
  nh.initNode();
  nh.subscribe(sub);
  
  servo1.attach(2); //attach it to pin 2
  servo2.attach(3);
  servo3.attach(4);
  servo4.attach(5);
  
}

// Arduino loop function
void loop(){
  
  nh.spinOnce();
  delay(1);
  
}
