Animal prey[] = new Animal[5]; //don't use anymore
Animal hunter;
ArrayList<Animal> newPrey = new ArrayList<Animal>(); // it is the new prey

float close[] = new float[15]; //varibals for hunter to chose target. Needs to be the same as how many prey there are
int targetObj;
float oldD = width * height;
float newD;

void setup() {
  fullScreen();
  //size(640, 480);
  for (int i = 0; i < prey.length; i++) {
    prey[i] = new Herbivore(new PVector(random(width), random(height)), 3, 0.1, 100);
    //PVector _pos, float _maxspeed, float _maxforce, float _range
  }
  for (int i = 0; i < close.length; i++) {
    newPrey.add(new Herbivore(new PVector(random(width), random(height)), 3, 0.1, 100));
  }
  hunter = new Carnivore(new PVector(random(width), random(height)), 3, 0.9, 200);
  //PVector _pos, float _maxspeed, float _maxforce, float _range
}

void draw() {
  background(151);
  //for (int i = 0; i < prey.length; i++) {
  //  prey[i].move(hunter);
  //  prey[i].update();
  //  prey[i].display(0, 0, 0);

  //  close[i] = dist(hunter.pos.x, hunter.pos.y, prey[i].pos.x, prey[i].pos.y); //hunter choses closes target
  //  newD = close[i];
  //  if (oldD > newD) {
  //    oldD = newD;
  //    targetObj = i;
  //  }
  //}
  for (int i = newPrey.size()-1; i >= 0; i--) { //runs the prey
    Animal nextPrey = newPrey.get(i);
    nextPrey.move(hunter);
    nextPrey.update();
    nextPrey.display(0, 0, 255);
    if (nextPrey.isEaten(hunter)) { //delets the prey if it's eaten
      newPrey.remove(i);
    }


    for (int j = 0; j < newPrey.size(); j++) { // chooses the target the hunter goes after. Might not work rigt now
      close[j] = dist(hunter.pos.x, hunter.pos.y, nextPrey.pos.x, nextPrey.pos.y);
      newD = close[j];
      if (oldD > newD) {
        oldD = newD;
        targetObj = j;
      }
    }
  }
  hunter.move(newPrey.get(targetObj));
  //hunter.move(prey[targetObj]);
  hunter.update();
  hunter.display(255, 0, 0);

  hunter.debug();

  fill(0);
  textSize(25);
  textAlign(CENTER);
  text("prey = "+newPrey.size(), width/2, 100);

  fill(0);    //debug
  textSize(128);
  textAlign(CENTER);
  text(millis()/500, width/2, height/2);
}
