class Command{
  
  //get Grbl Settings
  void grblSettings(){
    myPort.write("$$\n");
    print("<<<$$\n");
  }
  
  //get # parameters
  void grblParameters(){
    myPort.write("$#\n");
    print("<<<$#\n");
  }
  
  //get parse state
  void grblParsestate(){
    myPort.write("$G\n");
    print("<<<$G\n");
  }
  
  //get build info
  void grblBuildinfo(){
    myPort.write("$I\n");
    print("<<<$I\n");
  }
  
  //get startup blocks
  void grblStartupblocks(){
    myPort.write("$N\n");
    print("<<<$N\n");
  }
 
  //check gcode mode
  void grblGcodemode(){
    myPort.write("$C\n");
    print("<<<$C\n");
  }
  
  //kill alarm lock
  void grblKilllock(){
    myPort.write("$X\n");
    print("<<<$X\n");
  }
  
  //run homing cycle
  void grblHome(){
    myPort.write("$H\n");
    print("<<<$H\n");
  }
  
  //Reset Grbl
  void grblReset(){
    myPort.write("CTRL+X");
    print("<<<CTRL+X\n");
  }
  
  //Set Zero
  void grblSetzero(){
    myPort.write("G10 P0 L20 X0 Y0 Z0\n");
    print("<<<G10 P0 L20 X0 Y0 Z0\n");
  }
  
  //Return Zero
  void grblReturnzero(){
    myPort.write("G90 X0 Y0\n");
    print("<<<G90 X0 Y0\n");
  }
  
  //Hand Shake
  void grblHandshake(){
    myPort.write("G90 X20 Y0\n");
    print("<<<G90 X20 Y0\n");
    delay(10);
    myPort.write("G90 X20 Y20\n");
    print("<<<G90 X20 Y20\n");
    delay(10);
    myPort.write("G90 X0 Y20\n");
    print("<<<G90 X0 Y20\n");
    delay(10);
    myPort.write("G90 X0 Y0\n");
    print("<<<G90 X0 Y0\n");
    delay(10);
    myPort.write("G90 X20 Y0\n");
    print("<<<G90 X20 Y0\n");
    delay(10);
    myPort.write("G90 X20 Y20\n");
    print("<<<G90 X20 Y20\n");
    delay(10);
    myPort.write("G90 X0 Y20\n");
    print("<<<G90 X0 Y20\n");
    delay(10);
    myPort.write("G90 X0 Y0\n");
    print("<<<G90 X0 Y0\n");
    delay(10);
  }
  
  void grblLeft(){
    myPort.write("g91 y-10\n");
    print("<<<g91 y-1\n");
  }
  void grblUp(){
    myPort.write("g91 x-10\n");
    print("<<<g91 x-1\n");
  }
  void grblRight(){
    myPort.write("g91 y10\n");
    print("<<<g91 y1\n");
  }
  void grblDown(){
    myPort.write("g91 x10\n");
    print("<<<g91 x1\n");
  }
  void grblPenup(){
    myPort.write("m03 s600\n");
    print("<<<m03 s600\n");
  }
  void grblPendown(){
    myPort.write("m03 s100\n");
    print("<<<m03 s100\n");
  }
  void grblSend(String x){
    myPort.write(x+"\n");
    print("<<<"+x+"\n");
  }
}