abstract class Animal {
  PVector pos;
  PVector vel;
  PVector accel;
  PVector desired;
  float maxforce;
  float oldMaxSpeed;
  float maxspeed;

  float size;

  int counter;
  int timer;

  float range;
  String whatbehavior; //a string that says what behavior the animal is doing (debug)

  void update() { //moves the animal
    vel.add(accel);
    vel.limit(maxspeed);
    pos.add(vel);
    accel.mult(0);
  }

  void applyForce(PVector _force) { //apply force to the animal
    accel.add(_force);
  }

  void wander() {}
  void flee(Animal _target) {}
  void hunt(Animal _target) {}
  void move(Animal _target) {}
  void debug(){}

  void display(int _r, int _g, int _b) {    //draws the animal
    float theta = vel.heading() + PI/2;
    fill(_r, _g, _b);
    stroke(0);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    beginShape();
    vertex(0, -size*2);
    vertex(-size, size*2);
    vertex(size, size*2);
    endShape(CLOSE);
    popMatrix();
  }
}
