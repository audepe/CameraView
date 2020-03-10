PImage back;
PImage tractorTexture;
Planet star;
PFont font;
boolean moveTractorUp, moveTractorDown, moveTractorRight, moveTractorLeft,
moveCameraUp, moveCameraDown, moveCameraRight, moveCameraLeft, splashScreen,
firstPerson;

PVector textColor;

PShape tractor;
float yaw = -180;
float pitch = 10;
PVector tractorDirection = new PVector();
PVector cameraPosition = new PVector();
PVector tractorPosition = new PVector(300, 0, -300);
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
  
  moveTractorUp = false;
  moveTractorDown = false;
  moveTractorRight = false;
  moveTractorLeft = false;
  moveCameraUp = false;
  moveCameraDown = false;
  moveCameraRight = false;
  moveCameraLeft = false;
  
  splashScreen = true;
    
  textColor = new PVector(255,110,243);
  font = createFont("assets/RobotoCondensed-Bold.ttf",128);
  textFont(font);
  
  tractor = loadShape("assets/tractor/Tractor.obj");
  updateTractor();
  tractor.rotateX(radians(180));
  tractor.rotateY(radians(180));
  
  firstPerson = false;
  
  tractorTexture = loadImage("assets/tractor/Texure Tractor.jpg");
  tractor.setTexture(tractorTexture);
}

void draw(){
  background(200);
  translate(width/2, height/2,0);
  background(back);
  
  if(splashScreen){
    drawSplashScreen();
  } else {
    if(firstPerson){
      control();
      camera(
      cameraPosition.x, cameraPosition.y, cameraPosition.z,
      tractorPosition.x, tractorPosition.y, tractorPosition.z,
      up.x, up.z, up.y); 
      
    } else {
      camera(0,0,-700,
      0, 0, -100,
      0, 1, 0);
    }
    
    pushMatrix();
    translate(tractorPosition.x, tractorPosition.y, tractorPosition.z);
    tractor.setTexture(tractorTexture);
    shape(tractor);
    popMatrix();
    
    star.draw();    
  }  
}

void control(){
  if (moveTractorUp){
    tractorPosition.sub(PVector.mult(tractorDirection, step));
  } else if (moveTractorDown){
    tractorPosition.add(PVector.mult(tractorDirection, step));
  }
  
  if (moveTractorLeft){
    tractorPosition.x += step;
  } else if (moveTractorRight){
    tractorPosition.x -= step;
  }
  
  if (moveCameraUp && pitch > -89.0 && pitch > 1){
    pitch = (pitch - angleStep) % 360;
    tractor.rotateX(-radians(angleStep));
  } else if (moveCameraDown && pitch < 89.0){
    pitch = (pitch + angleStep) % 360;
    tractor.rotateX(radians(angleStep));
  }
  
  if (moveCameraLeft){
    yaw = (yaw - angleStep) % 360;
    tractor.rotateY(-radians(angleStep));
  } else if (moveCameraRight){
    yaw = (yaw + angleStep) % 360;
    tractor.rotateY(+radians(angleStep));
  }
  updateTractor();
}

void updateTractor(){
  horizontalDistance = dist * cos(radians(pitch));
  verticalDistance = dist * sin(radians(pitch));
  cameraPosition.y = tractorPosition.y + verticalDistance;
  cameraPosition.x = tractorPosition.x + horizontalDistance * sin(radians(yaw));
  cameraPosition.z = tractorPosition.z + horizontalDistance * cos(radians(yaw));
  tractorDirection.x = sin(radians(yaw)) * cos(radians(pitch));
  tractorDirection.z = cos(radians(yaw)) * cos(radians(pitch));
  tractorDirection.y = sin(radians(pitch));
  tractorDirection.normalize();
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
    text("Enter para alternar la vista",0,+200);
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
    moveTractorUp = true;
  } else if(key == 's'){
    moveTractorDown = true;
  }
  if(key == 'd'){
    moveTractorRight = true;
  } else if(key == 'a'){
    moveTractorLeft = true;
  }  
  
  if(keyCode == UP){
    moveCameraUp = true;
  } else if(keyCode == DOWN){
    moveCameraDown = true;
  }
  if(keyCode == RIGHT){
    moveCameraRight = true;
  } else if(keyCode == LEFT){
    moveCameraLeft = true;
  }
  
  if(keyCode == ENTER){
    firstPerson = !firstPerson;
  }
}

void keyReleased(){
  if(key == 'w'){
    moveTractorUp = false;
  } else if(key == 's'){
    moveTractorDown = false;
  }
  if(key == 'd'){
    moveTractorRight = false;
  } else if(key == 'a'){
    moveTractorLeft = false;
  }  
  
  if(keyCode == UP){
    moveCameraUp = false;
  } else if(keyCode == DOWN){
    moveCameraDown = false;
  }
  if(keyCode == RIGHT){
    moveCameraRight = false;
  } else if(keyCode == LEFT){
    moveCameraLeft = false;
  }
}
