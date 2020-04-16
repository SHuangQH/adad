// inspired by: https://www.openprocessing.org/sketch/816655
// lightning fork inspired by: https://www.openprocessing.org/sketch/2924
// Attribute: "Lightning Storm" by Esteban Hufstedlerhttp://www.openprocessing.org/sketch/2924Licensed under Creative Commons Attribution ShareAlikehttps://creativecommons.org/licenses/by-sa/2.0https://creativecommons.org/licenses/GPL/2.0/

ArrayList<PVector> points;
Bolt bolt;

void setup() {
  size(600, 600);
  background(0);
}

void draw() {
  background(0); // removes the previous lightning strike from screen 
  frameRate(6); // slows it down

  //noStroke();
  //fill(0, 24);
  //rect(0, 0, width, height);

  // decide when to make a lightning strike
  //if (random(100) < 10) {  or maybe could milliseconds?
  bolt.strike();
  //}
}
