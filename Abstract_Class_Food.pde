abstract class Food {
  PVector pos;
  color c;
  int size;

  int saturation;
  
  int counter;
  int timer;
  
  void display() {
    fill(c);
    circle(pos.x, pos.y, size);
  }
  
  boolean eaten(Animal _target) { return false; }
  boolean spawn() { return false; }
}
