PImage back;
Planet star;
PFont font;
boolean rotateUY, rotateDY, rotateLX, rotateRX, splashScreen;
float rXD, rYD;
PVector textColor;

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
  
  rotateUY = false;
  rotateDY = false;
  rotateLX = false;
  rotateRX = false;
  
  splashScreen = true;
  
  rYD = 0.0;
  rXD = 0.0;
  
  textColor = new PVector(255,110,243);
  font = createFont("assets/RobotoCondensed-Bold.ttf",128);
  textFont(font);
}

void draw(){
  background(200);
  translate(width/2, height/2,0);
  background(back);
  
  if(splashScreen){
    fill(textColor.x, textColor.y, textColor.z);
    textAlign(CENTER);
    textSize(128);
    text("Orbital System",0,-100);
    textSize(32);
    text("WASD para rotar el sistema",0,+50);
    text("Barra Espaciadora para empezar",0,+100);
    
    textColor.x += random(-10,10);
    textColor.y += random(-10,10);
    textColor.z += random(-10,10);
    noFill();
  } else {
    rotateX(rXD);
    rotateY(rYD);
    control();
    star.draw();
  }
  
  
}

void control(){
  if(rotateUY){
    rXD += 0.05;
  } else if (rotateDY){
    rXD -= 0.05;
  }
  
  if(rotateLX){
    rYD -= 0.05;
  } else if (rotateRX){
    rYD += 0.05;
  }
}

void keyPressed(){
  if(key == ' '){
    splashScreen = false;
  }
  if(key == 'w'){
    rotateUY = true;
  } else if(key == 's'){
    rotateDY = true;
  }
  if(key == 'd'){
    rotateRX = true;
  } else if(key == 'a'){
    rotateLX = true;
  }  
}

void keyReleased(){
  if(key == 'w'){
    rotateUY = false;
  } else if(key == 's'){
    rotateDY = false;
  }
  if(key == 'd'){
    rotateRX = false;
  } else if(key == 'a'){
    rotateLX = false;
  }  
}
