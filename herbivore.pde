class Herbivore extends Animal {
  Herbivore(PVector _pos, float _maxspeed, float _maxforce) {
    accel = new PVector(0, 0);
    vel = new PVector(0, 0);
    pos = _pos;
    size = 5.5;
    maxspeed = _maxspeed;
    maxforce = _maxforce;
    desired = new PVector(width/2, height/2);
    counter = 500;
    timer = millis();
  }
  void move() {
    if ((pos.x > width) || (pos.x < 0)) {
      vel.x = vel.x * -1;
    }
    if ((pos.y > height) || (pos.y < 0)) {
      vel.y = vel.y * -1;
    } 
    if (millis() - timer > counter) {
      wander();
      timer = millis();
      print(" "+timer/500);
    }
    
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxforce);
    applyForce(steer);
  }
  void wander() {
    float r = 20.5;
    float x = r*cos(random(360));
    float y = r*sin(random(360));
    
    desired.sub(new PVector(x, y));
    desired.normalize();
    desired.mult(maxspeed);
  }
}
