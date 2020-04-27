// inspired by: https://www.openprocessing.org/sketch/816655
// lightning fork inspired by: https://www.openprocessing.org/sketch/2924
// Attribute: "Lightning Storm" by Esteban Hufstedlerhttp://www.openprocessing.org/sketch/2924Licensed under Creative Commons Attribution ShareAlikehttps://creativecommons.org/licenses/by-sa/2.0https://creativecommons.org/licenses/GPL/2.0/

ArrayList<PVector> points;
Bolt bolt;

PVector pos;

float maxDTheta = PI/10;
float minDTheta = PI/20;
float maxTheta = PI/2;
float childGenOdds = .01;

float minBoltWidth = 3;
float maxBoltWidth = 10;

float minJumpLength = 1;
float maxJumpLength = 10;

void setup() {
  size(600, 600);
  background(0);
  pos = new PVector(random(0, 600), 0);
  bolt = new Bolt(pos, random(minBoltWidth,maxBoltWidth),0,minJumpLength,maxJumpLength);
}

void draw() {
  bolt = new Bolt(pos,random(minBoltWidth,maxBoltWidth),0,minJumpLength,maxJumpLength);
  bolt.draw();
}

// returns +1 or -1 
int randomSign() {
  float num = random(-1, 1);
  if (num == 0) {
    return -1;
  } else {
    return (int)(num/abs(num));
  }
}
