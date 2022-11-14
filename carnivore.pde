class Carnivore extends Animal {
  Carnivore(PVector _pos, float _maxspeed, float _maxforce) {
    accel = new PVector(0, 0);
    vel = new PVector(0, 0);
    pos = _pos;
    size = 5.5;
    maxspeed = _maxspeed;
    maxforce = _maxforce;
    desired = new PVector(width/2, height/2);
    counter = 1000; //How often wander acours in milliseconds
    timer = millis();
  }

  void hunt(Animal _target) {    //hunting behavior to make the carnivor follow a target
    desired = PVector.sub(_target.pos, pos);
    desired.normalize();
    desired.mult(maxspeed);
  }
  
  void move(Animal _target) {
    float range = 100;    //range for hunting behavior
    if ((pos.x > width) || (pos.x < 0)) {    //border on x
      vel.x = vel.x * -1;
      desired.x *= -1;
      text("Border X", width/2,height/2);  //debug
    }
    else if ((pos.y > height) || (pos.y < 0)) {    //border on y
      vel.y = vel.y * -1;
      desired.y *= -1;
      text("Border Y", width/2,height/2);  //debug
    } 
    else if (dist(pos.x, pos.y, _target.pos.x, _target.pos.y) < range) {  //hunting behavior if target is inside a given range
      hunt(_target);
      text("Hunting", width/2,height/2);  //debug
    }
    else if (millis() - timer > counter) {    //starts the animals wandering behavior 
      wander();
      timer = millis();
      print(" C:"+timer/1000);    //debug
      text("Wandring", width/2,height/2);  //debug
    }
    
    
    PVector steer = PVector.sub(desired, vel);    //makes the animal move
    steer.limit(maxforce);
    applyForce(steer);
  }
  
  void wander() {  //makes the target move to a new point via polar vectors
    float r = 20.5;
    float x = r*cos(random(360));
    float y = r*sin(random(360));
    
    desired.sub(new PVector(x, y));
    desired.normalize();
    desired.mult(maxspeed);
  }
}
