class Herbivore extends Animal {
  Herbivore(PVector _pos, float _maxspeed, float _maxforce, float _range) {
    accel = new PVector(0, 0);
    vel = new PVector(0, 0);
    pos = _pos;
    size = 5.5;
    maxspeed = _maxspeed;
    oldMaxSpeed = _maxspeed;
    maxforce = _maxforce;
    desired = new PVector(width/2, height/2);
    counter = 500;  //How often wander acours in milliseconds
    timer = millis();
    range = _range;
  }
  void move(Animal _target) {
    if (pos.x < 25) {
      //[offset-down] Make a desired vector that retains the y direction of
      // the vehicle but points the x direction directly away from
      // the window’s left edge.
      desired = new PVector(maxspeed, vel.y);
    } else if (pos.x > width - 25){
      desired = new PVector(-maxspeed, vel.y);
    } else if (pos.y < 25) {
      desired = new PVector(maxspeed, vel.x);
    } else if (pos.y > height - 25){
      desired = new PVector(-maxspeed, vel.x);
    } else if (dist(pos.x, pos.y, _target.pos.x, _target.pos.y) < range) { //Starts the fleeing behavior
      flee(_target);
      maxspeed *= 1.1; //Makes the pray move faster when it flees
    } else if (millis() - timer > counter) {   //starts the animals wandering behavior 
      wander();
      timer = millis();
      print(" H:"+timer/500);  //debug
    }

    if (dist(pos.x, pos.y, _target.pos.x, _target.pos.y) > _target.range*2) { // makes so the prey stop running fast when the hunter is not there
      maxspeed = oldMaxSpeed;
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
  void flee(Animal _target) {
    desired = PVector.sub(_target.pos, pos).mult(-1);
    desired.normalize();
    desired.mult(maxspeed);
  }
  boolean isEaten(Animal _target) { //determins if ther herbivore is eaten or not
    if (dist(_target.pos.x, _target.pos.y, pos.x, pos.y) <= 5) {
       return true;
    } else {
      return false;
    }
  }
}
