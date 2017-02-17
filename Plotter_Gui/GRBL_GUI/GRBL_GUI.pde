import processing.serial.*;
import controlP5.*;
import java.util.*;

Serial myPort;
ControlP5 cp5;
String val, Port[], selPort[], temp, path;
int selection;
int n, conFlag=0, printFlag = 0, index;
int selBaud[] = {
  115200,
  9600
};
String[] gcode;


Alarm alarm;
Command command;
Messages messages;
Textarea myTextarea;
Textfield myTextfield;

void setup(){
  size(800, 480); //make our canvas 200 x 200 pixels big
  smooth();
  noStroke();
  frameRate(50);
  //  initialize your serial port and set the baud rate to 9600

  command = new Command();
  alarm = new Alarm();
  messages = new Messages();

  cp5 = new ControlP5(this);
  cp5.enableShortcuts();

  
  index = 0;
  setupScreen();
  
  
  //myPort = new Serial(this, "COM3", 115200);
  //val = myPort.readStringUntil('\n');
  //delay(3000);
  //myPort.write("$X\n");
  //myPort.write("$H\n");
  
  
}

void draw(){
  background(242, 244, 246);

}

void setupScreen(){
  
  List baud = Arrays.asList("115200", "9600");
  List port = Arrays.asList(myPort.list());
  selPort = myPort.list();
  /* add a ScrollableList, by default it behaves like a DropdownList */
  
  cp5.addScrollableList("port")
     .setPosition(10, 70)
     .setSize(45, 100)
     .setBarHeight(20)
     .setItemHeight(20)
     .addItems(port)
     .setType(ScrollableList.DROPDOWN) // currently supported DROPDOWN and LIST
     .setId(0);
     ;
  
  cp5.addScrollableList("baudrate")
     .setPosition(65, 70)
     .setSize(45, 100)
     .setBarHeight(20)
     .setItemHeight(20)
     .addItems(baud)
     .setType(ScrollableList.DROPDOWN) // currently supported DROPDOWN and LIST
     .setId(1)
     ;
  
  cp5.addToggle("Connect")
     .setPosition(10,30)
     .setSize(100,20)
     .setId(2)
     .setColorCaptionLabel(30)
     ;

  //cp5.addButton("Settings")
  //   .setPosition(10,120)
  //   .setSize(100,20)
  //   .setId(3)
  //   ;
  
  //cp5.addButton("# parameters")
  //   .setPosition(10,150)
  //   .setSize(100,20)
  //   .setId(4)
  //   ;
     
  //cp5.addButton("parse state")
  //   .setValue(0)
  //   .setPosition(10,180)
  //   .setSize(100,20)
  //   .setId(5)
  //   ;
     
  //cp5.addButton("build info")
  //   .setValue(0)
  //   .setPosition(10,210)
  //   .setSize(100,20)
  //   .setId(6)
  //   ;
     
  //cp5.addButton("startup blocks")
  //   .setValue(0)
  //   .setPosition(10,240)
  //   .setSize(100,20)
  //   .setId(7)
  //   ;
     
  //cp5.addButton("gcode mode")
  //   .setValue(0)
  //   .setPosition(10,270)
  //   .setSize(100,20)
  //   .setId(8)
  //   ;
     
  //cp5.addButton("kill lock")
  //   .setValue(0)
  //   .setPosition(10,300)
  //   .setSize(100,20)
  //   .setId(9)
  //   ;
     
  cp5.addButton("homing cycle")
     .setValue(0)
     .setPosition(10,160)
     .setSize(100,20)
     .setId(10)
     ;
     
  //cp5.addButton("Reset Grbl")
  //   .setValue(0)
  //   .setPosition(10,360)
  //   .setSize(100,20)
  //   .setId(11)
  //   ;
     
  cp5.addButton("Set Zero")
     .setValue(0)
     .setPosition(10,190)
     .setSize(100,20)
     .setId(12)
     ;
     
  cp5.addButton("Return Zero")
     .setValue(0)
     .setPosition(10,220)
     .setSize(100,20)
     .setId(13)
     ;
     
  cp5.addButton("Hand Shake")
     .setValue(0)
     .setPosition(10,250)
     .setSize(100,20)
     .setId(14)
     ;
     
  cp5.addButton("LEFT")
     .setValue(0)
     .setPosition(10,360)
     .setSize(50,50)
     .setId(15)
     ;
     
  cp5.addButton("UP")
     .setValue(0)
     .setPosition(70,300)
     .setSize(50,50)
     .setId(16)
     ;
     
  cp5.addButton("RIGHT")
     .setValue(0)
     .setPosition(130,360)
     .setSize(50,50)
     .setId(17)
     ;
     
  cp5.addButton("DOWN")
     .setValue(0)
     .setPosition(70,420)
     .setSize(50,50)
     .setId(18)
     ;
     
  cp5.addButton("PEN UP")
     .setValue(0)
     .setPosition(70,360)
     .setSize(50,20)
     .setId(19)
     ;
     
  cp5.addButton("PEN DOWN")
     .setValue(0)
     .setPosition(70,390)
     .setSize(50,20)
     .setId(20)
     ;
     
     //TABS
   
   cp5.getTab("default")
     .activateEvent(true)
     .setLabel("Control")
     .setId(50)
     ;  
     
   cp5.getTab("eeprom")
     .activateEvent(true)
     .setLabel("EEPROM")
     .setId(51)
     ;
     
   cp5.getTab("gcode")
     .activateEvent(true)
     .setLabel("Gcode")
     .setId(53)
     ;
     //Console
   
   cp5.addTextfield("default")
     .setPosition(190,30)
     .setAutoClear(true)
     .setId(52)
     .setLabel("")
     ;
     
   //frameRate(20);
   //myTextarea = cp5.addTextarea("txt")
   //               .setPosition(190, 60)
   //               .setSize(200, 410)
   //               .setFont(createFont("", 10))
   //               .setLineHeight(14)
   //               .setColor(color(30))
   //               .setColorBackground(color(0, 100))
   //               .setColorForeground(color(255, 100))
   //               ;
   // ;
  
   // myTextarea.setText(console);
    
    
    
    //File Picker
    
    cp5.addButton("File")
     .setPosition(10,30)
     .setSize(100,20)
     .setId(60)
     .setLabel("Browse...")
     ;
    
    myTextfield = cp5.addTextfield("textinput")
                   .setPosition(120, 30)
                   .setSize(400, 20)
                   .setFocus(false)
                   .setLabel("")
                   ;
                   
  
  cp5.addButton("clear")
     .setPosition(530,30)
     .setSize(50,20)
     .setId(61)
     .setLabel("Clear")
     ;
     
  cp5.addButton("submit")
     .setPosition(590,30)
     .setSize(50,20)
     .setId(62)
     .setLabel("Submit")
     ;
     
  cp5.getController("File").moveTo("gcode");
  cp5.getController("textinput").moveTo("gcode");
  cp5.getController("clear").moveTo("gcode");
  cp5.getController("submit").moveTo("gcode");
}

