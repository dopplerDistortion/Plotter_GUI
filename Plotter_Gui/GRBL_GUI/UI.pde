class UI{
  void dr(){
  
  List baud = Arrays.asList("115200", "9600");
  List port = Arrays.asList(myPort.list());
  selPort = myPort.list();
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
  
  cp5.addTextfield("default")
     .setPosition(10,140)
     .setSize(100,20)
     .setAutoClear(true)
     .setId(52)
     .setLabel("")
     ;   
     
  cp5.addButton("homing cycle")
     .setValue(0)
     .setPosition(10,170)
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
     .setPosition(10,200)
     .setSize(100,20)
     .setId(12)
     ;
     
  cp5.addButton("Return Zero")
     .setValue(0)
     .setPosition(10,230)
     .setSize(100,20)
     .setId(13)
     ;
     
  cp5.addButton("Hand Shake")
     .setValue(0)
     .setPosition(10,260)
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
    
      
    myTextfield = cp5.addTextfield("textinput")
                   .setPosition(200, 30)
                   .setSize(400, 20)
                   .setFocus(false)
                   .setLabel("")
                   ;
                   
  
  cp5.addButton("clear")
     .setPosition(610,30)
     .setSize(50,20)
     .setId(61)
     .setLabel("Clear")
     ;
     
  cp5.addButton("submit")
     .setPosition(670,30)
     .setSize(50,20)
     .setId(62)
     .setLabel("Submit")
     ;
     
  cp5.addButton("File")
     .setPosition(730,30)
     .setSize(50,20)
     .setId(60)
     .setLabel("Browse...")
     ;
     
  cp5.addButton("Rotate")
     .setPosition(610,60)
     .setSize(50,20)
     .setId(65)
     .setLabel("90")
     ;
  
  cp5.addButton("-Rotate")
     .setPosition(670,60)
     .setSize(50,20)
     .setId(66)
     .setLabel("-90")
     ;
  
  cp5.addButton("Print!")
     .setPosition(730,60)
     .setSize(50,20)
     .setId(67)
     .setLabel("Print!")
     ;
     
  //cp5.getController("File").moveTo("gcode");
  //cp5.getController("textinput").moveTo("gcode");
  //cp5.getController("clear").moveTo("gcode");
  //cp5.getController("submit").moveTo("gcode");
  }
}