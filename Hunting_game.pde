Animal prey;

void setup(){
  size(640, 480);
  prey = new Herbivore(new PVector(100, height/2), 3, 0.1);
}

void draw(){
  background(151);
  prey.move();
  prey.update();
  prey.display(0,0,0);
  
  textSize(128);
  textAlign(CENTER);
  text(millis()/500, width/2, height/2);
}
