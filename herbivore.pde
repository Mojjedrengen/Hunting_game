class Herbivore extends Animal {
  Herbivore(PVector _pos, float _maxspeed, float _maxforce) {
    accel = new PVector(0, 0);
    vel = new PVector(0, 0);
    pos = _pos;
    size = 5.5;
    maxspeed = _maxspeed;
    maxforce = _maxforce;
    desired = new PVector(width/2, height/2);
    counter = 500;  //How often wander acours in milliseconds
    timer = millis();
  }
  void move() {
    if ((pos.x > width) || (pos.x < 0)) {  //border on x
      vel.x = vel.x * -1;
      desired.x *= -1;
    }
    if ((pos.y > height) || (pos.y < 0)) {  //border on y
      vel.y = vel.y * -1;
      desired.y *= -1;
    } 
    if (millis() - timer > counter) {   //starts the animals wandering behavior 
      wander();
      timer = millis();
      print(" H:"+timer/500);  //debug
    }
    
    PVector steer = PVector.sub(desired, vel);  //makes the animal move
    steer.limit(maxforce);
    applyForce(steer);
  }
  void wander() {    //makes the target move to a new point via polar vectors
    float r = 20.5;
    float x = r*cos(random(360));
    float y = r*sin(random(360));
    
    desired.sub(new PVector(x, y));
    desired.normalize();
    desired.mult(maxspeed);
  }
}
