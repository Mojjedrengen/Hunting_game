Animal hunter;
int startPrey = 20;
ArrayList<Animal> newPrey = new ArrayList<Animal>(); // it is the new prey
ArrayList<Food> apples = new ArrayList<Food>(); // apple does not currently work
ArrayList<Float> closes = new ArrayList<Float>(); //varibals for hunter to chose target. Needs to be the same as how many prey there are
int targetObj;
float oldD = width * height;
float newD;
int Atimer = millis(); //timer to spawn apples
int Acounter = 5000;   //counter to spawn apples
boolean wasEaten = false; //tells if a prey was eaten
int whoEaten; //tels which one was eaten
int awhoEaten;
boolean awasEaten = false;

void setup() {
  fullScreen();
  //size(640, 480);
  for (int i = 0; i < startPrey; i++) {
    newPrey.add(new Herbivore(new PVector(random(width), random(height)), 3, 0.1, 100));
    closes.add(width*height*0.9);
  }
  hunter = new Carnivore(new PVector(random(width), random(height)), 3, 0.9, 200);
  //PVector _pos, float _maxspeed, float _maxforce, float _range
  apples.add(new Apple(new PVector(random(width), random(height))));
}

void draw() {
  background(151); 
  for (int i = apples.size()-1; i >= 0; i--) { // loop to run apples
    Food apple = apples.get(i);
    apple.display();

    for (int j = 0; j < newPrey.size(); j++) {
      Animal nextPrey = newPrey.get(j);
      if (apple.eaten(nextPrey)) {
        awasEaten = true;
        awhoEaten = i;
        print(" Eaten "+j);
      }
    }
  }
  if (millis() - Atimer > Acounter) { //spawns apples every second
    apples.add(new Apple(new PVector(random(width), random(height))));
    Atimer = millis();
    print("new apple");
  }

  for (int i = newPrey.size()-1; i >= 0; i--) { //runs the prey
    Animal nextPrey = newPrey.get(i);
    nextPrey.move(hunter);
    nextPrey.update();
    nextPrey.display(0, 0, 255);
    if (nextPrey.isEaten(hunter)) { //delets the prey if it's eaten
      wasEaten = true;
      whoEaten = i;
      print(" "+i+" was eaten");
    }

    preyDebug(i, nextPrey); // can only show 14 diffrent prey

    closes.set(i, dist(hunter.pos.x, hunter.pos.y, nextPrey.pos.x, nextPrey.pos.y)); // chooses the target the hunter goes after
    newD = closes.get(i);
    if (oldD > newD) { 
      oldD = newD;
      targetObj = i;
    }
  }

  hunter.move(newPrey.get(targetObj));
  oldD = width*height; // resets oldD
  hunter.update();
  hunter.display(255, 0, 0);
  
  if (wasEaten == true) { // eats the prey. 
    wasEaten = false;
    int preySize = newPrey.size()-1;
    print(preySize);
    newPrey.set(whoEaten, newPrey.get(preySize)); 
    newPrey.remove(preySize);
    closes.remove(preySize); 
  }
  if (awasEaten == true) { // eats the apple. 
    awasEaten = false;
    int appleSize = apples.size()-1;
    print(appleSize);
    apples.set(awhoEaten, apples.get(appleSize)); 
    apples.remove(appleSize);
  }

  debug();
}