void baudrate(int n) {
  println(n, selBaud[n]);

  CColor c = new CColor();
  c.setBackground(color(255,0,0));
  cp5.get(ScrollableList.class, "baudrate").getItem(n).put("color", c);  
}

void port(int n) {
  println(n,selPort[n]);
  CColor c = new CColor();
  c.setBackground(color(255,0,0));
  cp5.get(ScrollableList.class, "port").getItem(n).put("color", c);  
}


public void controlEvent(ControlEvent theEvent) {
  //println(theEvent.getController().getName());
  n = 0;
  
  //if(theEvent.isAssignableFrom(Textfield.class)) {
  //  println("controlEvent: accessing a string from controller '"
  //          +theEvent.getName()+"': "
  //          +theEvent.getStringValue()
  //          );
  //}
  
  switch(theEvent.getController().getId()) {
    case(0):

    break;
    case(1):

    break;
    case(2):

    break;
    case(3):
    command.grblSettings();
    break;
    case(4):
    command.grblParameters();
    break;
    case(5):
    command.grblParsestate();
    break;
    case(6):
    command.grblBuildinfo();
    break;
    case(7):
    command.grblStartupblocks();
    break;
    case(8):
    command.grblGcodemode();
    break;
    case(9):
    command.grblKilllock();
    break;
    case(10):
    command.grblHome();
    break;
    case(11):
    command.grblReset();
    break;
    case(12):
    command.grblSetzero();
    break;
    case(13):
    command.grblReturnzero();
    break;
    case(14):
    command.grblHandshake();
    break;
    case(15):
    command.grblLeft();
    break;
    case(16):
    command.grblUp();
    break;
    case(17):
    command.grblRight();
    break;
    case(18):
    command.grblDown();
    break;
    case(19):
    command.grblPenup();
    break;
    case(20):
    command.grblPendown();
    break;
    case(52):
    command.grblSend(theEvent.getStringValue());
    break;
    case(60):
    selectInput("Select a folder to process:", "fileSelected");
    break;
    case(62):
    println("Printing...");
    printFlag = 1;
    nextStep();
    break;
  }
}

public void Handshake(int theValue) {
  command.grblHandshake();
}

public void Connect(int theFlag){
  if(theFlag == 1){
    println("Connecting to " + selPort[n] + " with " + selBaud[n] + " baudrate.");
    myPort = new Serial(this, selPort[n], selBaud[n]);
    myPort.bufferUntil('\n'); 
    conFlag = 1; 
    delay(3000);
    myPort.write("$X\n");
    myPort.write("$H\n");
  }
  else{
    println("Connection Closed");
    myPort.stop();
    conFlag = 0;
  }
}

void serialEvent(Serial port){
  temp = port.readString();
  print(">>>"+temp);
  if (temp.trim().startsWith("ok") && printFlag == 1){
    nextStep();
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    path = selection.getAbsolutePath();
    gcode = loadStrings(path);
    
    performTextfieldActions();
  }
}

void performTextfieldActions() {
  myTextfield.getText();
  myTextfield.setText(path);
  myTextfield.getText();
}

void clear(int theValue) {
  myTextfield.clear();
}

void submit(int theValue) {
  myTextfield.submit();
}

void nextStep(){
   if (index < gcode.length){
     myPort.write(gcode[index]+ "\n");
     println(gcode[index]);
     index++;
   }
   if (index == gcode.length){
     println("finished!");
     printFlag = 0;
   }
}