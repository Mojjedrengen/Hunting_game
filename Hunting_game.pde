Animal prey[] = new Animal[5];
Animal hunter;

float close[] = new float[5];
int targetObj;
float oldD = width * height;
float newD;

void setup() {
  fullScreen();
  //size(640, 480);
  for (int i = 0; i < prey.length; i++) {
    prey[i] = new Herbivore(new PVector(random(width), random(height)), 3, 0.1);
  }
  hunter = new Carnivore(new PVector(random(width), random(height)), 3, 0.9);
}

void draw() {
  background(151);
  for (int i = 0; i < prey.length; i++) {
    prey[i].move();
    prey[i].update();
    prey[i].display(0, 0, 0);

    close[i] = dist(hunter.pos.x, hunter.pos.y, prey[i].pos.x, prey[i].pos.y);
    newD = close[i];
    if (oldD>newD) {
      oldD = newD;
      targetObj = i;
    }
  }
  
  hunter.move(prey[targetObj]);
  hunter.update();
  hunter.display(255, 0, 0);


  fill(0);
  textSize(128);
  textAlign(CENTER);
  text(millis()/500, width/2, height/2);
}
