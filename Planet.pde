class Planet{
  
  String name;
  int radius;
  float angle;
  float secondAngle;
  float velocity;
  float offsetPosition;
  ArrayList<Planet> satelites;
  PImage texture;
  PShape shape;
  boolean translation;
  
  Planet(String name, int radius, float velocity, float offsetPosition, PImage texture, boolean translation){
    this.name = name;
    this.radius = radius;
    this.velocity = velocity;
    this.offsetPosition = offsetPosition;
    this.angle = 0;
    this.secondAngle = 0;
    this.satelites = new ArrayList<Planet>();
    this.texture = texture;
    this.translation = translation;
    
    shape = createShape(SPHERE,radius);
    shape.setTexture(texture);
    shape.setStroke(100);
  }
  
  void draw(){    
    rotateY(radians(angle));
    pushMatrix();
    if(translation){
      rotateZ(radians(this.angle));
      translate(-width*0.1 + (-width *0.25 * (this.offsetPosition)*0.05), 25*this.offsetPosition*0.05,0);     
    }
    texture(this.texture);
    shape(shape);
    textAlign(CENTER);
    textSize(20);
    text(name,radius-15,-radius);
    if(satelites != null){
      for (Planet p : satelites){        
        p.draw();        
      }
    }
    popMatrix();    
    this.updateAngle();
  }
  
  void addSatelite(Planet satelite){
    satelites.add(satelite);
  }
  
  void updateAngle(){
    this.angle += this.velocity*0.5;
    if (this.angle > 360){
      this.angle = 0;
    }
    this.secondAngle += this.velocity*0.25;
    if (this.secondAngle > 360){
      this.secondAngle = 0;
    }
  }
}
