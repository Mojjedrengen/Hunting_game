class Apple extends Food {
  Apple(PVector _pos) {
    pos = _pos;
    c = #EE1D10;
    size = 25;
    saturation = 35;
    
    timer = millis();
    counter = 1000;
  }
  
  boolean eaten(Animal _target) {
    if(dist(_target.pos.x, _target.pos.y, pos.x, pos.y) <= size) {
      _target.hunger += saturation;
      return true;
    } else {
      return false;
    }
  }
  
  boolean spawn() { 
    if(millis() - timer > counter) {
      timer = millis();
      print("new apple");
      return true;
    } else {
      return false;
    }
  }
}
