// M_2_2_01.pde
//
// Generative Gestaltung, ISBN: 978-3-87439-759-9
// First Edition, Hermann Schmidt, Mainz, 2009
// Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// Copyright 2009 Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
//
// http://www.generative-gestaltung.de
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/**
 * draws a lissajous curve
 *
 * KEYS
 * a                 : toggle oscillation animation
 * 1/2               : frequency x -/+
 * 3/4               : frequency y -/+
 * arrow left/right  : phi -/+
 * s                 : save png
 * p                 : save pdf
 */


import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;
boolean drawText = true;

int pointCount = 600;
int freqX = 1;
int freqY = 2;
float phi = 90;

float angle;
float x, y;
float factorX, factorY;

boolean doDrawAnimation = true;

int margin = 25;
PFont font;
int fontSize;
PImage text;


ArrayList<Dot>dots;

//Dot dot;


void setup() {
  size(600, 600);
  //size(900, 900);
  smooth();
  fontSize = 42;
  font = createFont("data/NotoSerifJP-Regular.ttf", fontSize);
  //textSize(fontSize);
  textFont(font, fontSize);//**
  
  //text = loadImage("logo_text.png");


  ///drawText();


  dots = new ArrayList<Dot>();

  for (int i = 0; i <= 5; i++) { // make limit 0 to turn off
    //Dot dot = new Dot( int(random(100, 400)), int(random(100, 400) ), color(255, 0, 0) );
    //append(dots, dot); //dots.append(dot);
    dots.add(new Dot( int(random(150, 350)), int(random(150, 350) ), color(255, 0, 0) ));
  }
  
}


void draw() {

  
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");
  // if (savePDF) beginRecord(PDF, freqX+"_"+freqY+"_"+int(phi)+".pdf");

    background(255);
 // /*
  if (drawText) {
   //drawText(); //**
   }
 //  */
  


   if (doDrawAnimation) {
   // this is the one
   
   //translate(width*3/4.0, height*3/4.0);
   translate(width/2, height/2); //**
   factorX = width/4-margin;
   factorY = height/4-margin;
   } /* else {
  
   translate(width/2, height/2);
   factorX = width/2-margin;
   factorY = height/2-margin;
   } */
  
 // popMatrix();
  //   */

  noFill();
  stroke(0);
  strokeWeight(1);
  //draws a shape
  beginShape();
  ///*
  for (int i=0; i<=pointCount; i++) {
    angle = map(i, 0, pointCount, 0, TWO_PI);

    x = sin(angle*freqX + radians(phi));
    y = sin(angle*freqY);

    x = x * factorX;
    y = y * factorY;

    vertex(x, y);
  }
  //*/
  endShape();
  pushMatrix();
  translate(-width/2, -height/2);
  //different colors; different widths (small large
  for (int i = 0; i < dots.size() - 1; i++) {
    //dots[i].display();
    Dot d = dots.get(i);
    //****
    int x, y;
    //random 2D location to zip over; arrive; hover
    x = int(random(0, width));
    y = int(random(0, height));
    PVector newSpot = new PVector(x, y);

    d.zipOver(newSpot); // need to program this
    //d.update();
    d.arrive(newSpot, false);
    //if we've arrived and hover is flipped on:
    if (d.hover == true) { // hover the boolean variable
      //should these nxt 4 lines be here?:
      //pick a length of time to hover:
      float amount = random(20, 60);
      d.ylow = d.location.y + amount; //lower area on screen
      d.yhigh = d.location.y - amount; // upper area on screen
      //if our current time - startHover time is less than out duration
      if (millis() - d.startHover < d.duration) { //over all hover
        d.hover(newSpot, d.ylow, d.yhigh); // if we are there, hover
      } else {
        println("no longer hovering");
      }
    }


    d.update(); //add the motion to location
    d.playground(); // stay within the area
    d.display(random(80));
  }
 

  /*
  if (doDrawAnimation) {
   drawAnimation();
   }
   */



  if (savePDF) {
    savePDF = false;
    println("saving to pdf – finishing");
    endRecord();
  }

  //pushMatrix();
  //translate(width/2, height/2);
  if (drawText) {
    drawText();
  }
  popMatrix();

  
}

void drawText() {
  //text
  //pushMatrix();
  //translate(width*3/4.0, height*3/4.0);
  fill(0, 200);
  noStroke();
  //rect(width/2 - 5, height/2+130, 300, 50);
  //rect(-160, -25, 320, 60);
  rect(140, 275, 320, 60); //soften edges

  fill(255);
  //text("LadyK Studios", width/2, height/2 +170);
  text("LadyK Studios", 155, 320);
  stroke(0);
  
  //  pushMatrix();
  //scale(.5);
  //image(text, 155, 320);
  //  image(text, width/2, height/32);
  // popMatrix();
}


void drawAnimation() {

  pushStyle();
  noFill();

  // draw x oscillator
  stroke(0);
  /*
  beginShape();
   for (int i=0; i<=pointCount; i++){
   angle = map(i, 0,pointCount, 0,TWO_PI);
   x = sin(angle*freqX + radians(phi));
   x = x * (width/4-margin);
   y = -height*2/3.0-margin + (float)i/pointCount * (height/2-2*margin);
   vertex(x, y);
   }
   endShape();
   */
  /*
  // draw y oscillator
   stroke(0);
   beginShape();
   for (int i=0; i<=pointCount; i++){
   angle = map(i, 0,pointCount, 0,TWO_PI);
   y = sin(angle*freqY);
   y = y * (height/4-margin);
   x = -width*2/3.0-margin + (float)i/pointCount * (width/2-2*margin);
   vertex(x, y);
   }
   endShape();
   */

  /*
  angle = map(frameCount, 0,pointCount, 0,TWO_PI);
   x = sin(angle*freqX + radians(phi));
   y = sin(angle*freqY);
   x = x * (width/4-margin);
   y = y * (height/4-margin);
   */
  // float oscYx = -width*2/3.0-margin + (angle/TWO_PI)%1 * (width/2-2*margin);
  //  float oscXy = -height*2/3.0-margin + (angle/TWO_PI)%1 * (height/2-2*margin);

  //  stroke(0, 80);
  // line(x, oscXy, x, y);
  // line(oscYx, y, x, y);
  /*
  fill(0);
   stroke(255);
   strokeWeight(2);
   */
  // ellipse(x, oscXy, 8, 8);
  // ellipse(oscYx, y, 8, 8);

  // ellipse(x, y, 10, 10);

  popStyle();
}





void keyPressed() {
  ///*
  if (key == 's' || key == 'S') saveFrame(timestamp()+".png");
  if (key == 'p' || key == 'P') {
    savePDF = true;
    println("saving to pdf - starting");
  }
  // */

  // if (key == 'a' || key == 'A') doDrawAnimation = !doDrawAnimation;

  if (key == '1') freqX--;
  if (key == '2') freqX++;
  freqX = max(freqX, 1);

  if (key == '3') freqY--;
  if (key == '4') freqY++;
  freqY = max(freqY, 1);

  if (keyCode == LEFT) phi -= 15;
  if (keyCode == RIGHT) phi += 15;

  println("freqX: " + freqX + ", freqY: " + freqY + ", phi: " + phi);
}

//*
String timestamp() {
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", Calendar.getInstance());
}//*/

void mousePressed() {
  print("x: " + mouseX);
  println("y: " + mouseY);
}
