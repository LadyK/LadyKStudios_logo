class Dot {

  PVector location, seekLocation, hoverCenter;
  color kuler;
  int op, topspeed;
  PVector acc, velocity;
  float maxspeed, maxforce, startHover;
  boolean up, down, hover, seek_arrive, hoverFirst, hoverDone;
  float duration_interval, ylow, yhigh, timeStamp, unique;


  Dot(int x, int y, color k) {
    location = new PVector(x, y);
    seekLocation = new PVector(width/2, height/2);
    kuler = k;
    op = 50;
    acc = new PVector(0.001, .001);

    maxspeed = 24; //4
    maxforce = 0.5;

    velocity = PVector.random2D(); //new PVector(0, 0);
    velocity.mult(0.5);
    topspeed = 1;
    up = true;
    down = false;
    hover = false;
    hoverDone = false;
    startHover = 0;
    hoverCenter = location.copy();
    //seek = true;
    //arrive = false;
    duration_interval = random(15000, 90000);
    println(duration_interval);
    timeStamp = 0;
    hoverFirst = true; //is it our first time through hovering?
  }

  void update() {
    //op = int(random(50, 40));
    velocity.add(acc);
    velocity.limit(topspeed);
    location.add(velocity);
    acc.mult(0);
  }

  void seek(PVector goal) {  // a random new spot on the play ground is chosen & passed
    //steering
    //faster acceleration towards goal
  }

  void seek_arrive(boolean h) {
    //individual's duration set here for how long should hover
    //duration = random(1000, 5000);
    //print("duration is: ");
    //println(duration);
    println("seeking_arrive active");
    PVector desired = PVector.sub(seekLocation, location);
    float d = desired.mag();
    if (d < 250 && d > 20) { // once we get close to location, slow down
      float m = map(d, 0, 100, 0, maxspeed);
      desired.setMag(m);
    } else if (( d <= 20) && (h == false) ) { //if we are close, and not hovering
      //getting close to target
      // go through initialization period: (dbl check placement and for dups
      hover = true;

      startHover = millis();
      velocity.set(0, 0);
      seek_arrive = false;
      h = true;
      hoverCenter = location.copy(); // lock into position to hover
    } else {
      println("MEEEEEEEEEEE");
      desired.setMag(maxspeed);
      hover = false;
      //h = false; // put this here?
    }
    //steering = desired - velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    acc.add(steer);
  }

  void hoverFirst_function() {
    float amount, time_startHover;
    time_startHover = millis() - startHover; //subtract current time from trigger
    if (hoverFirst == true) {
      //the hover span
      amount = random(100, 200); //distance/span of hover
      ylow = location.y + amount; //lower area on screen
      yhigh = location.y - amount; // upper area on screen
      hoverFirst = false;
    }
    if ( time_startHover < duration_interval) { // hover
      //print("time_startHover  ");
      //println(time_startHover);
      //print("d.duration_interval is:  ");
      //println(d.duration_interval);
      println("hover active");
      hover(ylow, yhigh); // if we are there, hover
    }// we are not hovering
    else {
      println("not hoovering");
      hover = false;
      hoverFirst = true;
      hoverDone = true;
      duration_interval = random(5000, 10000); //pick new duration
    }
  }

  void hover(float yLow, float yHigh) {
    /*
    println("hovering");
    float hoverSpeed = 1.2;
    //up and down
    //for a certain amount of time
    // once in a while, slight back and forth
    if (down == true) {
      if (location.y >= yLow) {
        down = false;
        up = true;
      }
    }  //down
    else if (up == true) {
      location.y -= hoverSpeed;
      if (location.y <= yHigh) {
        up = false;
        down = true;
      }
    } //up
    */

    float hoverRange = 10;
    float flickerRange = 4;
    //float centerY = location.y;
    //float centerX = location.x;
    float t = (millis() - startHover) / 400.0;
    location.y = hoverCenter.y + sin(t) * hoverRange; //sin(t * TWO_PI)
    location.x = hoverCenter.x + sin(t * 1.5) * flickerRange ;
  } //hover




  void playground() {
    if (location.x < 150 ) {
      velocity.x = velocity.x * -1; //= 350;
    }
    if (location.x > 420) {
      velocity.x = velocity.x * -1; //= 150;
    }

    if (location.y < 150 ) {
      velocity.y *= -1; //350;
    }
    if (location.y > 420) {
      velocity.y *= -1; // 150;
    }
  }
  color runColor() {
    /*
    float angle = 0;
     float k;
     k = sin(angle) + PI *100;
     //if(k > 255) k= 0;
     angle += 0.02;
     kuler = color(k);*/
    float secs = millis()*.001 + unique;
    int r = (int) (sin(secs)*128+128);
    int g = (int) (sin(secs + 2)*128+128);
    int b = (int) (sin(secs + 4)*128+128);
    return kuler = color(r, g, b);
  }

  void display(float d) {
    kuler = runColor();
    float rand = random(0, 5);
    float d_mapped;
    if (rand > 3) {
      d_mapped = map(d, 100.0, 0.0, 12.0, 3.0);
    } else {
      d_mapped = 10;
    }
    //background(255);
    //pushMatrix();
    //translate(width*3/4.0, height*3/4.0);
    stroke(kuler);
    strokeWeight(1);
    noFill();
    ellipse(location.x, location.y, 20, 20); //ring
    //fill(kuler);
    //ellipse(location.x, location.y, 10, 10);

    //bands:

    //if(frameCount % 13 == 0){

    // }
    //inbetween
    fill(kuler, op);
    noStroke();
    for (int i = 8; i >= 0; i-=3) {
      // stroke(kuler, op );
      //ellipse(location.x, location.y, i, i);
      ellipse(location.x, location.y, i*3, i*3);
    }
    noStroke();
    fill(kuler);
    ellipse(location.x, location.y, d_mapped, d_mapped);
    // popMatrix();
  }
}
