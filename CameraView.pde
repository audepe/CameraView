PImage back;
Planet star;
PFont font;
boolean moveCameraUp, moveCameraDown, moveCameraRight, moveCameraLeft, moveShipUp, moveShipDown, moveShipRight, moveShipLeft, splashScreen;
PVector textColor;

PShape tractor;
float yaw = -180;
float pitch = 10;
PVector direction = new PVector();
PVector cameraPos = new PVector();
PVector shipPos = new PVector(0, 0, -600);
PVector up = new PVector(0, 1, 0);
int dist = 500;
float horizontalDistance;
float verticalDistance;
float step = 5.0;
float angleStep = 1;

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
    
  textColor = new PVector(255,110,243);
  font = createFont("assets/RobotoCondensed-Bold.ttf",128);
  textFont(font);
  
  tractor = loadShape("assets/tractor/tractor.obj");
  updateTractor();
  tractor.rotateX(radians(180));
  tractor.scale(0.1);
}

void draw(){
  background(200);
  translate(width/2, height/2,0);
  background(back);
  
  if(splashScreen){
    drawSplashScreen();
  } else {
    control();
    camera(
    cameraPos.x, cameraPos.y, cameraPos.z,
    shipPos.x, shipPos.y, shipPos.z,
    up.x, up.z, up.y);
    
    star.draw();
    
  }
  
  
}

void control(){
  if (moveCameraUp){
    shipPos.sub(PVector.mult(direction, step));
  } else if (moveCameraDown){
    shipPos.add(PVector.mult(direction, step));
  }
  
  if (moveCameraLeft){
    shipPos.x += step;
  } else if (moveCameraRight){
    shipPos.x -= step;
  }
  
  if (moveShipUp && pitch > -89.0 && pitch > 1){
    pitch = (pitch - angleStep) % 360;
    tractor.rotateX(-radians(angleStep));
  } else if (moveShipDown && pitch < 89.0){
    pitch = (pitch + angleStep) % 360;
    tractor.rotateX(radians(angleStep));
  }
  
  if (moveShipLeft){
    yaw = (yaw - angleStep) % 360;
    tractor.rotateY(-radians(angleStep));
  } else if (moveShipRight){
    yaw = (yaw + angleStep) % 360;
    tractor.rotateY(+radians(angleStep));
  }
  updateTractor();
}

void updateTractor(){
  horizontalDistance = dist * cos(radians(pitch));
  verticalDistance = dist * sin(radians(pitch));
  cameraPos.y = shipPos.y + verticalDistance;
  cameraPos.x = shipPos.x + horizontalDistance * sin(radians(yaw));
  cameraPos.z = shipPos.z + horizontalDistance * cos(radians(yaw));
  direction.x = sin(radians(yaw)) * cos(radians(pitch));
  direction.z = cos(radians(yaw)) * cos(radians(pitch));
  direction.y = sin(radians(pitch));
  direction.normalize();
}

void drawSplashScreen(){
    fill(textColor.x, textColor.y, textColor.z);
    textAlign(CENTER);
    textSize(128);
    text("Camera View",0,-100);
    textSize(32);
    text("WASD para mover el tractor",0,+50);
    text("Flechas para mover la cámara",0,+100);
    text("Barra Espaciadora para empezar",0,+150);
    
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
