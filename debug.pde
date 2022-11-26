void debug() {
  hunter.debug();

  fill(0);  //shows how many prey there are
  textSize(25);
  textAlign(CENTER);
  text("prey = "+newPrey.size(), width/2, 100);

  text("targeting: "+targetObj, width/2, 150); //shows who the hunter is targeting

  textSize(128);  //debug
  text(millis()/500, width/2, height/2);

  for (int i = 0; i < close.length; i++ ) { // shows how close the prey is to the hunter 
    textSize(25);
    textAlign(LEFT);
    text("close["+i+"] = "+int(close[i]), 30, 50*i+50);
  }
}

void preyDebug(int _i, Animal _target) { // can only show 14 diffrent prey
  fill(0);
  textSize(25);
  textAlign(RIGHT);
  text("Prey["+_i+"]", width-30, 100*_i+25);
  text("Speed "+int(_target.maxspeed), width-30, 100*_i+50);
  text("hunger "+_target.hunger, width-30, 100*_i+75);
}
