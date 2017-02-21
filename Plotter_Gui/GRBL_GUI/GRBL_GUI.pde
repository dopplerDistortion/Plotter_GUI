import processing.serial.*;
import controlP5.*;
import java.util.*;
import geomerative.*;
String[] gcode;

int counter = 0;
boolean remove = false;


RShape grp;
RPoint[][] pointPaths;
Serial myPort;
ControlP5 cp5;
PShape bot;

Alarm alarm;
Command command;
Messages messages;
Textarea myTextarea;
Textfield myTextfield;
UI ui;

FileType ft;

String penUp= "M03 S600 \n G4P0.1 \n"; // Command to control the pen, it change beetween differents firmware
String penDown = "M03 S200 \n G4P0.2 \n";// This settings was made for my custom CNC Drawing machine
float[] xcoord = { 0,280};// These variables define the minimum and maximum position of each axis for your output GCode 
float[] ycoord = { 0,220};// These settings also change between your configuration
float neww, newh, rw, rh, xmaped, ymaped = 0.0;

float xmag, ymag, newYmag, newXmag = 0;
float z = 0;
int tempw,temph=0;

boolean ignoringStyles = false;
boolean SEND_ONCE;
int filesaved = 0;

String val, Port[], selPort[], temp, path;
int selection;
int n, conFlag=0, printFlag = 0, index;
int selBaud[] = {
  115200,
  9600
};

PShape s;

void setup(){
  size(800, 480, P3D); //make our canvas 200 x 200 pixels big
  
  background(255);
  smooth();
  noStroke();
  frameRate(50);
  //  initialize your serial port and set the baud rate to 9600
  RG.init(this);
  RG.ignoreStyles(ignoringStyles);  
  RG.setPolygonizer(RG.ADAPTATIVE);
  
  
  command = new Command();
  alarm = new Alarm();
  messages = new Messages();
  ui= new UI();

  ft = new FileType();
  
  
  SEND_ONCE = false;
  cp5 = new ControlP5(this);
  cp5.enableShortcuts();
  cp5.setAutoDraw(false);
  index = 0;
  ui.dr();
  
  
  //myPort = new Serial(this, "COM3", 115200);
  //val = myPort.readStringUntil('\n');
  //delay(3000);
  //myPort.write("$X\n");
  //myPort.write("$H\n");
  
  
}

void draw(){
  translate(0,0);
  hint(DISABLE_DEPTH_TEST);
  cp5.draw();
  hint(ENABLE_DEPTH_TEST);
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
    println("Generating...");
    //bot = loadShape(path);
    //shape(bot, 280, 40, xmaped, ymaped);
    translate(490,265);
    svg2gcode(path,0);
    break;
    case(65):
    translate(490,265);
    svg2gcode(path, PI/2.0);
    break;
    case(66):
    translate(490,265);
    svg2gcode(path,-PI/2.0);
    break;
    case(67):
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
    printFlag = 0;
  }
  else{
    println("Connection Closed");
    printFlag = 0;
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
    ft.filt(path);
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

void svg2gcode(String x, float y){
  String gcodecommand ="G0 F10000 \n G0"+ penUp; // String to store the Gcode we wil save later
  String[] gcodecommandlist = {"0"};
  float a;
  path = x;
  grp = RG.loadShape(x);
  grp.rotate(y);
  grp.centerIn(g, 100, 1, 1);
  pointPaths = grp.getPointsInPaths();
  pointPaths = grp.getPointsInPaths();
  
  newXmag = mouseX/float(width) * TWO_PI;
  newYmag = mouseY/float(height) * TWO_PI;
  
  float diff = xmag-newXmag;
  if (abs(diff) >  0.01) { xmag -= diff/4.0; }
  
  diff = ymag-newYmag;
  if (abs(diff) >  0.01) { ymag -= diff/4.0; }
  
  //rotateX(-ymag); 
  //rotateY(-xmag);
  
  background(255);
  stroke(0);
  noFill();
  
  rw = grp.width / xcoord[1];
  rh = grp.height / ycoord[1];
  
  
  if( filesaved == 0){
  for(int i = 0; i<pointPaths.length; i++){
    if (pointPaths[i] != null) {
      tempw++;
      for(int j = 0; j<pointPaths[i].length; j++){
      temph++;
      }
    }
  } 
}
  
  println(grp.width,grp.height,tempw ,temph );
  //grp.rotate(90);
  //println(grp.width,grp.height);
  if(rw >rh){
    a = xcoord[1];
  }
  else{
    a = ycoord[1];
  }
  


  for(int i = 0; i<pointPaths.length; i++){
    if (pointPaths[i] != null) {
      
      beginShape();
      
      for(int j = 0; j<pointPaths[i].length; j++){
        vertex(pointPaths[i][j].x, pointPaths[i][j].y);
        translate(0,0);
        xmaped = map(pointPaths[i][j].x,-200, 200, 220, xcoord[0]);
        ymaped = map(pointPaths[i][j].y,-200, 200, ycoord[0] , 220);
        if(j == 1){
          gcodecommand = gcodecommand + penDown;
        }
        gcodecommand = gcodecommand + "G1 X"+ str(xmaped)+" Y"+str(ymaped) +"\n"; 
      }

      endShape();

    }
   gcodecommand = gcodecommand + penUp + "\n" ;
  
   if(i == pointPaths.length-1){
      //gcodecommand = "$H \n" ;
      gcodecommandlist = split(gcodecommand, '\n');
      saveStrings("temp.gcode", gcodecommandlist);
      gcode = gcodecommandlist;
      println("finished",gcodecommandlist.length);
      remove = true;
    }
  }
  int temp = gcodecommandlist.length;
  for (int j = 0; j<=temp ; j++){
      if(remove && gcodecommandlist.length > 0){
      gcodecommandlist = pop(gcodecommandlist);
      } 
      
      else {
      gcodecommandlist = push(gcodecommandlist, str(counter));
      counter += 1;
      }
      
    }
    println("fdeleted",gcodecommandlist.length);
      remove = false;
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


String[] push(String[] a, String element){
  String[] b = new String[a.length+1];
  b[0] = element;
  System.arraycopy(a,0,b,1,a.length);
  return b;
}

String[] pop(String[] a){
  String[] b = new String[a.length-1];
  System.arraycopy(a,0,b,0,a.length-1);
  return b;
}
 