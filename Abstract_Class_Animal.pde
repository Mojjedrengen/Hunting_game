abstract class Animal {
  PVector pos;
  PVector vel;
  PVector accel;
  PVector desired;
  float maxforce;
  float maxspeed;
  
  float size;
  
  int counter;
  int timer;
  
  void update() {
    vel.add(accel);
    vel.limit(maxspeed);
    pos.add(vel);
    accel.mult(0);
  }
  
  void applyForce(PVector _force) {
    accel.add(_force);
  }
  
  void wander(){}
  void flee(){}
  void hunt(Animal _target){}
  void move(){}
  void move(Animal _target){}
  
  void display(int _r, int _g, int _b){
    float theta = vel.heading() + PI/2;
    fill(_r, _g, _b);
    stroke(0);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(theta);
    beginShape();
    vertex(0, -size*2);
    vertex(-size, size*2);
    vertex(size, size*2);
    endShape(CLOSE);
    popMatrix();
  }
}
