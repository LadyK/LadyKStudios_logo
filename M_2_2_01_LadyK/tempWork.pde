/*
for (int i = 0; i < dots.size() - 1; i++) {
  Dot d = dots.get(i); // array list vs array
  //****

  //d.zipOver(newSpot); // need to program this
  //d.update();
  //d.arrive(newSpot, false);
  //PVector m = new PVector(mouseX, mouseY);
  //d.arrive(m, false);

  //if we've arrived and hover is flipped on:
  if (d.hover == true) { // hover the boolean variable
    //should these nxt 4 lines be here?:
    //pick a length of time to hover:
    float amount = random(20, 180);
    d.ylow = d.location.y + amount; //lower area on screen
    d.yhigh = d.location.y - amount; // upper area on screen
    //if our current time - startHover time is less than out duration
    if (millis() - d.startHover < d.duration) { //over all hover
      println("hovering");
      d.hover(newSpot, d.ylow, d.yhigh); // if we are there, hover
    } else {
      println("no longer hovering"
    }
  } else if (d.hover == false) {
    int x, y;
    x = int(random(150, 460)); //must be on within the playground
    y = int(random(140, 430));
    PVector newSpot = new PVector(x, y);
    //pass newSpot to array
    //Don't want to call the method; just pass variables --> i.seek(newSpot_bool)
    temp.seekLocation = newSpot;
    temp.seek = true; //flip seek on
    temp.hoverDuration = random(15, 90); //new hover duration
    temp.acc = new PVector(0.001, .001); // new speed

    d.seek_arrive(newSpot, false);
  }

  d.update(); //add the motion to location
  d.playground(); // stay within the area
  d.display(random(80));
}

// set new data for each dot:
for (int i = 0; i < dots.size(); i++) {
  Dot temp = dots.get(i);
  // new location to seek/zip/arrive
  if (temp.hover == false) { // if our hover time is up
    int x, y;
    x = int(random(150, 460)); //must be on within the playground
    y = int(random(140, 430));
    PVector newSpot = new PVector(x, y);
    //pass newSpot to array
    //Don't want to call the method; just pass variables --> i.seek(newSpot_bool)
    temp.seekLocation = newSpot;
    temp.seek = true; //flip seek on
    temp.hoverDuration = random(15, 90); //new hover duration
    temp.acc = new PVector(0.001, .001); // new speed
  } else
    if (temp.hover == true) {
      println("I should be hovering");
    }
  //seek
  //arrive
  //hover
}
  */
