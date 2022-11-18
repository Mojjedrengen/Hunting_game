class Carnivore extends Animal {
  Carnivore(PVector _pos, float _maxspeed, float _maxforce, float _range) {
    accel = new PVector(0, 0);
    vel = new PVector(0, 0);
    pos = _pos;
    size = 5.5;
    maxspeed = _maxspeed;
    oldMaxSpeed = _maxspeed;
    maxforce = _maxforce;
    desired = new PVector(width/2, height/2);
    counter = 1000; //How often wander acours in milliseconds
    timer = millis();
    range = _range;    //range for hunting behavior
    whatbehavior = " "; //debug
  }

  void hunt(Animal _target) {    //hunting behavior to make the carnivor follow a target
    desired = PVector.sub(_target.pos, pos);
    desired.normalize();
    desired.mult(maxspeed);
  }

  void move(Animal _target) {
    if (pos.x < 25) {
      //[offset-down] Make a desired vector that retains the y direction of
      // the vehicle but points the x direction directly away from
      // the window’s left edge.
      desired = new PVector(maxspeed, vel.y);
      whatbehavior = "hit left border";
    } else if (pos.x > width - 25){
      desired = new PVector(-maxspeed, vel.y);
      whatbehavior = "hit right border";
    } else if (pos.y < 25) {
      desired = new PVector(maxspeed, vel.x);
      whatbehavior = "hit top border";
    } else if (pos.y > height - 25){
      desired = new PVector(-maxspeed, vel.x);
      whatbehavior = "hit bottom border";
    } else if (dist(pos.x, pos.y, _target.pos.x, _target.pos.y) < range) {  //hunting behavior if target is inside a given range
      hunt(_target);
      maxspeed *= 1.01;
      whatbehavior = "hunting";  //debug
    } else if (millis() - timer > counter) {    //starts the animals wandering behavior 
      maxspeed = oldMaxSpeed;
      wander();
      timer = millis();
      print(" C:"+timer/1000);    //debug
      whatbehavior = "wandering";  //debug
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

  void debug() {
    fill(0);
    textSize(25);
    textAlign(CENTER);
    text("behavior: "+whatbehavior, width/2, 50);
  }
}
