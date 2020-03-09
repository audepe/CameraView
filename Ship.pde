class Ship {
  
  PVector eye;
  PVector lookingAt;
  PVector verticalVec;
  
  Ship (PVector eye, PVector lookingAt, PVector verticalVec){
    this.eye = eye;
    this.lookingAt = lookingAt;
    this.verticalVec = verticalVec;
  }
  
  void setCamera(PVector eye, PVector lookingAt, PVector verticalVec){
    this.eye = eye;
    this.lookingAt = lookingAt;
    this.verticalVec = verticalVec;
  }
  
  void updateMainCamera(){
    camera(eye.x, eye.y, eye.z, lookingAt.x, lookingAt.y, lookingAt.z, verticalVec.x, verticalVec.y, verticalVec.z);
  }
  
}
