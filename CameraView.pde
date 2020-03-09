PImage back;
Planet star;
PFont font;
boolean moveCameraUp, moveCameraDown, moveCameraRight, moveCameraLeft, moveShipUp, moveShipDown, moveShipRight, moveShipLeft, splashScreen;
PVector textColor;
int lookOffsetX, lookOffsetY;
int shipOffsetX, shipOffsetY;
Ship camera;

void setup(){
  size(1280,720,P3D);
  stroke(0);
  
  imageMode(CENTER);
  
  back = loadImage("assets/background-alt.jpg");
 
  star = new Planet("",100,0.5,0,loadImage("assets/startexture.jpg"),false);
  
  Planet test1 = new Planet("Monnion",10,4*0.25,0.5,loadImage("assets/texture1.gif"),true);
  Planet test2 = new Planet("Selnuimia",20,3*0.25,5,loadImage("assets/texture2.gif"),true);
  Planet test3 = new Planet("Lozarth",60,2*0.25,12,loadImage("assets/texture3.gif"),true);
  Planet test4 = new Planet("Dulnarth",30,1*0.25,20,loadImage("assets/texture4.gif"),true);
  Planet test5 = new Planet("Oagantu",20,0.5*0.25,25,loadImage("assets/texture5.gif"),true);
  
  Planet satellite1 = new Planet("Theomia",10,3*0.25,0.5,loadImage("assets/texture6.gif"),true);
  
  test3.addSatelite(satellite1);
  
  star.addSatelite(test1);
  star.addSatelite(test2);
  star.addSatelite(test3);
  star.addSatelite(test4);
  star.addSatelite(test5); 
  
  back.resize(width,height);
  
  moveCameraUp = false;
  moveCameraDown = false;
  moveCameraRight = false;
  moveCameraLeft = false;
  moveShipUp = false;
  moveShipDown = false;
  moveShipRight = false;
  moveShipLeft = false;
  
  splashScreen = true;
  
  lookOffsetX = 0;
  lookOffsetY = 0;
  
  shipOffsetX = 0;
  shipOffsetY = 0;
  
  camera = new Ship(new PVector(width/2.0-shipOffsetX, height/2.0-shipOffsetY, (height/2.0) / tan(PI*30.0 / 180.0)),
  new PVector(width/2.0-lookOffsetX, height/2.0-lookOffsetY, 0), new PVector(0, 1, 0));
  
  textColor = new PVector(255,110,243);
  font = createFont("assets/RobotoCondensed-Bold.ttf",128);
  textFont(font);
}

void draw(){
  background(200);
  translate(width/2, height/2,0);
  background(back);
  
  if(splashScreen){
    drawSplashScreen();
  } else {
    camera.setCamera(new PVector(width/2.0-shipOffsetX, height/2.0, ((height/2.0) / tan(PI*30.0 / 180.0))-shipOffsetY),
    new PVector(width/2.0-lookOffsetX, height/2.0-lookOffsetY, 0), new PVector(0, 1, 0));
    
    camera.updateMainCamera();
    
    control();
    star.draw();
    
  }
  
  
}

void control(){
  if(moveCameraUp){
    //rXD += 0.05;
    lookOffsetY += 10;
  } else if (moveCameraDown){
    //rXD -= 0.05;
    lookOffsetY -= 10;
  }
  
  if(moveCameraLeft){
    //rYD -= 0.05;
    lookOffsetX += 10;
  } else if (moveCameraRight){
    //rYD += 0.05;
    lookOffsetX -= 10;
  }
  
  if(moveShipUp){
    //rXD += 0.05;
    shipOffsetY += 10;
  } else if (moveShipDown){
    //rXD -= 0.05;
    shipOffsetY -= 10;
  }
  
  if(moveShipLeft){
    //rYD -= 0.05;
    shipOffsetX += 10;
  } else if (moveShipRight){
    //rYD += 0.05;
    shipOffsetX -= 10;
  }
}

void drawSplashScreen(){
    fill(textColor.x, textColor.y, textColor.z);
    textAlign(CENTER);
    textSize(128);
    text("Camera View",0,-100);
    textSize(32);
    text("WASD para rotar el sistema",0,+50);
    text("Barra Espaciadora para empezar",0,+100);
    
    textColor.x += random(-10,10);
    textColor.y += random(-10,10);
    textColor.z += random(-10,10);
    noFill();
}

void keyPressed(){
  if(key == ' '){
    splashScreen = false;
  }
  if(key == 'w'){
    moveCameraUp = true;
  } else if(key == 's'){
    moveCameraDown = true;
  }
  if(key == 'd'){
    moveCameraRight = true;
  } else if(key == 'a'){
    moveCameraLeft = true;
  }  
  
  if(keyCode == UP){
    moveShipUp = true;
  } else if(keyCode == DOWN){
    moveShipDown = true;
  }
  if(keyCode == RIGHT){
    println("Puto");
    moveShipRight = true;
  } else if(keyCode == LEFT){
    moveShipLeft = true;
  }
}

void keyReleased(){
  if(key == 'w'){
    moveCameraUp = false;
  } else if(key == 's'){
    moveCameraDown = false;
  }
  if(key == 'd'){
    moveCameraRight = false;
  } else if(key == 'a'){
    moveCameraLeft = false;
  }  
  
  if(keyCode == UP){
    moveShipUp = false;
  } else if(keyCode == DOWN){
    moveShipDown = false;
  }
  if(keyCode == RIGHT){
    moveShipRight = false;
  } else if(keyCode == LEFT){
    moveShipLeft = false;
  }
}
