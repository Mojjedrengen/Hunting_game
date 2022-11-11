class Carnivore extends Animal {
  Carnivore(PVector _pos, float _maxspeed, float _maxforce) {
    accel = new PVector(0, 0);
    vel = new PVector(0, 0);
    pos = _pos;
    size = 5.5;
    maxspeed = _maxspeed;
    maxforce = _maxforce;
    desired = new PVector(width/2, height/2);
    counter = 1000;
    timer = millis();
  }

  void hunt(Animal _target) {
    desired = PVector.sub(_target.pos, pos);
    desired.normalize();
    desired.mult(maxspeed);
  }
  
  void move(Animal _target) {
    float range = 100;
    if ((pos.x > width) || (pos.x < 0)) {
      vel.x = vel.x * -1;
      desired.x *= -1;
      text("Border X", width/2,height/2);
    }
    else if ((pos.y > height) || (pos.y < 0)) {
      vel.y = vel.y * -1;
      desired.y *= -1;
      text("Border Y", width/2,height/2);
    } 
    else if (dist(pos.x, pos.y, _target.pos.x, _target.pos.y) < range) {
      hunt(_target);
      text("Hunting", width/2,height/2);
    }
    else if (millis() - timer > counter) {
      wander();
      timer = millis();
      print(" C:"+timer/1000);
      text("Wandring", width/2,height/2);
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
