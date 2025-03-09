class Dot {

  PVector location, seekLocation;
  color kuler;
  int op, topspeed;
  PVector acc, velocity;
  float maxspeed, maxforce, startHover;
  boolean up, down, hover, seek_arrive;
  float duration_interval, ylow, yhigh, timeStamp;


  Dot(int x, int y, color k) {
    location = new PVector(x, y);
    kuler = k;
    op = 50;
    acc = new PVector(0.001, .001);

    maxspeed = 4;
    maxforce = 0.1;

    velocity = PVector.random2D(); //new PVector(0, 0);
    velocity.mult(0.5);
    topspeed = 1;
    up = true;
    down = false;
    hover = false;
    startHover = 0;
    hover = false;
    //seek = true;
    //arrive = false;
    duration_interval = random(15, 90);
    timeStamp = 0;
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

  void seek_arrive(PVector goal, boolean h) {
    //individual's duration set here for how long should hover
    //duration = random(1000, 5000);
    //print("duration is: ");
    //println(duration);
    PVector desired = PVector.sub(goal, location);
    float d = desired.mag();
    if (d < 150 && d > 10) {
      float m = map(d, 0, 100, 0, maxspeed);
      desired.setMag(m);
    } else if (( d <= 10) && (h == false) ) {
      hover = true;
      startHover = millis();
     // print("startHover is: ");
      //println("startHover");
      h = true;
    } else {
      desired.setMag(maxspeed);
      hover = false;
      h = false; // put this here?
    }
    //steering = desired - velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    acc.add(steer);
  }

  void hover(PVector home, float yLow, float yHigh) {
     
    //up and down
    //for a certain amount of time
    // once in a while, slight back and forth
      if (down == true) {
        if (location.y <= yLow && location.y >= home.y) { 
          location.y++;
        } else {
          down = false;
          up = true;
        }
      }  //down
      else if (up == true) {
        if (location.y >= yHigh && location.y >= home.y) {
          location.y--;
        } else {
          up = false;
          down = true;
        }
      } //up
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

  void display(float d) {
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
    stroke(255, 0, 0);
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
